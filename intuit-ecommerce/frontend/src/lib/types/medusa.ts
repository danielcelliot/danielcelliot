export enum VariantType {
	SINGLE = 'single',
	MULTI = 'multi'
}

export enum ProductCondition {
	NEW = 'new',
	USED = 'used',
	NOT_WORKING = 'not_working'
}

export enum ProductStatus {
	DRAFT = 'draft',
	PROPOSED = 'proposed',
	PUBLISHED = 'published',
	REJECTED = 'rejected'
}

export enum PaymentStatus {
	AUTHORIZED = 'authorized',
	REQUIRES_MORE = 'requires_more',
	ERROR = 'error',
	CANCELED = 'canceled',
	NOT_PAID = 'not_paid',
	AWAITING = 'awaiting',
	CAPTURED = 'captured',
	PARTIALLY_REFUNDED = 'partially_refunded',
	REFUNDED = 'refunded',
	REQUIRES_ACTION = 'requires_action'
}

export enum CartStatus {
	ORDER = 'order',
	CART = 'cart',
	SWAP = 'swap'
}

export enum OrderStatus {
	PENDING = 'pending',
	COMPLETED = 'completed',
	ARCHIVED = 'archived',
	CANCELED = 'canceled',
	REQUIRES_ACTION = 'requires_action'
}

export enum FulfillmentStatus {
	NOT_FULFILLED = 'not_fulfilled',
	PARTIALLY_FULFILLED = 'partially_fulfilled',
	FULFILLED = 'fulfilled',
	PARTIALLY_SHIPPED = 'partially_shipped',
	SHIPPED = 'shipped',
	PARTIALLY_RETURNED = 'partially_returned',
	RETURNED = 'returned',
	CANCELED = 'canceled',
	REQUIRES_ACTION = 'requires_action'
}

export interface User {
	id: string;
	role: string;
	email: string;
	first_name: string | null;
	last_name: string | null;
	api_token: string | null;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
	metadata: {
		phone_number?: string;
		chat_contact_id?: number;
	} | null;
}

export interface Currency {
	code: string;
	symbol: string;
	symbol_native: string;
	name: string;
}

export interface Store {
	id: string;
	created_at: string | Date;
	updated_at: string | Date;
	name: string;
	default_currency_code: string;
	swap_link_template: null;
	payment_link_template: null;
	invite_link_template: null;
	default_location_id: string | null;
	metadata: {
		company_name?: string;
		phone?: string;
		email?: string;
		address_1?: string;
		address_2?: string;
		city?: string;
		region?: string;
	} | null;
	default_sales_channel_id: string;
	currencies: Currency[];
	default_currency: Currency;
	default_sales_channel: {
		id: string;
		created_at: string | Date;
		updated_at: string | Date;
		deleted_at: string | Date | null;
		name: string;
		description: string;
		is_disabled: boolean;
		metadata: object | null;
	};
	payment_providers: {
		id: string;
		is_installed: boolean;
	};
	fulfillment_providers: {
		id: string;
		is_installed: boolean;
	};
	feature_flags: Record<string, boolean>[];
	modules: Record<string, string>[];
}

export interface Customer {
	billing_address: Address | null;
	billing_address_id: string | null;
	created_at: string;
	deleted_at: string | null;
	email: string;
	first_name: string | null;
	has_account: boolean;
	id: string;
	last_name: string | null;
	metadata: {
		cart_id?: string;
		default_address_id?: string;
		chat_contact_id?: number;
	} | null;
	phone: string | null;
	shipping_addresses: Address[];
	updated_at: string;
}

export interface Address {
	id: string;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
	customer_id: string | null;
	company: string | null;
	first_name: string | null;
	last_name: string | null;
	address_1: string | null;
	address_2: string | null;
	city: string | null;
	country_code: string | null;
	province: string | null;
	postal_code: string | null;
	phone: string | null;
	metdata: {
		default?: boolean;
	} | null;
	customer?: Customer | null;
	country?: object | null;
}

export interface Product {
	id: string;
	title: string;
	handle: string | null;
	subtitle: string | null;
	description: string | null;
	is_giftcard: boolean;
	status: ProductStatus;
	thumbnail: string | null;
	weight: number | null;
	length: number | null;
	height: number | null;
	width: number | null;
	origin_country: string | null;
	hs_code: string | null;
	mid_code: string | null;
	material: string | null;
	collection_id: string | null;
	type: ProductType[];
	images: ProductImage[];
	discountable: boolean;
	external_id: string | null;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
	collection?: ProductCollection;
	tags?: ProductTag[];
	options?: ProductOption[];
	variants?: ProductVariant[];
	categories?: ProductCategory[] | null;
	metadata: Record<string, string> | null;
	condition: ProductCondition;
	variant_type: VariantType;
}

