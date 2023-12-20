import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Create a Fulfillment
// https://docs.medusajs.com/api/admin#orders_postordersorderfulfillments
export const POST: RequestHandler = async ({ fetch, cookies, request, params }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/orders/${params.id}/fulfillment`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`,
			'Content-Type': 'application/json'
		},
		method: 'POST',
		body: JSON.stringify({ ...body })
	});

	if (response.ok) {
		const { order } = await response.json();
		return json(order);
	}

	return formatErrorResponse(response);
};
