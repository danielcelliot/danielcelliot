import type { Order } from '$lib/types/medusa.js';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ params, fetch }) => {
	const fetchOrder = async (order_id: string) => {
		const response = await fetch(`/api/store/orders/${order_id}`);

		if (response.ok) return (await response.json()) as Order;

		throw error(404, 'Not found');
	};

	return {
		order: fetchOrder(params.id)
	};
};
