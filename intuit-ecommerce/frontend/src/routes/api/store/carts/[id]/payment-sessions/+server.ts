import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

export const POST: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts/${params.id}/payment-sessions`, {
		method: 'POST'
	});

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};
