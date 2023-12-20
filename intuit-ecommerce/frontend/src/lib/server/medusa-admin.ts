import { MEDUSA_ADMIN_API_KEY, MEDUSA_BACKEND_URL } from '$env/static/private';
import type {
	Customer,
	Note,
	Order,
	Product,
	ProductCategory,
	ProductDto,
	ProductVariant,
	ProductVariantDto,
	Store,
	User
} from '$lib/types/medusa';
import { error } from '@sveltejs/kit';
import * as medusa from '$lib/utils/api';
import type { z } from 'zod';
import type { updateGeneralInfoSchema } from '$lib/schemas/product';
import type { businessDetailsSchema, vendorInfoSchema } from '$lib/schemas/vendor';

export async function addCartToCustomer(
	cart_id: string,
	customer_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/admin/customers/${customer_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${MEDUSA_ADMIN_API_KEY}`
		},
		body: JSON.stringify({
			metadata: { cart_id }
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Add Cart to Customer (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Add Cart to Customer (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Add Cart to Customer (${response.status}):`, await response.json());
	}

	return null;
}

export async function addContactToUser(
	chat_contact_id: number,
	user_id: string,
	fetch: typeof globalThis.fetch
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/users/${user_id}`, {
		metadata: {
			chat_contact_id
		}
	});
	if (response.status === 200) {
		const { user }: { user: User } = response.body;
		return user;
	}

	console.error(`Error: add contact id to user (${response.status})`, response.body);
	return null;
}

export async function addContactToCustomer(
	chat_contact_id: number,
	customer_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/admin/customers/${customer_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${MEDUSA_ADMIN_API_KEY}`
		},
		body: JSON.stringify({
			metadata: { chat_contact_id }
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Add Contact to Customer (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Add Contact to Customer (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Add Contact to Customer (${response.status}):`, await response.json());
	}

	return null;
}

export async function addDefaultAddress(
	address_id: string,
	customer_id: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${MEDUSA_BACKEND_URL}/admin/customers/${customer_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${MEDUSA_ADMIN_API_KEY}`
		},
		body: JSON.stringify({
			metadata: { default_address_id: address_id }
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Add Cart to Customer (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Add Cart to Customer (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Add Cart to Customer (${response.status}):`, await response.json());
	}

	return null;
}

export async function removeCartFromCustomer(customer_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/admin/customers/${customer_id}`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${MEDUSA_ADMIN_API_KEY}`
		},
		body: JSON.stringify({
			metadata: { cart_id: '' }
		})
	});

	if (response.ok) {
		const { customer }: { customer: Customer } = await response.json();
		return customer;
	}

	if (response.status === 401) {
		console.error(`Delete Cart from Customer (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Delete Cart from Customer (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Delete Cart from Customer (${response.status}):`, await response.json());
	}

	return null;
}

export async function cancelOrder(order_id: string, fetch: typeof globalThis.fetch) {
	const url = `${MEDUSA_BACKEND_URL}/admin/orders/${order_id}/cancel`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			Authorization: `Bearer ${MEDUSA_ADMIN_API_KEY}`
		}
	});

	if (response.ok) {
		const { order }: { order: Order } = await response.json();
		return order;
	}

	if (response.status === 401) {
		console.error(`Cancel Order (${response.status}):`, await response.text());
	} else if (response.status === 500) {
		console.error(`Cancel Order (${response.status}):`, await response.json());
		throw error(500);
	} else {
		console.error(`Cancel Order (${response.status}):`, await response.json());
	}

	return null;
}

export async function completeOrder(fetch: typeof globalThis.fetch, order_id: string) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/orders/${order_id}/complete`
	);
	if (response.status === 200) {
		const { order }: { order: Order } = response.body;
		return order;
	}

	console.error(`Error: complete order (${response.status})`, response.body);
	return null;
}

export async function fetchStoreDetails(fetch: typeof globalThis.fetch) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, '/admin/store');
	if (response.status === 200) {
		const { store }: { store: Store } = response.body;
		return store;
	}

	console.error(`Error: get store details (${response.status})`, response.body);
	return null;
}

export async function fetchUser(fetch: typeof globalThis.fetch) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, '/admin/auth');
	if (response.status === 200) {
		const { user }: { user: User } = response.body;
		return user;
	}

	console.error(`Error: fetch user (${response.status})`, response.body);
	return null;
}

export async function fetchOrders(
	fetch: typeof globalThis.fetch,
	filters?: Record<string, string>
) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, '/admin/orders', filters);
	if (response.status === 200) {
		const { orders }: { orders: Order[] } = response.body;
		return orders;
	}

	console.error(`Error: fetch orders (${response.status})`, response.body);
	return null;
}

export async function fetchOrderById(fetch: typeof globalThis.fetch, id: string) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, `/admin/orders/${id}`);
	if (response.status === 200) {
		const { order }: { order: Order } = response.body;
		return order;
	}

	console.error(`Error: fetch order by ID (${response.status})`, response.body);
	return null;
}

