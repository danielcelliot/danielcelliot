import { dev } from '$app/environment';
import { MEDUSA_BACKEND_URL, MEDUSA_SESSION_COOKIE_NAME } from '$env/static/private';
import type { RequestHandler } from './$types';
import cookie from 'cookie';
import { PUBLIC_VENDOR_COOKIE_NAME } from '$env/static/public';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';

// Get Current User
// https://docs.medusajs.com/api/admin#auth_getauth
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get(PUBLIC_VENDOR_COOKIE_NAME);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/auth`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { user } = await response.json();
		return json(user);
	}

	return formatErrorResponse(response);
};

// User Login
// https://docs.medusajs.com/api/admin#auth_postauth
export const POST: RequestHandler = async ({ fetch, request }) => {
	const { email, password } = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/auth`, {
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

			return new Response(null, {
				headers: {
					'Set-Cookie': `${PUBLIC_VENDOR_COOKIE_NAME}=${sessionId}; Path=/; Expires=${expires}; SameSite=Lax; HttpOnly; ${
						dev ? '' : 'Secure;'
					}`
				},
				status: 200
			});
		}
	}

	return formatErrorResponse(response);
};
