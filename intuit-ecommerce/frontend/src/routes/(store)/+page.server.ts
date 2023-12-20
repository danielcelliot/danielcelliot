import type { Product, ProductCategory } from '$lib/types/medusa';
import { shuffle } from 'lodash';
import type { PageServerLoad } from './$types';

export const load = (async ({ fetch }) => {
	const fetchCategory = async (handle: string) => {
		const response = await fetch(`/api/store/product-categories/${handle}`);
		if (response.ok) return (await response.json()) as ProductCategory;

		return null;
	};

	const fetchProducts = async (handle: string) => {
		const category = await fetchCategory(handle);

		if (category) {
			const search_params = new URLSearchParams({
				category_id: category.id,
				limit: '10',
				offset: '0'
			});

			const response = await fetch(`/api/store/products?${search_params}`);

			if (response.ok) {
				const { products }: { products: Product[] } = await response.json();
				return shuffle(products);
			}
		}

		return null;
	};

	const fetchFlashDeal = async () => {
		// DEMO: pull a random product from list
		const response = await fetch('/api/store/products');

		if (response.ok) {
			const { products }: { products: Product[] } = await response.json();
			return products[Math.floor(Math.random() * products.length)];
		}

		return null;
	};

	return {
		carousel_1: fetchProducts('sneakers'),
		carousel_2: fetchProducts('clothing-shoes-jewelry-watches'),
		flash_deal: fetchFlashDeal()
	};
}) satisfies PageServerLoad;