export interface ProductVariant {
	allow_backorder: boolean;
	barcode: string | null;
	created_at: string | Date;
	deleted_at: string | Date | null;
	ean: string | null;
	height: number | null;
	hs_code: string | null;
	id: string;
	images: ProductImage[];
	inventory_quantity: number;
	length: number | null;
	manage_inventory: boolean;
	material: string | null;
	metadata: Record<string, unknown> | null;
	mid_code: string | null;
	options: ProductOptionValue[];
	origin_country: string | null;
	prices: ProductPrice[] | null;
	product?: Product;
	product_id: string;
	sku: string | null;
	thumbnail: string | null;
	title: string;
	upc: string | null;
	updated_at: string | Date;
	variant_rank: number | null;
	weight: number | null;
	width: number | null;
}

export interface ProductPrice {
	id: string;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
	currency_code: string;
	amount: number;
	min_quantity?: number | null;
	max_quantity?: number | null;
	price_list_id?: string | null;
	variant_id: string;
	region_id?: string | null;
	price_list?: object | null;
}

export interface ProductCategory {
	id: string;
	name: string;
	description?: string;
	handle: string;
	is_active: boolean;
	is_internal: boolean;
	rank: number;
	parent_category_id: string | null;
	parent_category: ProductCategory | null;
	category_children?: ProductCategory[];
	created_at: string | Date;
	updated_at: string | Date;
}

export interface Note {
	id: string;
	resource_type: string;
	resource_id: string;
	value: string;
	author_id: string | null;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
	metadata: object | null;
}

export interface Fulfillment {
	canceled_at: string | Date | null;
	claim_order_id: string | null;
	created_at: string | Date;
	data: object;
	id: string;
	items: {
		fulfillment_id: string;
		item_id: string;
		quantity: number;
	}[];
	location_id: string | null;
	metadata: object | null;
	no_notification: null;
	order_id: string;
	provider_id: string;
	shipped_at: string | Date | null;
	swap_id: string | null;
	tracking_links: {
		created_at: string | Date;
		deleted_at: string | Date | null;
		fulfillment_id: string;
		id: string;
		idempotency_key: string | null;
		metadata: Record<string, string> | null;
		tracking_number: string;
		updated_at: string | Date;
		url: string | null;
	}[];
	tracking_numbers: string[];
	updated_at: string | Date | null;
}

export interface Order {
	id: string;
	status: string;
	fulfillment_status: string;
	payment_status: string;
	display_id: number;
	cart_id: string | null;
	customer_id: string;
	email: string;
	billing_address_id: string | null;
	shipping_address_id: string | null;
	region_id: string;
	currency_code: string;
	tax_rate: number | null;
	draft_order_id: string | null;
	canceled_at: string | Date | null;
	no_notification: boolean | null;
	idempotency_key: string | null;
	external_id: string | null;
	created_at: string | Date;
	updated_at: string | Date;
	metadata: object | null;
	object: string;
	shipping_total: number;
	discount_total: number;
	tax_total: number;
	refund_total: number;
	total: number;
	subtotal: number;
	paid_total: number;
	refundable_amount: number;
	gift_cart_total: number;
	gift_cart_tax_total: number;
	customer: Customer;
	discounts: object[];
	fulfillments: Fulfillment[] | null;
	items: Item[];
	payments: Payment[];
	region: object;
	shipping_address: Address;
	shipping_methods: ShippingMethod[];
}

export interface Payment {
	id: string;
	swap_id: string | null;
	cart_id: string | null;
	order_id: string | null;
	amount: number;
	amount_refunded: number | null;
	provider_id: string;
	data: {
		status: string;
	};
	captured_at: string | Date;
	idempotency_key: string | null;
	created_at: string | Date;
	updated_at: string | Date;
	metadata: object;
}

