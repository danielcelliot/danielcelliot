import type { Product } from '$lib/types/medusa';
import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { error } from '@sveltejs/kit';

export async function GET({ url, fetch }) {
	const id = url.searchParams.get('id');

	if (id) {
		const url = `${MEDUSA_BACKEND_URL}/store/products/${id}?fields=handle&expand`;
		const response = await fetch(url);

		if (response.ok) {
			const { product }: { product: Pick<Product, 'handle'> } = await response.json();
			return new Response(null, {
				status: 303,
				headers: {
					location: `/product/${product.handle}`
				}
			});
		}

		console.error(`Error: fetch product by id (${response.status}):`, await response.json());
	}

	throw error(404, 'Not found');
}
