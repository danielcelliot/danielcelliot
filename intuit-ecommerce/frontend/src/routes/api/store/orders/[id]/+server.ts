import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

// Get an Order
// https://docs.medusajs.com/api/store#orders_getordersorder
export const GET: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/orders/${params.id}`);

	if (response.ok) {
		const { order } = await response.json();
		return json(order);
	}

	return formatErrorResponse(response);
};
