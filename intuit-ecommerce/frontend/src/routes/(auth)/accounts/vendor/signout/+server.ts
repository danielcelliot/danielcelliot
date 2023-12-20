import { dev } from '$app/environment';
import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { PUBLIC_VENDOR_COOKIE_NAME } from '$env/static/public';
import { formatErrorResponse } from '$lib/server/shop';
import type { RequestHandler } from '@sveltejs/kit';
import { actionResult, superValidate } from 'sveltekit-superforms/server';
import { z } from 'zod';

// Vendor Log out
// https://docs.medusajs.com/api/admin#auth_deleteauth
export const POST: RequestHandler = async ({ fetch, cookies, request }) => {
	const form = await superValidate(request, z.object({}));
	if (!form.valid) return actionResult('failure', { form });

	const sessionCookie = cookies.get(PUBLIC_VENDOR_COOKIE_NAME);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/auth`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		},
		method: 'DELETE'
	});

	if (response.ok) {
		cookies.delete(PUBLIC_VENDOR_COOKIE_NAME, { path: '/', secure: !dev });

		return actionResult('redirect', '/', {
			message: { type: 'success', message: 'You are now signed out of your account' },
			cookieOptions: { sameSite: 'Lax' }
		});
	}

	const errorResponse = await formatErrorResponse(response);

	console.error(`Error: vendor logout (${errorResponse.status}):`, await errorResponse.json());

	if (errorResponse.status === 500) {
		return actionResult('error', 'Unable to sign you out of your account', 500);
	}

	return actionResult('redirect', '/', 303);
};
