import { dev } from '$app/environment';
import { MEDUSA_BACKEND_URL, MEDUSA_SESSION_COOKIE_NAME } from '$env/static/private';
import { PUBLIC_CUSTOMER_COOKIE_NAME } from '$env/static/public';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import cookie from 'cookie';
import { formatErrorResponse } from '$lib/server/shop';

// Customer Login
// https://docs.medusajs.com/api/store#auth_postauth
export const POST: RequestHandler = async ({ fetch, request }) => {
	const { email, password } = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/auth`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ email, password })
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
				{ message: 'Login successful' },
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

// Customer Log out
// https://docs.medusajs.com/api/store#auth_deleteauth
export const DELETE: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get(PUBLIC_CUSTOMER_COOKIE_NAME);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/auth`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		},
		method: 'DELETE'
	});

	if (response.ok) return json({ message: 'success' });

	return await formatErrorResponse(response);
};
