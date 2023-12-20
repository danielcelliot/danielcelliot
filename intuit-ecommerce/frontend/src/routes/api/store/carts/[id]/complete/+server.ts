import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Complete a Cart
// https://docs.medusajs.com/api/store#carts_postcartscartcomplete
export const POST: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts/${params.id}/complete`, {
		method: 'POST'
	});

	if (response.ok) {
		const { type, data } = await response.json();
		return json({ type, data });
	}

	return formatErrorResponse(response);
};
