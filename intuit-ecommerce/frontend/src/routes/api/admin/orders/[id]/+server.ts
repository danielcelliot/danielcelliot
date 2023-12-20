import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { MEDUSA_BACKEND_URL } from '$env/static/private';

// Get an Order
// https://docs.medusajs.com/api/admin#orders_getordersorder
export const GET: RequestHandler = async ({ fetch, cookies, params }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/orders/${params.id}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { order } = await response.json();
		return json(order);
	}

	return formatErrorResponse(response);
};
