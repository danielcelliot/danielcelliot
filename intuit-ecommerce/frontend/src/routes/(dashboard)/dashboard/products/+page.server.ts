import { handleAdminLoginRedirect } from '$lib/server/shop.js';
import type { Product } from '$lib/types/medusa.js';
import { error, redirect } from '@sveltejs/kit';

export async function load(event) {
	const fetchProducts = async () => {
		const response = await event.fetch('/api/admin/products');

		if (response.ok) return (await response.json()) as Product[];
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	return {
		products: await fetchProducts()
	};
}
