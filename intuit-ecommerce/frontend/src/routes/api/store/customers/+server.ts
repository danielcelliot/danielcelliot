import { dev } from '$app/environment';
import { MEDUSA_BACKEND_URL, MEDUSA_SESSION_COOKIE_NAME } from '$env/static/private';
import { PUBLIC_CUSTOMER_COOKIE_NAME } from '$env/static/public';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import cookie from 'cookie';

// Create a Customer
// https://docs.medusajs.com/api/store#customers_postcustomers
export const POST: RequestHandler = async ({ fetch, request }) => {
	const { email, password, first_name, last_name, phone } = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			email,
			password,
			first_name,
			last_name,
			phone
		})
	});

	if (response.ok) {
		const setCookies = response.headers.getSetCookie();

		let parsedCookie: Record<string, string> | undefined;

		for (const rawCookie of setCookies) {
			parsedCookie = cookie.parse(rawCookie);
		}

		if (parsedCookie) {
			const sessionId = parsedCookie[MEDUSA_SESSION_COOKIE_NAME];
			const expires = parsedCookie['Expires'];

			return json(
				{ message: 'Registration successful' },
				{
					headers: {
						'Set-Cookie': `${PUBLIC_CUSTOMER_COOKIE_NAME}=${sessionId}; Path=/; Expires=${expires}; SameSite=Lax; HttpOnly; ${
							dev ? '' : 'Secure;'
						}`
					}
				}
			);
		}

		return json({ message: 'Set-cookie failed' }, { status: 500 });
	}

	return formatErrorResponse(response);
};
