import type { ProductCondition, VariantType } from './medusa';

export type SearchAttributes = {
	categories: string[];
	condition: ProductCondition;
	description: string | null;
	handle: string;
	images:
		| {
				url: string;
		  }[]
		| null;
	metadata: Record<string, string>;
	options: {
		id: string;
		title: string;
	}[];
	subtitle: string | null;
	tags: {
		value: string;
	}[];
	thumbnail: string | null;
	title: string;
	variants: {
		id: string;
		inventory_quantity: number;
		options: {
			option_id: string;
			value: string;
		}[];
		prices: {
			amount: number;
			currency_code: string;
		}[];
		thumbnail: string | null;
	}[];
};

export type ProductVariantFormData = {
	product_id: string;
	variant_id: string;
	title: string;
	price: number;
	inventory_quantity: number;
	length?: number;
	weight?: number;
	height?: number;
	width?: number;
	options?:
		| {
				option_id: string;
				title: string;
				value: string;
		  }[]
		| undefined;
	thumbnail: string | null;
	images: string[];
};

export type ProductPageCategory = {
	name: string;
	handle: string;
};

export type ProductPageOption = {
	id: string;
	name: string;
	values: {
		value: string;
		isAvailable: boolean;
	}[];
};

export type CartPageItemData = {
	id: string;
	quantity: number;
	subtotal: number;
	thumbnail: string | null;
	title: string;
	total: number;
	unit_price: number;
	variant: {
		id: string;
		inventory_quantity: number;
		options: {
			name: string;
			value: string;
		}[];
		product: {
			condition: ProductCondition;
			handle: string;
			variant_type: VariantType;
		};
		thumbnail: string | null;
		title: string;
	};
};

export type CartPageData = {
	id: string;
	items: CartPageItemData[];
	subtotal: number;
	shipping_total: number;
	total: number;
	completed_at: string | null;
	payment_sessions:
		| {
				provider_id: string;
				is_selected: boolean;
		  }[]
		| null;
	shipping_methods:
		| {
				id: string;
				price: number;
				shipping_option: {
					id: string;
					name: string;
					amount: number;
				};
		  }[]
		| null;
};

export type ProductPageData = {
	categories: ProductPageCategory[];
	condition: ProductCondition;
	description: string | null;
	id: string;
	images: string[];
	metadata: Record<string, string> | null;
	options: ProductPageOption[];
	subtitle: string | null;
	thumbnail: string | null;
	title: string;
	variant_type: VariantType;
	variants: {
		id: string;
		images: string[];
		metadata: Record<string, unknown> | null;
		options: {
			id: string;
			option_id: string;
			value: string;
		}[];
		prices: {
			amount: number;
			currency_code: string;
		}[];
		quantity: number;
		thumbnail: string | null;
		title: string;
	}[];
};
