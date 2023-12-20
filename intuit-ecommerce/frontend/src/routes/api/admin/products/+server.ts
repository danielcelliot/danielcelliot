import { MEDUSA_BACKEND_URL } from '$env/static/private';
import type { Product } from '$lib/types/medusa';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// List Products
// https://docs.medusajs.com/api/admin#products_getproducts
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/products`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { products }: { products: Product[] } = await response.json();
		return json(products);
	}

	return formatErrorResponse(response);
};

// Create a Product
// https://docs.medusajs.com/api/admin#products_postproducts
export const POST: RequestHandler = async ({ fetch, cookies, request }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/products`, {
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
