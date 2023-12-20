import { error, redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import { handleAdminLoginRedirect } from '$lib/server/shop';
import type { Order } from '$lib/types/medusa';

export const load: PageServerLoad = async (event) => {
	const fetchOrders = async () => {
		const response = await event.fetch('/api/admin/orders');

		if (response.ok) return (await response.json()) as Order[];
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	return {
		orders: fetchOrders()
	};
};
