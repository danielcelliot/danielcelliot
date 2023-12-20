import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// List Product Categories
// https://docs.medusajs.com/api/admin#product-categories_getproductcategories
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const searchParams = new URLSearchParams({
		parent_category_id: 'null',
		include_descendants_tree: 'true',
		is_active: 'true'
	});

	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/product-categories?${searchParams}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { product_categories } = await response.json();
		return json(product_categories);
	}

	return formatErrorResponse(response);
};
