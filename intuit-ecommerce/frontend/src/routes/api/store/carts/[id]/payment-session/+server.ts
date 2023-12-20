import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Select a Payment Session
// https://docs.medusajs.com/api/store#carts_postcartscartpaymentsession
export const POST: RequestHandler = async ({ fetch, params, request }) => {
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts/${params.id}/payment-session`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	});

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};
