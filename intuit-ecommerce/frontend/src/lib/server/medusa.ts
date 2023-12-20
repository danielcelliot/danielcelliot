import { MEDUSA_BACKEND_URL, MEDUSA_REGION_ID, MEDUSA_SALES_CHANNEL_ID } from '$env/static/private';
import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';
import { error } from '@sveltejs/kit';
import {
	ProductStatus,
	type Cart,
	type Customer,
	type Product,
	type ProductCategory,
	type ShippingOption,
	type CreateAddress,
	type Order
} from '$lib/types/medusa';
import * as medusa from '$lib/utils/api';

export async function fetchDeliveryOptions(fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/shipping-options?is_return=false&region_id=${MEDUSA_REGION_ID}`;
	const response = await fetch(url);

	if (response.ok) {
		const { shipping_options }: { shipping_options: ShippingOption[] } = await response.json();
		return shipping_options;
	}

	console.error(`Fetch Delivery Options (${response.status}):`, await response.json());
	return null;
}

export async function fetchProductCategories(fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/product-categories?parent_category_id=null&include_descendants_tree=true`;
	const response = await fetch(url);

	if (response.ok) {
		const { product_categories }: { product_categories: ProductCategory[] } = await response.json();
		return product_categories;
	}

	response.status === 401
		? console.error(`Fetch Categories (${response.status}):`, await response.text())
		: console.error(`Fetch Categories (${response.status}):`, await response.json());

	return null;
}

export async function fetchProducts(
	slug: string,
	fetch: typeof globalThis.fetch
): Promise<Product[] | null> {
	const url = `${MEDUSA_BACKEND_URL}/store/products?category_id[]=${slug}&include_category_children=true`;
	const response = await fetch(url);

	if (response.ok) {
		const { products }: { products: Product[] } = await response.json();
		return products.filter((p) => p.status === ProductStatus.PUBLISHED);
	}

	console.error(`Fetch Products (${response.status}):`, await response.json());
	return null;
}

export async function fetchProduct(
	fetch: typeof globalThis.fetch,
	filters?: Record<string, string>,
	id?: string
) {
	const response = await medusa.get(
		fetch,
		MEDUSA_BACKEND_URL,
		`/store/products${id ? `/${id}` : ''}`,
		filters
	);

	if (response.status === 200) {
		const { products }: { products: Product[] } = response.body;
		if (products[0].status === ProductStatus.PUBLISHED) return products[0];
	}

	console.error(`Error: fetch product (${response.status})`, response.body);
	return null;
}

export async function fetchCart(
	cart_id: string,
	fetch: typeof globalThis.fetch,
	filters?: Record<string, string>
) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, `/store/carts/${cart_id}`, filters);

	if (response.status === 200) {
		const { cart }: { cart: Cart } = response.body;
		return cart;
	}

	console.error(`Error: fetch cart (${response.status})`, response.body);
	return null;
}

export async function fetchCustomer(fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me`;
	const response = await fetch(url);

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	response.status === 401
		? console.error(`Fetch Customer (${response.status}):`, await response.text())
		: console.error(`Fetch Customer (${response.status}):`, await response.json());

	return null;
}

export async function fetchCustomerOrders(fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me/orders`;
	const response = await fetch(url);

	if (response.ok) {
		const { orders }: { orders: Order[] } = await response.json();
		return orders;
	}

	response.status === 401
		? console.error(`Fetch Customer Orders (${response.status}):`, await response.text())
		: console.error(`Fetch Customer Orders (${response.status}):`, await response.json());

	return null;
}

export async function fetchOrder(order_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/orders/${order_id}`;
	const response = await fetch(url);

	if (response.ok) {
		const { order }: { order: Order } = await response.json();
		return order;
	}

	console.error(`Fetch Order (${response.status}):`, await response.json());
	return null;
}

export async function createCart(
	lineItems: { variant_id: string; quantity: number }[] = [],
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			region_id: MEDUSA_REGION_ID,
			sales_channel_id: MEDUSA_SALES_CHANNEL_ID,
			country_code: PUBLIC_STORE_CURRENCY_CODE,
			items: lineItems
		})
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Create Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function completeCart(cart_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/complete`;
	const response = await fetch(url, { method: 'POST' });

	if (response.ok) {
		const { type, data }: { type: string; data: object } = await response.json();
		return { type, data };
	}

	console.error(`Complete Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function createPaymentSessions(cart_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/payment-sessions`;
	const response = await fetch(url, { method: 'POST' });

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Create Payment Sessions (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addLineItem(
	variant_id: string,
	quantity: number,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/line-items`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			variant_id,
			quantity
		})
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add Line Item (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function updateLineItem(
	line_id: string,
	quantity: number,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/line-items/${line_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ quantity })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Update Line item (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function deleteLineItem(
	line_id: string,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/line-items/${line_id}`;
	const response = await fetch(url, { method: 'DELETE' });

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Delete Line item (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addPaymentOption(
	provider_id: string,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/payment-session`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ provider_id })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add Payment Option to Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addDeliveryOption(
	option_id: string,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}/shipping-methods`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ option_id })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add Delivery Option to Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addDeliveryAddress(
	shipping_address: CreateAddress,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ shipping_address })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add Delivery Address to Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addCustomerToCart(
	customer_id: string,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ customer_id })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add Customer to Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addEmailToCart(
	email: string,
	cart_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/carts/${cart_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ email })
	});

	if (response.ok) {
		const { cart }: { cart: Cart } = await response.json();
		return cart;
	}

	console.error(`Add E-Mail to Cart (${response.status}):`, await response.json());
	if (response.status === 500) throw error(500);
	return null;
}

export async function addCustomerAddress(address: CreateAddress, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me/addresses`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ address })
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Add Customer Address (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Add Customer Address (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Add Customer Address (${response.status}):`, await response.json());
	}

	return null;
}

export async function updateCustomerAddress(
	address_id: string,
	address: CreateAddress,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me/addresses/${address_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			first_name: address.first_name,
			last_name: address.last_name,
			phone: address.phone,
			address_1: address.address_1,
			address_2: address.address_2,
			city: address.city,
			country_code: address.country_code,
			postal_code: address.postal_code,
			province: address.province
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Update Customer Address (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Update Customer Address (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Update Customer Address (${response.status}):`, await response.json());
	}

	return null;
}

export async function deleteCustomerAddress(address_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me/addresses/${address_id}`;
	const response = await fetch(url, {
		method: 'DELETE',
		headers: {
			'Content-Type': 'application/json'
		}
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Delete Customer Address (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Delete Customer Address (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Delete Customer Address (${response.status}):`, await response.json());
	}

	return null;
}

export async function updateCustomer(
	first_name: string,
	last_name: string,
	phone: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/store/customers/me`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			first_name,
			last_name,
			phone
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Update Customer (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Update Customer (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Update Customer (${response.status}):`, await response.json());
	}

	return null;
}
