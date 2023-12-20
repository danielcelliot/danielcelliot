import { MEDUSA_BACKEND_URL, MEDUSA_REGION_ID, MEDUSA_SALES_CHANNEL_ID } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';
import { PUBLIC_STORE_COUNTRY_CODE } from '$env/static/public';

// Create a Cart
// https://docs.medusajs.com/api/store#carts_postcart
export const POST: RequestHandler = async ({ fetch, request }) => {
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			region_id: MEDUSA_REGION_ID,
			sales_channel_id: MEDUSA_SALES_CHANNEL_ID,
			country_code: PUBLIC_STORE_COUNTRY_CODE,
			items: [...body]
		})
	});

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};
