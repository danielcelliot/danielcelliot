import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

export const POST: RequestHandler = async ({ fetch, request }) => {
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/customers/password-reset`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	});

	if (response.ok) {
		const { customer } = await response.json();
		return json(customer);
	}

	return formatErrorResponse(response);
};
