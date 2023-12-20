import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { PUBLIC_CUSTOMER_COOKIE_NAME } from '$env/static/public';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get(PUBLIC_CUSTOMER_COOKIE_NAME);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers/me/orders`, {
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
