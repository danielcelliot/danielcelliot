import { MEDUSA_BACKEND_URL, MEDUSA_REGION_ID } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// Get Shipping Options
// https://docs.medusajs.com/api/store#shipping-options_getshippingoptions
export const GET: RequestHandler = async ({ fetch }) => {
	const response = await fetch(
		`${MEDUSA_BACKEND_URL}/store/shipping-options?is_return=false&region_id=${MEDUSA_REGION_ID}`
	);

	if (response.ok) {
		const { shipping_options } = await response.json();
		return json(shipping_options);
	}

	return formatErrorResponse(response);
};
