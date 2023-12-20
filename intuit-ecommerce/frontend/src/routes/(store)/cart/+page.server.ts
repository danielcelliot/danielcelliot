import { fail, type Action, type Actions, error } from '@sveltejs/kit';
import { message, superValidate } from 'sveltekit-superforms/server';
import {
	checkoutLineItemsSchema,
	deleteLineItemSchema,
	updateLineItemSchema
} from '$lib/schemas/cart';
import type { CartPageData } from '$lib/types/shop';
import { redirect } from 'sveltekit-flash-message/server';
import type { Customer } from '$lib/types/medusa.js';
import { PUBLIC_STORE_CART_COOKIE_NAME } from '$env/static/public';

const update: Action = async ({ fetch, request }) => {
	const form = await superValidate(request, updateLineItemSchema);
	if (!form.valid) return fail(400, { form });

	const response = await fetch(
		`/api/store/carts/${form.data.cart_id}/line-items/${form.data.item_id}`,
		{
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				quantity: form.data.quantity
			})
		}
	);

	return response.ok
		? message(form, { type: 'success', text: 'Item quantity has been updated' })
		: message(form, {
				type: 'error',
				text: 'Unable to update item quantity'
		  });
};

const remove: Action = async ({ fetch, request }) => {
	const form = await superValidate(request, deleteLineItemSchema);
	if (!form.valid) return fail(400, { form });

	const response = await fetch(
		`/api/store/carts/${form.data.cart_id}/line-items/${form.data.item_id}`,
		{ method: 'DELETE' }
	);

	return response.ok
		? message(form, { type: 'success', text: 'Item removed from your bag' })
		: message(form, {
				type: 'error',
				text: 'Unable to remove item from your bag'
		  });
};

const checkout: Action = async ({ request, fetch }) => {
	const form = await superValidate(request, checkoutLineItemsSchema);
	if (!form.valid) return fail(400, { form });

	const response = await fetch(`/api/store/carts/${form.data.cart_id}/payment-sessions`, {
		method: 'POST'
	});

	throw response.ok ? redirect(303, '/checkout') : error(500, { message: 'Internal error' });
};

export const actions: Actions = { remove, update, checkout };

export async function load({ fetch, cookies }) {
	const getCart = async () => {
		const fetchCart = async (id: string) => {
			const response = await fetch(`/api/store/carts/${id}`);

			if (response.ok) {
				return (await response.json()) as CartPageData;
			}

			return null;
		};

		let cart: CartPageData | null = null;

		// Get cart_id from customer session
		const response = await fetch('/api/store/customers/me');

		if (response.ok) {
			const customer = (await response.json()) as Customer;
			if (customer.metadata?.cart_id) cart = await fetchCart(customer.metadata.cart_id);
		}

		if (!cart) {
			// Get cart_id from cookie
			const cartId = cookies.get(PUBLIC_STORE_CART_COOKIE_NAME);
			if (cartId) cart = await fetchCart(cartId);
		}

		return cart;
	};

	const [cart, updateItemForm, deleteItemForm, checkoutForm] = await Promise.all([
		getCart(),
		superValidate(updateLineItemSchema),
		superValidate(deleteLineItemSchema),
		superValidate(checkoutLineItemsSchema)
	]);

	return {
		cart,
		updateItemForm,
		deleteItemForm,
		checkoutForm
	};
}