export async function fetchOrderNotes(fetch: typeof globalThis.fetch, order_id: string) {
	const response = await medusa.get(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/notes?resource_id=${order_id}`
	);
	if (response.status === 200) {
		const { notes }: { notes: Note[] } = response.body;
		return notes;
	}

	console.error(`Error: fetch order notes (${response.status})`, response.body);
	return null;
}

export async function createFulfillment(
	fetch: typeof globalThis.fetch,
	order_id: string,
	items: { item_id: string; quantity: number }[]
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/orders/${order_id}/fulfillment`,
		{
			items,
			no_notification: true
		}
	);
	if (response.status === 200) {
		const { order }: { order: Order } = response.body;
		return order;
	}

	console.error(`Error: fulfill order (${response.status})`, response.body);
	return null;
}

export async function cancelFulfillment(
	fetch: typeof globalThis.fetch,
	order_id: string,
	fulfillment_id: string
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/orders/${order_id}/fulfillments/${fulfillment_id}/cancel`
	);
	if (response.status === 200) {
		const { order }: { order: Order } = response.body;
		return order;
	}

	console.error(`Error: cancel fulfillment (${response.status})`, response.body);
	return null;
}

export async function shipFulfillment(
	fetch: typeof globalThis.fetch,
	order_id: string,
	fulfillment_id: string,
	tracking_numbers: string[]
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/orders/${order_id}/shipment`,
		{
			fulfillment_id,
			tracking_numbers,
			no_notification: false
		}
	);
	if (response.status === 200) {
		const { order }: { order: Order } = response.body;
		return order;
	}

	console.error(`Error: ship fulfillment (${response.status})`, response.body);
	return null;
}

export async function fetchProduct(fetch: typeof globalThis.fetch, product_id: string) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, `/admin/products/${product_id}`);
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: fetch product (${response.status})`, response.body);
	return null;
}

export async function fetchProducts(
	fetch: typeof globalThis.fetch,
	filters?: Record<string, string>
) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, '/admin/products', filters);
	if (response.status === 200) {
		const { products }: { products: Product[] } = response.body;
		return products;
	}

	console.error(`Error: fetch products (${response.status})`, response.body);
	return null;
}

export async function fetchProductCategories(fetch: typeof globalThis.fetch) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, '/admin/product-categories', {
		parent_category_id: 'null',
		include_descendants_tree: 'true',
		is_active: 'true'
	});
	if (response.status === 200) {
		const { product_categories }: { product_categories: ProductCategory[] } = response.body;
		return product_categories;
	}

	console.error(`Error: fetch product categories (${response.status})`, response.body);
	return null;
}

export async function fetchProductById(
	fetch: typeof globalThis.fetch,
	filters: Record<string, string>
) {
	const response = await medusa.get(fetch, MEDUSA_BACKEND_URL, `/admin/products`, filters);
	if (response.status === 200) {
		const { products }: { products: Product[] } = response.body;
		return products;
	}

	console.error(`Error: fetch product by ID (${response.status})`, response.body);
	return null;
}

export async function changeProductStatus(
	fetch: typeof globalThis.fetch,
	product_id: string,
	status: 'draft' | 'published'
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${product_id}`, {
		status
	});
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: change product status (${response.status})`, response.body);
	return null;
}

export async function createProduct(fetch: typeof globalThis.fetch, product: ProductDto) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, '/admin/products', { ...product });
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: create product (${response.status})`, response.body);
	return null;
}

export async function deleteProduct(fetch: typeof globalThis.fetch, product_id: string) {
	type DeletedProduct = {
		id: string;
		object: string;
		deleted: boolean;
	};

	const response = await medusa.del(fetch, MEDUSA_BACKEND_URL, `/admin/products/${product_id}`);
	if (response.status === 200) {
		const deleted: DeletedProduct = response.body;
		return deleted;
	}

	console.error(`Error: delete product (${response.status})`, response.body);
	return null;
}

export async function updateUser(
	fetch: typeof globalThis.fetch,
	user_id: string,
	user: z.infer<typeof vendorInfoSchema>
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/users/${user_id}`, {
		first_name: user.first_name,
		last_name: user.last_name,
		metadata: {
			phone_number: user.phone ?? ''
		}
	});

	if (response.status === 200) {
		const { user }: { user: User } = response.body;
		return user;
	}

	console.error(`Error: update user (${response.status})`, response.body);
	return null;
}

export async function updateStoreDetails(
	fetch: typeof globalThis.fetch,
	store: z.infer<typeof businessDetailsSchema>
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, '/admin/store', {
		metadata: {
			company_name: store.business_name ?? '',
			phone: store.phone,
			email: store.email
		}
	});

	if (response.status === 200) {
		const { store }: { store: Store } = response.body;
		return store;
	}

	console.error(`Error: update store details (${response.status})`, response.body);
	return null;
}

export async function fetchProductVariants(fetch: typeof globalThis.fetch, product_id: string) {
	const response = await medusa.get(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/variants`
	);
	if (response.status === 200) {
		const { variants }: { variants: ProductVariant[] } = response.body;
		return variants;
	}

	console.error(`Error: fetch product variants (${response.status})`, response.body);
	return null;
}

