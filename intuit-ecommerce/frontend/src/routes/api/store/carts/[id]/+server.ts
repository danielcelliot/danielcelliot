import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';
import { ProductCondition, type Cart, VariantType } from '$lib/types/medusa';
import type { CartPageData } from '$lib/types/shop';
import { MEDUSA_BACKEND_URL } from '$env/static/private';
import { formatErrorResponse } from '$lib/server/shop';

const expand = {
	expand:
		'items.variant.options,items.variant.options.option,payment_sessions,shipping_methods,shipping_methods.shipping_option'
};

function formatCartData(cart: Cart): CartPageData {
	return {
		id: cart.id,
		subtotal: cart.subtotal,
		total: cart.total,
		completed_at: cart.completed_at,
		shipping_total: cart.shipping_total,
		shipping_methods:
			cart.shipping_methods?.map((s) => {
				return {
					id: s.id,
					price: s.price,
					shipping_option: {
						id: s.shipping_option.id,
						amount: s.shipping_option.amount,
						name: s.shipping_option.name
					}
				};
			}) ?? null,
		payment_sessions:
			cart.payment_sessions?.map((p) => {
				return {
					provider_id: p.provider_id,
					is_selected: p.is_selected
				};
			}) ?? null,
		items:
			cart.items?.map((i) => {
				return {
					id: i.id,
					quantity: i.quantity,
					subtotal: i.subtotal,
					thumbnail: i.thumbnail,
					title: i.title,
					total: i.total,
					unit_price: i.unit_price,
					variant: {
						id: i.variant.id,
						inventory_quantity: i.variant.inventory_quantity,
						options: i.variant.options.map((o) => {
							return {
								name: o.option?.title ?? '',
								value: o.value
							};
						}),
						product: {
							condition: i.variant.product?.condition ?? ProductCondition.NEW,
							handle: i.variant.product?.handle ?? '',
							variant_type: i.variant.product?.variant_type ?? VariantType.MULTI
						},
						thumbnail: i.variant.thumbnail,
						title: i.variant.title
					}
				};
			}) ?? []
	};
}

// Get a Cart
// https://docs.medusajs.com/api/store#carts_getcartscart
export const GET: RequestHandler = async ({ fetch, params }) => {
	const expandParam = new URLSearchParams(expand);

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts/${params.id}?${expandParam}`);
	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return json(formatCartData(cart));
	}

	return formatErrorResponse(response);
};

// Update a Cart
// https://docs.medusajs.com/api/store#carts_postcartscart
export const POST: RequestHandler = async ({ fetch, params, request }) => {
	const body = await request.json();

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/carts/${params.id}`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	});

	if (response.ok) {
		const { cart } = await response.json();
		return json(cart);
	}

	return formatErrorResponse(response);
};
