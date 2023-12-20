import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { formatErrorResponse } from '$lib/server/shop';

// List for Cart
// https://docs.medusajs.com/api/store#shipping-options_getshippingoptionscartid
export const GET: RequestHandler = async ({ fetch, params }) => {
	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/shipping-options/${params.cart_id}`);

	if (response.ok) {
		const { shipping_options } = await response.json();
		return json(shipping_options);
	}

	return formatErrorResponse(response);
};