export interface Cart {
	id: string;
	email: string | null;
	billing_address_id: string | null;
	shipping_address_id: string | null;
	region_id: string;
	customer_id: string | null;
	payment_session: object | null;
	payment_id: string | null;
	type: string;
	completed_at: string | null;
	payment_authorized_at: string | null;
	idempotency_key: string | null;
	context: object | null;
	created_at: string;
	updated_at: string;
	deleted_at: string | null;
	metadata: object | null;
	billing_address: Address | null;
	shipping_address: Address | null;
	items?: Item[] | null;
	region: object | null;
	discounts: object[] | null;
	gift_cards: object[] | null;
	customer: object | null;
	payment_sessions:
		| {
				id: string;
				created_at: string;
				updated_at: string;
				cart_id: string;
				provider_id: string;
				is_selected: boolean;
				is_initiated: boolean;
				status: string;
				data: {
					status: string;
				};
				idempotency_key: string | null;
				amount: number | null;
				payment_authorized_at: string | null;
		  }[]
		| null;
	payment: object | null;
	shipping_methods:
		| {
				id: string;
				shipping_option_id: string;
				order_id: string | null;
				cart_id: string | null;
				swap_id: string | null;
				return_id: string | null;
				price: number;
				data: object;
				order: object | null;
				claim_order: object | null;
				cart: object | null;
				swap: object | null;
				return_order: object | null;
				shipping_option: ShippingOption;
				tax_lines: object[];
				subtotal: number;
				total: number;
				tax_total: number;
		  }[]
		| null;
	sales_channel_id: string | null;
	sales_channel: object | null;
	shipping_total: number;
	discount_total: number;
	raw_discount_total: number | null;
	item_tax_total: number;
	shipping_tax_total: number;
	tax_total: number;
	refunded_total: number | null;
	total: number;
	subtotal: number;
	refundable_amount: number | null;
	gift_card_total: number | null;
	gift_card_tax_total: number | null;
}

export interface Item {
	id: string;
	created_at: string | Date;
	updated_at: string | Date;
	cart_id: string;
	order_id: string | null;
	swap_id: string | null;
	claim_order_id: string | null;
	original_item_id: string | null;
	order_edit_id: string | null;
	title: string;
	description: string;
	thumbnail: string | null;
	is_return: boolean;
	is_giftcard: boolean;
	should_merge: boolean;
	allow_discounts: boolean;
	has_shipping: boolean;
	unit_price: number;
	variant_id: string;
	quantity: number;
	fulfilled_quantity: number | null;
	returned_quantity: number | null;
	shipped_quantity: number | null;
	metadata: object | null;
	adjustments: object[];
	tax_lines: object[];
	variant: ProductVariant;
	subtotal: number;
	discount_total: number;
	total: number;
	original_total: number;
	original_tax_total: number;
	tax_total: number;
	raw_discount_total: number;
}

export interface ShippingMethod {
	cart_id: string;
	claim_order_id: string | null;
	id: string;
	order_id: string;
	original_tax_total: number;
	original_total: number;
	price: number;
	return_id: string | null;
	shipping_option: ShippingOption;
	shipping_option_id: string;
	subtotal: number;
	swap_id: string | null;
	tax_lines: object;
	tax_total: number;
	total: number;
}

export interface ShippingOption {
	id: string;
	name: string;
	region_id: string;
	profile_id: string;
	provider_id: string;
	price_type: string;
	amount: number;
	is_return: boolean;
	admin_only: boolean;
	data: object | null;
	created_at: string;
	updated_at: string;
	deleted_at: string | null;
	metadata: Record<string, unknown> | null;
	region: object | null;
	profile: object | null;
	provider: object | null;
	requirements: object[];
	price_incl_tax: number;
	tax_rates: object[];
	tax_amount: number;
}

export interface CreateAddress {
	first_name: string;
	last_name: string;
	company?: string;
	address_1: string;
	address_2?: string;
	city: string;
	country_code: string;
	province: string;
	postal_code: string;
	phone: string;
}

export interface CreateProductCategory {
	name: string;
	handle?: string;
	is_active?: boolean;
	is_internal?: boolean;
	rank?: number;
	parent_category_id: string | null;
	metadata?: Record<string, unknown>;
}

export interface UpdateProductCategory {
	name?: string;
	handle?: string;
	is_active?: boolean;
	is_internal?: boolean;
	rank?: number;
	parent_category_id?: string | null;
	metadata?: Record<string, unknown>;
}

export interface ProductTag {
	id: string;
	value: string;
	metadata?: Record<string, unknown> | null;
	products?: Product[];
}

export interface ProductCollection {
	id: string;
	title: string;
	handle: string;
	metadata?: Record<string, unknown> | null;
	deleted_at?: string | Date;
	products?: Product[];
}

export interface ProductType {
	id: string;
	value: string;
	metadata?: Record<string, unknown> | null;
	deleted_at?: string | Date;
}

export interface ProductOption {
	id: string;
	title: string;
	product: Product;
	values: ProductOptionValue[];
	metadata?: Record<string, unknown> | null;
	deleted_at?: string | Date;
}

export interface ProductOptionValue {
	id: string;
	created_at?: string | Date;
	updated_at?: string | Date;
	deleted_at?: string | Date;
	value: string;
	option_id: string;
	option?: ProductOption;
	variant_id: string;
	metadata: Record<string, unknown> | null;
}

export interface ProductImage {
	id: string;
	url: string;
	metadata: Record<string, unknown> | null;
	created_at: string | Date;
	updated_at: string | Date;
	deleted_at: string | Date | null;
}

