import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

// Update a User
// https://docs.medusajs.com/api/admin#users_postusersuser
export const POST: RequestHandler = async ({ fetch, cookies, params, request }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/users/${params.id}`, {
		method: 'POST',
		headers: {
			Cookie: `connect.sid=${sessionCookie}`,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ ...body })
	});

	if (response.ok) {
		const { user } = await response.json();
		return json(user);
	}

	return formatErrorResponse(response);
};
