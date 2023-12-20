import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Get a Product
// https://docs.medusajs.com/api/admin#products_getproducts
export const GET: RequestHandler = async ({ fetch, params, cookies }) => {
	const searchParams = new URLSearchParams({
		id: params.id,
		expand:
			'options,options.values,tags,categories,variants,images,variants.images,variants.options,variants.prices'
	});

	const sessionCookie = cookies.get('vid');

	// This endpoint returns an array of products
	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/products?${searchParams}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { products } = await response.json();
		return json(products);
	}

	return formatErrorResponse(response);
};

// Update a Product
// https://docs.medusajs.com/api/admin#products_postproductsproduct
export const POST: RequestHandler = async ({ fetch, params, cookies, request }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/products/${params.id}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`,
			'Content-Type': 'application/json'
		},
		method: 'POST',
		body: JSON.stringify({ ...body })
	});

	if (response.ok) {
		const { product } = await response.json();
		return json(product);
	}

	return formatErrorResponse(response);
};

// Delete a Product
// https://docs.medusajs.com/api/admin#products_deleteproductsproduct
export const DELETE: RequestHandler = async ({ fetch, params, cookies }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/products/${params.id}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		},
		method: 'DELETE'
	});

	if (response.ok) {
		const result = await response.json();
		return json(result);
	}

	return formatErrorResponse(response);
};