export async function createProductVariant(
	fetch: typeof globalThis.fetch,
	id: string,
	variant: ProductVariantDto
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${id}/variants`, {
		...variant
	});
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: create product variant (${response.status})`, response.body);
	return null;
}

export async function updateGeneralProductInfo(
	fetch: typeof globalThis.fetch,
	details: z.infer<typeof updateGeneralInfoSchema>
) {
	const { product_id, ...generalInfo } = details;
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${product_id}`, {
		...generalInfo
	});

	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update general product info (${response.status})`, response.body);
	return null;
}

export async function updateProductVariant(
	fetch: typeof globalThis.fetch,
	product_id: string,
	variant_id: string,
	variant: ProductVariantDto
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/variants/${variant_id}`,
		{ ...variant }
	);
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update product variant (${response.status})`, response.body);
	return null;
}

export async function deleteProductVariant(
	fetch: typeof globalThis.fetch,
	product_id: string,
	variant_id: string
) {
	const response = await medusa.del(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/variants/${variant_id}`
	);

	type DeletedVariant = {
		variant_id: string;
		object: string;
		deleted: boolean;
		product: Product;
	};

	if (response.status === 200) {
		const deletedVariant: DeletedVariant = response.body;
		return deletedVariant;
	}

	console.error(`Error: delete product variant (${response.status})`, response.body);
	return null;
}

export async function createProductOption(
	fetch: typeof globalThis.fetch,
	id: string,
	title: string
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${id}/options`, {
		title
	});
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: create product option (${response.status})`, response.body);
	return null;
}

export async function updateProductOption(
	fetch: typeof globalThis.fetch,
	product_id: string,
	option_id: string,
	title: string
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/options/${option_id}`,
		{ title }
	);
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update product option (${response.status})`, response.body);
	return null;
}

export async function deleteProductOption(
	fetch: typeof globalThis.fetch,
	product_id: string,
	option_id: string
) {
	const response = await medusa.del(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/options/${option_id}`
	);

	type DeletedOption = {
		option_id: string;
		object: string;
		deleted: boolean;
		product: Product;
	};

	if (response.status === 200) {
		const deletedProduct: DeletedOption = response.body;
		return deletedProduct;
	}

	console.error(`Error: delete product option (${response.status})`, response.body);
	return null;
}

export async function uploadImages(fetch: typeof globalThis.fetch, form: FormData) {
	const response = await medusa.postBlob(fetch, MEDUSA_BACKEND_URL, '/admin/uploads', form);

	type ImageUpload = {
		url: string;
		key: string;
	};

	if (response.status === 200) {
		const { uploads }: { uploads: ImageUpload[] } = response.body;
		return uploads;
	}

	console.error(`Error: upload images (${response.status})`, response.body);
	return null;
}

export async function deleteUpload(fetch: typeof globalThis.fetch, key: string) {
	const response = await medusa.del(fetch, MEDUSA_BACKEND_URL, '/admin/uploads', { file_key: key });

	type DeletedUpload = {
		id: string;
		object: string;
		deleted: boolean;
	};

	if (response.status === 200) {
		const { deleted }: { deleted: DeletedUpload } = response.body;
		return deleted;
	}

	console.error(`Error: delete upload (${response.status})`, response.body);
	return null;
}

export async function updateProductThumbnail(
	fetch: typeof globalThis.fetch,
	id: string,
	url: string | null
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${id}`, {
		thumbnail: url
	});
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update product thumbnail (${response.status})`, response.body);
	return null;
}

export async function updateVariantThumbnail(
	fetch: typeof globalThis.fetch,
	product_id: string,
	variant_id: string,
	url: string
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/variants/${variant_id}`,
		{ thumbnail: url }
	);
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update variant thumbnail (${response.status})`, response.body);
	return null;
}

export async function updateProductImages(
	fetch: typeof globalThis.fetch,
	id: string,
	images: string[]
) {
	const response = await medusa.post(fetch, MEDUSA_BACKEND_URL, `/admin/products/${id}`, {
		images
	});
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update product images (${response.status})`, response.body);
	return null;
}

export async function updateVariantImages(
	fetch: typeof globalThis.fetch,
	product_id: string,
	variant_id: string,
	images: string[]
) {
	const response = await medusa.post(
		fetch,
		MEDUSA_BACKEND_URL,
		`/admin/products/${product_id}/variants/${variant_id}`,
		{ images }
	);
	if (response.status === 200) {
		const { product }: { product: Product } = response.body;
		return product;
	}

	console.error(`Error: update variant images (${response.status})`, response.body);
	return null;
}