/* DTO Types (Create & Update) */

export interface ProductDto {
	title: string;
	subtitle?: string;
	description?: string;
	categories: {
		id: string;
	}[];
	images?: string[];
	thumbnail?: string;
	status: 'draft' | 'published';
	metadata?: Record<string, string>;
	options?: {
		title: string;
	}[];
	variants?: {
		title: string;
		prices: {
			amount: number;
			currency_code: string;
		}[];
		options: {
			value: string;
		}[];
		inventory_quantity: number;
		manage_inventory: boolean;
	}[];
	tags?: {
		value: string;
	}[];
	condition: ProductCondition;
	variant_type: VariantType;
}

export interface ProductVariantDto {
	title: string;
	prices: {
		amount: number;
		currency_code: string;
	}[];
	options: {
		option_id: string;
		value: string;
	}[];
	manage_inventory: boolean;
	thumbnail?: string;
	images?: string[];
	inventory_quantity?: number;
	metadata?: Record<string, string>;
}

export interface CreateProductCollection {
	title: string;
	handle?: string;
	products?: Product[];
	metadata?: Record<string, unknown>;
}

export interface UpdateProductCollection {
	id: string;
	value?: string;
	title?: string;
	handle?: string;
	products?: Product[];
	metadata?: Record<string, unknown>;
}

export interface CreateProductType {
	id?: string;
	value: string;
	metadata?: Record<string, unknown>;
}

export interface UpsertProductType {
	id?: string;
	value: string;
}

export interface UpdateProductType {
	id: string;
	value?: string;
	metadata?: Record<string, unknown>;
}

export interface CreateProductTag {
	value: string;
}

export interface UpsertProductTag {
	id?: string;
	value: string;
}

export interface UpdateProductTag {
	id: string;
	value?: string;
}

export interface CreateProductOption {
	title: string;
	product_id?: string;
	product?: Record<any, any>;
}

export interface UpdateProductOption {
	id: string;
	title?: string;
	product_id?: string;
}

export interface CreateProduct {
	title: string;
	subtitle?: string;
	description?: string;
	is_giftcard?: boolean;
	discountable?: boolean;
	images?: string[] | { id?: string; url: string }[];
	thumbnail?: string;
	handle?: string;
	status?: ProductStatus;
	type?: CreateProductType;
	type_id?: string;
	collection_id?: string;
	tags?: CreateProductTag[];
	categories?: { id: string }[];
	options?: CreateProductOption[];
	variants?: unknown;
	width?: number;
	height?: number;
	length?: number;
	weight?: number;
	origin_country?: string;
	hs_code?: string;
	material?: string;
	mid_code?: string;
	metadata?: Record<string, unknown>;
}

export interface UpdateProduct {
	id: string;
	title?: string;
	subtitle?: string;
	description?: string;
	is_giftcard?: boolean;
	discountable?: boolean;
	images?: string[] | { id?: string; url: string }[];
	thumbnail?: string;
	handle?: string;
	status?: ProductStatus;
	type?: CreateProductType;
	type_id?: string | null;
	collection_id?: string | null;
	tags?: CreateProductTag[];
	categories?: { id: string }[];
	options?: CreateProductOption[];
	variants?: (CreateProductVariant | UpdateProductVariant)[];
	width?: number;
	height?: number;
	length?: number;
	weight?: number;
	origin_country?: string;
	hs_code?: string;
	material?: string;
	mid_code?: string;
	metadata?: Record<string, unknown>;
}

export interface CreateProductOnly {
	title: string;
	subtitle?: string;
	description?: string;
	is_giftcard?: boolean;
	discountable?: boolean;
	images?: { id?: string; url: string }[];
	thumbnail?: string;
	handle?: string;
	status?: ProductStatus;
	collection_id?: string;
	width?: number;
	height?: number;
	length?: number;
	weight?: number;
	origin_country?: string;
	hs_code?: string;
	material?: string;
	mid_code?: string;
	metadata?: Record<string, unknown>;
	tags?: { id: string }[];
	categories?: { id: string }[];
	type_id?: string;
}

export interface UpdateProductVariantOnly {
	id: string;
	title?: string;
	sku?: string;
	barcode?: string;
	ean?: string;
	upc?: string;
	allow_backorder?: boolean;
	inventory_quantity?: number;
	manage_inventory?: boolean;
	hs_code?: string;
	origin_country?: string;
	mid_code?: string;
	material?: string;
	weight?: number;
	length?: number;
	height?: number;
	width?: number;
	options?: (CreateProductVariantOption & { option: unknown })[];
	metadata?: Record<string, unknown>;
}

export interface CreateProductOptionOnly {
	product_id?: string;
	product?: Record<string, unknown>;
	title: string;
}
