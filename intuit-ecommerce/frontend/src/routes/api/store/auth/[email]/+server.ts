import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { formatErrorResponse } from '$lib/server/shop';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

// Check if Email Exists
// https://docs.medusajs.com/api/store#auth_getauthemail
export const GET: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/auth/${params.email}`);

	if (response.ok) return json(await response.json());

	return formatErrorResponse(response);
};
