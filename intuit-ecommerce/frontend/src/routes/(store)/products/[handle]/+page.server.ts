import { fail, type Action, type Actions, error } from '@sveltejs/kit';
import { message, superValidate } from 'sveltekit-superforms/server';
import type { ProductPageData } from '$lib/types/shop.js';
import type { PageServerLoad } from './$types';
import { addLineItemSchema } from '$lib/schemas/cart';
import { dev } from '$app/environment';
import { PUBLIC_STORE_CART_COOKIE_NAME } from '$env/static/public';
import type { Cart, Customer, Item } from '$lib/types/medusa';

const add: Action = async (event) => {
	const addLineItem = async (cart_id: string, variant_id: string, quantity: number) => {
		return await event.fetch(`/api/store/carts/${cart_id}/line-items`, {
			method: 'POST',
			body: JSON.stringify({
				variant_id,
				quantity
			})
		});
	};

	const findLineItem = (variant_id: string, cart: Cart) => {
		return cart.items?.find((i) => i.variant_id === variant_id);
	};

	const form = await superValidate(event.request, addLineItemSchema);
	if (!form.valid) return fail(400, { form });

	const errorMsg = {
		type: 'error',
		text: 'Unable to add this item to your shopping bag'
	} as const;

	const successMsg: App.Superforms.Message = {
		type: 'success',
		text: 'Added item to your shopping bag',
		data: undefined
	};

	let customer: Customer | undefined;
	let cart: Cart | undefined;
	let lineItem: Item | undefined;

	let response = await event.fetch('/api/store/customers/me');
	if (response.ok) {
		customer = (await response.json()) as Customer;

		if (customer.metadata?.cart_id) {
			// Customer is logged in and has a cart
			response = await addLineItem(
				customer.metadata?.cart_id,
				form.data.variant_id,
				form.data.quantity
			);

			if (response.ok) {
				lineItem = findLineItem(form.data.variant_id, await response.json());

				// Return line item
				successMsg.data = { ...lineItem };

				return message(form, successMsg);
			} else {
				return message(form, errorMsg);
			}
		}
	}

	const cartId = event.cookies.get(PUBLIC_STORE_CART_COOKIE_NAME);
	if (cartId) {
		// Customer is not logged in but has a cart
		response = await addLineItem(cartId, form.data.variant_id, form.data.quantity);

		if (response.ok) {
			lineItem = findLineItem(form.data.variant_id, await response.json());

			// Return line item
			successMsg.data = { ...lineItem };

			return message(form, successMsg);
		} else {
			return message(form, errorMsg);
		}
	}

	// Customer does not have a cart, create one
	response = await event.fetch('/api/store/carts', {
		method: 'POST',
		body: JSON.stringify([
			{
				variant_id: form.data.variant_id,
				quantity: form.data.quantity
			}
		])
	});

	if (response.ok) {
		cart = (await response.json()) as Cart;
		// Add line item
		lineItem = findLineItem(form.data.variant_id, cart);
		successMsg.data = { ...lineItem };
	}

	if (customer && cart) {
		// Customer is logged in
		response = await event.fetch('/api/store/customers/me', {
			method: 'POST',
			body: JSON.stringify({
				metadata: {
					cart_id: cart.id
				}
			})
		});

		return response.ok ? message(form, successMsg) : message(form, errorMsg);
	} else if (cart) {
		// Customer is not logged in
		event.cookies.set(PUBLIC_STORE_CART_COOKIE_NAME, cart.id, {
			secure: !dev,
			path: '/',
			maxAge: 60 * 60 * 24 * 365,
			sameSite: 'lax'
		});

		return message(form, successMsg);
	}

	return message(form, errorMsg);
};

export const actions: Actions = { add };

export const load: PageServerLoad = async ({ params, fetch }) => {
	const fetchProductData = async () => {
		const response = await fetch(`/api/store/products/${params.handle}`);
		if (response.ok) return (await response.json()) as ProductPageData;

		throw error(404, 'Not found');
	};

	const [product, form] = await Promise.all([fetchProductData(), superValidate(addLineItemSchema)]);

	return { product, form };
};

// const getSelectedVariant = async (handle: string, selected: string | null) => {
// 	let variantId: string = '';

// 	if (handle && selected) {
// 		const product: Product = await fetchProduct(handle);
// 		const selectedValues = selected.split(',').sort();
// 		// console.log('Selected values:', selectedValues);

// 		let temp: string[];
// 		product.variants.forEach((variant) => {
// 			temp = [];

// 			variant.options.forEach((option) => {
// 				temp.push(option.value);
// 			});

// 			const options = temp.slice().sort();
// 			// console.log('Product options:', options);
// 			if (
// 				options.length === selectedValues.length &&
// 				options.every((value, index) => value === selectedValues[index])
// 			) {
// 				// console.log('Variant ID found:', variant.id);
// 				variantId = variant.id;
// 			}
// 		});
// 	}

// 	return variantId;
// };

// const getVariant: Action = async ({ request, params }) => {
// 	const formData = await request.formData();
// 	const values: string[] = [];

// 	for (const [key, value] of formData) {
// 		values.push(String(value));
// 	}

// 	throw redirect(302, `/product/${params.slug}?selected=${values.toString()}`);
// };
