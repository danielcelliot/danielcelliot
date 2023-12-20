import type { Product, ProductCategory } from '$lib/types/medusa';
import type { PageServerLoad } from './$types';

const DEFAULT_LIMIT = '10';
const MAX_LIMIT = 50;

export const load: PageServerLoad = ({ params, fetch, url }) => {
	const fetchCategory = async (handle: string) => {
		const response = await fetch(`/api/store/product-categories/${handle}`);
		if (response.ok) return (await response.json()) as ProductCategory;

		return null;
	};

	const fetchProducts = async () => {
		// TODO: params validation

		const category = await fetchCategory(params.handle);

		if (category) {
			let limit = url.searchParams.get('limit') || DEFAULT_LIMIT;

			if (parseInt(limit) > MAX_LIMIT) {
				limit = MAX_LIMIT.toString();
			}

			const offset = url.searchParams.get('offset') || '0';

			const searchParams = new URLSearchParams({
				category_id: category.id,
				limit,
				offset
			});

			const response = await fetch(`/api/store/products?${searchParams}`);

			if (response.ok)
				return (await response.json()) as {
					products: Product[];
					count: number;
					limit: number;
					offset: number;
				};
		}

		return null;
	};

	return {
		productsData: fetchProducts()
	};
};
