import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// List Product Categories
// https://docs.medusajs.com/api/store#product-categories_getproductcategories
export const GET: RequestHandler = async ({ fetch }) => {
	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/store/product-categories?parent_category_id=null&include_descendants_tree=true`
	);

	if (response.ok) {
		const { product_categories } = await response.json();
		return json(product_categories);
	}

	return formatErrorResponse(response);
};
