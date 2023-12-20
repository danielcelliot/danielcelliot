import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Update a Product Variant
// https://docs.medusajs.com/api/admin#products_postproductsproductvariantsvariant
export const POST: RequestHandler = async ({ fetch, request, params, cookies }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/admin/products/${params.id}/variants/${params.variant_id}`,
		{
			headers: {
				Cookie: `connect.sid=${sessionCookie}`,
				'Content-Type': 'application/json'
			},
			method: 'POST',
			body: JSON.stringify({ ...body })
		}
	);

	if (response.ok) {
		const { product } = await response.json();
		return json(product);
	}

	return formatErrorResponse(response);
};

// Delete a Product Variant
// https://docs.medusajs.com/api/admin#products_deleteproductsproductvariantsvariant
export const DELETE: RequestHandler = async ({ fetch, params, cookies }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/admin/products/${params.id}/variants/${params.variant_id}`,
		{
			headers: {
				Cookie: `connect.sid=${sessionCookie}`
			},
			method: 'DELETE'
		}
	);

	if (response.ok) {
		const { product } = await response.json();
		return json(product);
	}

	return formatErrorResponse(response);
};
