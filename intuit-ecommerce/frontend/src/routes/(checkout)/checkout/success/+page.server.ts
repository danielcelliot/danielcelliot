import type { Customer, Order } from '$lib/types/medusa';
import { error } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ fetch, url }) => {
	const fetchOrder = async (id: string) => {
		const response = await fetch(`/api/store/orders/${id}`);

		if (response.ok) return (await response.json()) as Order;

		return null;
	};

	const fetchCustomer = async () => {
		const response = await fetch('/api/store/customers/me');
		if (response.ok) return (await response.json()) as Customer;

		return null;
	};

	const orderId = url.searchParams.get('order_id');

	if (orderId) {
		const order = await fetchOrder(orderId);
		if (order) {
			return { order, customer: await fetchCustomer() };
		}
	}

	throw error(404, 'Not found');
};
