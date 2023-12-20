import type { Action, Actions } from './$types';
import { setError, superValidate } from 'sveltekit-superforms/server';
import { error, fail, redirect } from '@sveltejs/kit';
import { PUBLIC_STORE_CART_COOKIE_NAME } from '$env/static/public';
import { checkoutSchema } from '$lib/schemas/checkout';
import {
	CartStatus,
	type Cart,
	type CreateAddress,
	type Customer,
	type ShippingOption
} from '$lib/types/medusa';
import type { CartPageData } from '$lib/types/shop';
import { dev } from '$app/environment';

const complete: Action = async (event) => {
	const fetchCustomer = async () => {
		const response = await event.fetch('/api/store/customers/me');
		if (response.ok) return (await response.json()) as Customer;

		return null;
	};

	const addDeliveryOption = async (option_id: string, cart_id: string) => {
		const response = await event.fetch(`/api/store/carts/${cart_id}/shipping-methods`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ option_id })
		});

		if (response.ok) return (await response.json()) as Cart;

		return null;
	};

	const addDeliveryAddress = async (shipping_address: CreateAddress, cart_id: string) => {
		const response = await event.fetch(`/api/store/carts/${cart_id}`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ shipping_address })
		});

		if (response.ok) return (await response.json()) as Cart;

		return null;
	};

	const addPaymentOption = async (provider_id: string, cart_id: string) => {
		const response = await event.fetch(`/api/store/carts/${cart_id}/payment-session`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ provider_id })
		});

		if (response.ok) return (await response.json()) as Cart;

		return null;
	};

	const updateCart = async (cart_id: string, customer_id?: string, email?: string) => {
		let body = {};

		if (customer_id) {
			body = { customer_id };
		} else if (email) {
			body = { email };
		}

		const response = await event.fetch(`/api/store/carts/${cart_id}`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ ...body })
		});

		if (response.ok) return (await response.json()) as Cart;

		console.error(`Error: update cart (${response.status}):`, await response.json());
		return null;
	};

	const completeCart = async (cart_id: string) => {
		const response = await event.fetch(`/api/store/carts/${cart_id}/complete`, { method: 'POST' });

		if (response.ok) {
			const { type, data }: { type: CartStatus; data: Record<string, unknown> } =
				await response.json();

			console.log('Complete cart data:', { type, data });
			return { type, data };
		}

		console.error(`Error: complete cart (${response.status}):`, await response.json());
		return null;
	};

	const removeCartIdFromCustomer = async () => {
		const response = await event.fetch(`/api/store/customers/me`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				metadata: { cart_id: '' }
			})
		});

		if (response.ok) return (await response.json()) as Customer;

		console.error(
			`Error: remove cart id from customer (${response.status}):`,
			await response.json()
		);
		return null;
	};

	const form = await superValidate(event.request, checkoutSchema);
	if (!form.valid) return fail(400, { form });

	const address: CreateAddress = {
		first_name: form.data.first_name,
		last_name: form.data.last_name,
		phone: form.data.phone,
		address_1: form.data.address_1,
		address_2: form.data.address_2,
		city: form.data.city,
		country_code: 'tt',
		postal_code: 'NONE',
		province: 'NONE'
	};

	const customer = await fetchCustomer();

	if (!customer) {
		// Verify guest email before processing order
		const response = await event.fetch(`/api/store/auth/${form.data.email}`);

		if (response.ok) {
			const result = (await response.json()) as { exists: boolean };

			if (result.exists)
				return setError(
					form,
					'email',
					'Your email is associated with an existing customer account. Please sign in to complete your order or use a different email address.'
				);
		} else {
			throw error(500, { message: 'Unable to verify email address' });
		}
	}

	const cartId = event.cookies.get(PUBLIC_STORE_CART_COOKIE_NAME);

	if (!customer && !cartId) throw redirect(303, '/accounts/customer/signin?redirect_to=/cart');

	try {
		await Promise.all([
			customer
				? updateCart(form.data.cart_id, customer.id)
				: updateCart(form.data.cart_id, undefined, form.data.email),
			addDeliveryAddress(address, form.data.cart_id),
			addDeliveryOption(form.data.shipping_option_id, form.data.cart_id),
			addPaymentOption(form.data.payment_provider_id, form.data.cart_id)
		]);
	} catch (e) {
		console.error('Checkout error:', e);
		throw error(500, { message: 'Internal error' });
	}

	const completed = await completeCart(form.data.cart_id);
	if (completed?.type === CartStatus.ORDER) {
		customer
			? await removeCartIdFromCustomer()
			: event.cookies.delete(PUBLIC_STORE_CART_COOKIE_NAME, {
					path: '/',
					secure: !dev
			  });

		throw redirect(303, `/checkout/success?order_id=${completed.data.id}`);
	}

	console.error('Complete cart:', completed);
	throw error(500, { message: 'Internal error' });
};

export const actions: Actions = { complete };

export async function load({ fetch, cookies }) {
	const fetchCart = async (cart_id: string) => {
		const response = await fetch(`/api/store/carts/${cart_id}`);
		if (response.ok) return (await response.json()) as CartPageData;

		return null;
	};

	const fetchCustomer = async () => {
		const response = await fetch('/api/store/customers/me');
		if (response.ok) return (await response.json()) as Customer;

		return null;
	};

	const fetchShippingOptions = async (cart_id: string) => {
		const response = await fetch(`/api/store/shipping-options/${cart_id}`);
		if (response.ok) return (await response.json()) as ShippingOption[];

		return null;
	};

	const fetchCustomerData = async () => {
		const customer = await fetchCustomer();
		const cartId = cookies.get(PUBLIC_STORE_CART_COOKIE_NAME);

		if ((!customer || !customer.metadata?.cart_id) && !cartId)
			throw redirect(303, '/accounts/customer/signin?redirect_to=/cart');

		let cart: CartPageData | null = null;
		let shippingOptions: ShippingOption[] | null = null;

		if (customer && customer.metadata?.cart_id) cart = await fetchCart(customer.metadata.cart_id);

		if (!cart && cartId) cart = await fetchCart(cartId);

		if (cart) shippingOptions = await fetchShippingOptions(cart.id);

		// TODO: Remove in the future
		// Development purposes only
		if (cart && !cart.shipping_methods && shippingOptions) {
			console.log('DEV: adding default shipping option to cart...');
			const response = await fetch(`/api/store/carts/${cart.id}/shipping-methods`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({ option_id: shippingOptions[0].id })
			});

			if (response.ok) cart = await fetchCart(cart.id);
		}

		return {
			customer,
			cart
			// TODO: Add in the future
			// shippingOptions
		};
	};

	const [customerData, checkoutForm] = await Promise.all([
		fetchCustomerData(),
		superValidate(checkoutSchema)
	]);

	return {
		customerData,
		checkoutForm
	};
}
