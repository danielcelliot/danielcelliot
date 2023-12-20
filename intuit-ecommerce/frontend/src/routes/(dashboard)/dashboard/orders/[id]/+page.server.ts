import { fail, type Action, type Actions, error } from '@sveltejs/kit';
import { redirect } from 'sveltekit-flash-message/server';
import { message, superValidate } from 'sveltekit-superforms/server';
import type { PageServerLoad } from './$types';
import { FulfillmentStatus, type Order } from '$lib/types/medusa';
import { cancelFulfillmentSchema, fulfillItemsSchema, shipItemsSchema } from '$lib/schemas/order';
import { handleAdminLoginRedirect, handleFailedStatus } from '$lib/server/shop';

const ship: Action = async (event) => {
	const form = await superValidate(event.request, shipItemsSchema);
	if (!form.valid) return fail(400, { form });

	const response = await event.fetch(`/api/admin/orders/${form.data.order_id}/shipment`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			fulfillment_id: form.data.fulfillment_id,
			tracking_numbers: [form.data.tracking_number ?? ''],
			no_notification: false
		})
	});

	if (response.ok) {
		const order = (await response.json()) as Order;

		if (order && order.fulfillment_status == FulfillmentStatus.SHIPPED)
			await event.fetch(`/api/admin/orders/${order.id}/complete`);

		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Your package has been marked as shipped.'
			},
			event
		);
	}

	await handleFailedStatus(response, event);

	throw redirect(
		event.url.pathname,
		{
			type: 'error',
			message: 'Unable to change package status.'
		},
		event
	);
};

const cancelFulfill: Action = async (event) => {
	const form = await superValidate(event.request, cancelFulfillmentSchema);
	if (!form.valid) return fail(400, { form });

	const response = await event.fetch(
		`/api/admin/orders/${form.data.order_id}/fulfillments/${form.data.fulfillment_id}/cancel`,
		{
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			}
		}
	);

	if (response.ok)
		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Your fulfillment has been cancelled.'
			},
			event
		);

	await handleFailedStatus(response, event);

	throw redirect(
		event.url.pathname,
		{
			type: 'error',
			message: 'Unable to cancel fulfillment.'
		},
		event
	);
};

const fulfill: Action = async (event) => {
	const form = await superValidate(event.request, fulfillItemsSchema);
	if (!form.valid) return fail(400, { form });
	const items = form.data.items
		.map((item) => {
			if (item.quantity > 0) return { item_id: item.id, quantity: item.quantity };
		})
		.filter((item): item is Exclude<typeof item, undefined> => item !== undefined);

	if (items.length === 0)
		return message(
			form,
			{ type: 'error', text: 'At least one item must have a quantity of 1 or more.' },
			{
				status: 400
			}
		);

	const response = await event.fetch(`/api/admin/orders/${form.data.order_id}/fulfillments`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(items)
	});

	if (response.ok)
		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Your fulfillment has been created.'
			},
			event
		);

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to create fulfillment.' }, { status: 400 });
};

export const actions: Actions = { ship, cancelFulfill, fulfill };

export const load: PageServerLoad = async (event) => {
	const fetchOrder = async () => {
		const response = await event.fetch(`/api/admin/orders/${event.params.id}`);

		if (response.ok) return (await response.json()) as Order;
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [order, fulfillForm, shipmentForm, cancelFulfillmentForm] = await Promise.all([
		fetchOrder(),
		superValidate(fulfillItemsSchema),
		superValidate(shipItemsSchema),
		superValidate(cancelFulfillmentSchema)
	]);

	return {
		order,
		fulfillForm,
		shipmentForm,
		cancelFulfillmentForm
	};
};
