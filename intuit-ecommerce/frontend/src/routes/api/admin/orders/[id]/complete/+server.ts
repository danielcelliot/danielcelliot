import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { MEDUSA_BACKEND_URL } from '$env/static/private';

// Complete an Order
// https://docs.medusajs.com/api/admin#orders_postordersordercomplete
export const POST: RequestHandler = async ({ fetch, cookies, params }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/orders/${params.id}/complete`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		},
		method: 'POST'
	});

	if (response.ok) {
		const { order } = await response.json();
		return json(order);
	}

	return formatErrorResponse(response);
};
