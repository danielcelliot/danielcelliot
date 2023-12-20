import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { ProductStatus, type Product } from '$lib/types/medusa';

const DEFAULT_LIMIT = '10';

// Get Products by Category
// https://docs.medusajs.com/api/store#products_getproducts
export const GET: RequestHandler = async ({ fetch, url }) => {
	const category_id = url.searchParams.get('category_id');
	const limit = url.searchParams.get('limit') || DEFAULT_LIMIT;
	const offset = url.searchParams.get('offset') || '0';

	const searchParams = new URLSearchParams({ limit, offset });

	if (category_id) searchParams.set('category_id[]', category_id);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/products?${searchParams}`);

	if (response.ok) {
		const {
			products,
			count,
			offset,
			limit
		}: { products: Product[]; count: number; offset: number; limit: number } =
			await response.json();

		return json({
			products: products.filter((p) => p.status === ProductStatus.PUBLISHED),
			count,
			offset,
			limit
		});
	}

	return json({ message: 'Not found' }, { status: 404 });
};
