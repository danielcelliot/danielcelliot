import { dev } from '$app/environment';
import { PUBLIC_STORE_CART_COOKIE_NAME } from '$env/static/public';
import type { Customer, ProductCategory } from '$lib/types/medusa';
import type { CartPageData } from '$lib/types/shop';
import { superValidate } from 'sveltekit-superforms/server';
import type { LayoutServerLoad } from './$types';
import { z } from 'zod';

export const load: LayoutServerLoad = async ({ fetch, cookies }) => {
	const fetchProductCategories = async () => {
		const response = await fetch('/api/store/product-categories');
		if (response.ok) {
			return (await response.json()) as ProductCategory[];
		}

		return null;
	};

	const fetchCustomer = async () => {
		const response = await fetch('/api/store/customers/me');
		if (response.ok) return (await response.json()) as Customer;

		return null;
	};

	const fetchCart = async (cart_id: string) => {
		const response = await fetch(`/api/store/carts/${cart_id}`);
		if (response.ok) return (await response.json()) as CartPageData;

		return null;
	};

	const fetchCustomerData = async () => {
		let customer = await fetchCustomer();
		let cart: CartPageData | null = null;

		const cartId = cookies.get(PUBLIC_STORE_CART_COOKIE_NAME);

		if (customer?.metadata?.cart_id && cartId) {
			if (customer.metadata.cart_id === cartId) {
				cookies.delete(PUBLIC_STORE_CART_COOKIE_NAME, { path: '/', secure: !dev });

				return {
					customer,
					cart: await fetchCart(customer.metadata.cart_id)
				};
			} else {
				cart = await fetchCart(customer.metadata.cart_id);

				if (!cart?.completed_at && cart?.items && cart.items.length > 0) {
					/* Asynchronous POST requests to add line-items causes this error:
            "Error: Reason code: Canceled on identification as a pivot, during commit attempt.
            status 409: The request conflicted with another request. You may retry the request with the provided Idempotency-Key."
          */
					/*
          Similar issues:
          https://github.com/medusajs/medusa/issues/3206
          https://github.com/medusajs/medusa/issues/3556
         */
					// TODO: Open issue on GitHub
					// As a workaround, we will run the requests sequentially
					for (const lineItem of cart.items) {
						await fetch(`/api/store/carts/${cartId}/line-items`, {
							method: 'POST',
							headers: {
								'Content-Type': 'application/json'
							},
							body: JSON.stringify({
								variant_id: lineItem.variant.id,
								quantity: lineItem.quantity
							})
						});
					}
				}
			}
		}

		if (cartId) {
			cart = await fetchCart(cartId);

			if (cart && customer) {
				const response = await fetch('/api/store/customers/me', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({
						metadata: { cart_id: cartId }
					})
				});

				if (response.ok) {
					cookies.delete(PUBLIC_STORE_CART_COOKIE_NAME, { path: '/', secure: !dev });
					customer = (await response.json()) as Customer;
				}
			}
		} else if (customer && customer.metadata?.cart_id) {
			cart = await fetchCart(customer.metadata.cart_id);
		}

		return { customer, cart };
	};

	const validateCart = async (customerData: {
		customer: Customer | null;
		cart: CartPageData | null;
	}) => {
		if (customerData.cart && customerData.cart.completed_at) {
			if (customerData.customer) {
				await fetch('/api/store/customers/me', {
					method: 'POST',
					headers: {
						'Content-Type': 'application/json'
					},
					body: JSON.stringify({
						metadata: { cart_id: '' }
					})
				});
			} else if (cookies.get(PUBLIC_STORE_CART_COOKIE_NAME)) {
				cookies.delete(PUBLIC_STORE_CART_COOKIE_NAME, { path: '/', secure: !dev });
			}

			return {
				customer: customerData.customer,
				cart: null
			};
		}

		return {
			customer: customerData.customer,
			cart: customerData.cart
		};
	};

	const [categories, customerData, logoutForm] = await Promise.all([
		fetchProductCategories(),
		validateCart(await fetchCustomerData()),
		superValidate(z.object({}))
	]);

	return {
		categories,
		customerData,
		logoutForm
	};
};
