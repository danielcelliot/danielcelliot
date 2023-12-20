import type { RequestHandler } from './$types';
import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import { formatErrorResponse } from '$lib/server/shop';
import { PUBLIC_CUSTOMER_COOKIE_NAME } from '$env/static/public';

// Get a Customer
// https://docs.medusajs.com/api/store#customers_getcustomerscustomer
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get(PUBLIC_CUSTOMER_COOKIE_NAME);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers/me`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { customer } = await response.json();
		return json(customer);
	}

	return formatErrorResponse(response);
};

// Update Customer
// https://docs.medusajs.com/api/store#customers_postcustomerscustomer
export const POST: RequestHandler = async ({ fetch, request, cookies }) => {
	const sessionCookie = cookies.get(PUBLIC_CUSTOMER_COOKIE_NAME);
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers/me`, {
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
