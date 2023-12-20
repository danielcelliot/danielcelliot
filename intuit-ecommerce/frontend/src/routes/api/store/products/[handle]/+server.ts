import { MEDUSA_BACKEND_URL } from '$env/static/private';
import type { RequestHandler } from './$types';
import type { ProductPageCategory, ProductPageData } from '$lib/types/shop';
import {
	ProductStatus,
	type Product,
	type ProductCategory,
	type ProductVariant
} from '$lib/types/medusa';
import { json } from '@sveltejs/kit';
import { filterOption } from '$lib/client/shop';
import { formatErrorResponse } from '$lib/server/shop';

/* We use this endpoint to get a single product. Only this endpoint returns specific fields
  that we require to display on our product page */

// List Products
// https://docs.medusajs.com/api/store#products_getproducts
function getOptionAvailability(value: string, variants: ProductVariant[]) {
	return variants
		.filter((variant) => variant.options.some((o) => o.value === value))
		.some((m) => m.inventory_quantity > 0);
}

function formatCategories(categories: ProductCategory[]) {
	const getChildren = (
		parent_id: string,
		children: ProductPageCategory[]
	): ProductPageCategory[] => {
		const child = categories.find((c) => c.parent_category_id === parent_id);

		if (child && child.parent_category_id) {
			children.push({
				name: child.name,
				handle: child.handle
			});

			return getChildren(child.id, children);
		}

		return children;
	};

	const parent = categories.find((c) => c.parent_category_id === null);

	if (parent) {
		const arr: ProductPageCategory[] = [
			{
				name: parent.name,
				handle: parent.handle
			}
		];

		const categories = getChildren(parent.id, arr);

		return categories;
	}
}

function getProductData(product: Product): ProductPageData {
	return {
		categories: formatCategories(product.categories ?? []) ?? [],
		condition: product.condition,
		description: product.description,
		id: product.id,
		images: product.images.map((i) => i.url),
		metadata: product.metadata,
		options:
			product.options?.map((option) => {
				return {
					id: option.id,
					name: option.title,
					values: (() => {
						const uniqueOpts = filterOption(option);

						const values: { value: string; isAvailable: boolean }[] = uniqueOpts.map((option) => {
							return {
								value: option.value,
								isAvailable: getOptionAvailability(option.value, product.variants ?? [])
							};
						});

						return values;
					})()
				};
			}) ?? [],
		subtitle: product.subtitle,
		thumbnail: product.thumbnail,
		title: product.title,
		variant_type: product.variant_type,
		variants:
			product.variants?.map((variant) => {
				return {
					id: variant.id,
					images: variant.images.map((i) => i.url),
					metadata: variant.metadata,
					options: variant.options.map((o) => {
						return {
							id: o.id,
							option_id: o.option_id,
							value: o.value
						};
					}),
					prices:
						variant.prices?.map((p) => {
							return {
								amount: p.amount,
								currency_code: p.currency_code
							};
						}) ?? [],
					quantity: variant.inventory_quantity,
					thumbnail: variant.thumbnail,
					title: variant.title
				};
			}) ?? []
	};
}

export const GET: RequestHandler = async ({ fetch, params }) => {
	const searchParams = new URLSearchParams({
		handle: params.handle,
		expand:
			'categories,images,options,options.values,variants,variants.images,variants.options,variants.prices'
	});

	const response = await fetch(`${MEDUSA_BACKEND_URL}/store/products?${searchParams}`);
	if (response.ok) {
		const { products }: { products: Product[] } = await response.json();
		if (products[0].status === ProductStatus.PUBLISHED) {
			const product = products[0];
			return json(getProductData(product));
		} else {
			return json({ message: 'Not found' }, { status: 404 });
		}
	}

	return formatErrorResponse(response);
};
