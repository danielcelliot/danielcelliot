import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Get a Category by Its Handle
// https://docs.medusajs.com/modules/products/storefront/use-categories#get-a-category-by-its-handle
export const GET: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/store/product-categories?handle=${params.handle}`
	);

	if (response.ok) {
		const { product_categories } = await response.json();

		if (product_categories.length) {
			return json(product_categories[0]);
		}

		return json({ message: 'Not found' }, { status: 404 });
	}

	return formatErrorResponse(response);
};
