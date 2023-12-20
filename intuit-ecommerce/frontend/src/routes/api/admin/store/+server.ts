import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { MEDUSA_BACKEND_URL } from '$env/static/private';

// Get Store details
// https://docs.medusajs.com/api/admin#store_getstore
export const GET: RequestHandler = async ({ fetch, cookies }) => {
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/store`, {
		headers: {
			Cookie: `connect.sid=${sessionCookie}`
		}
	});

	if (response.ok) {
		const { store } = await response.json();
		return json(store);
	}

	return formatErrorResponse(response);
};

// Update Store Details
// https://docs.medusajs.com/api/admin#store_poststore
export const POST: RequestHandler = async ({ fetch, cookies, request }) => {
	const body = await request.json();
	const sessionCookie = cookies.get('vid');

	const response = await fetch(`${MEDUSA_BACKEND_URL}/admin/store`, {
		method: 'POST',
		headers: {
			Cookie: `connect.sid=${sessionCookie}`,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ ...body })
	});

	if (response.ok) {
		const { store } = await response.json();
		return json(store);
	}

	return formatErrorResponse(response);
};
