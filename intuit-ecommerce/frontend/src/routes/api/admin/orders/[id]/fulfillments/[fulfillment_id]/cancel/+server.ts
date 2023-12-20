import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Cancel a Fulfillment
// https://docs.medusajs.com/api/admin#orders_postordersorderfulfillmentscancel
export const POST: RequestHandler = async ({ fetch, cookies, params }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/admin/orders/${params.id}/fulfillments/${params.fulfillment_id}/cancel`,
		{
			headers: {
				Cookie: `connect.sid=${sessionCookie}`
			},
			method: 'POST'
		}
	);

	if (response.ok) {
		const { order } = await response.json();
		return json(order);
	}

	return formatErrorResponse(response);
};
