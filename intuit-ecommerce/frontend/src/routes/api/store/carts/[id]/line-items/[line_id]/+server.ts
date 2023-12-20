import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';
import { MEDUSA_BACKEND_URL } from '$env/static/private';

// Update a Line Item
// https://docs.medusajs.com/api/store#carts_postcartscartlineitemsitem
export const POST: RequestHandler = async ({ fetch, params, request }) => {
	const body = await request.json();

	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/store/carts/${params.id}/line-items/${params.line_id}`,
		{
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify(body)
		}
	);

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};

// Delete a Line Item
// https://docs.medusajs.com/api/store#carts_deletecartscartlineitemsitem
export const DELETE: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/store/carts/${params.id}/line-items/${params.line_id}`,
		{ method: 'DELETE' }
	);

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};
