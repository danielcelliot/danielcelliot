import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { PUBLIC_CUSTOMER_COOKIE_NAME } from '$env/static/public';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

export const POST: RequestHandler = async ({ fetch, cookies, request }) => {
	const sessionCookie = cookies.get(PUBLIC_CUSTOMER_COOKIE_NAME);
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers/me/addresses`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Cookie: `connect.sid=${sessionCookie}`
		},
		body: JSON.stringify(body)
	});

	if (response.ok) {
		const { customer } = await response.json();
		return json(customer);
	}

	return formatErrorResponse(response);
};
