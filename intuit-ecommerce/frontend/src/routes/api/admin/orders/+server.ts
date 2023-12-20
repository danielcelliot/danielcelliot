import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { MEDUSA_BACKEND_URL } from '$env/static/private';

// List Orders
// https://docs.medusajs.com/api/admin#orders_getorders
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const searchParams = new URLSearchParams({
		expand: 'customer,shipping_address,items',
		fields: 'id,status,display_id,created_at,email,fulfillment_status,total,currency_code'
	});

	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/orders?${searchParams}`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { orders } = await response.json();
		return json(orders);
	}

	return formatErrorResponse(response);
};
