import { ProductCondition, type ProductOption, type ProductVariant } from '$lib/types/medusa';

export const DEFAULT_PAGE_LIMIT = 10;
const ACCEPTED_MIME_TYPES = ['image/jpeg', 'image/pjpeg', 'image/png', 'image/webp'];

function getValidTypes(files: File[]) {
	const list: File[] = [];
	for (const file of files) {
		if (ACCEPTED_MIME_TYPES.includes(file.type)) {
			list.push(file);
		} else {
			alert(`Invalid image format: ${file.name}`);
		}
	}

	return list;
}

export function convertToDecimal(amount: number) {
	return Math.floor(amount) / 100;
}

export function formatPrice(amount: number, code: string = 'usd') {
	return new Intl.NumberFormat('en-US', {
		style: 'currency',
		currency: code,
		minimumFractionDigits: 2
	}).format(convertToDecimal(amount));
}

export function getProductVariantPricing(
	prices: { amount: number; currency_code: string }[],
	code: string
) {
	const priceRanges: number[] = [];
	const pricing: { low: number; high: number } = { low: 0, high: 0 };

	prices.forEach((price) => {
		if (price.currency_code === code) priceRanges.push(price.amount);
	});

	if (priceRanges.length > 1) {
		const sorted = priceRanges.sort((a, b) => a - b);
		pricing.low = sorted.at(0)!;
		pricing.high = sorted.at(-1)!;
	} else if (priceRanges.length === 1) {
		pricing.low = priceRanges[0];
		pricing.high = priceRanges[0];
	}

	return pricing;
}

export function isPricingVariable(pricing: { low: number; high: number }) {
	return pricing.low !== pricing.high;
}

export function formatPricing(pricing: { low: number | null; high: number | null }) {
	if (pricing.low && pricing.high) {
		return pricing.low !== pricing.high
			? `${formatPrice(pricing.low)} to ${formatPrice(pricing.high)}`
			: `${formatPrice(pricing.low)}`;
	}

	return 'Region pricing not available';
}

export function filterOption(option: ProductOption) {
	const uniqueValues = option.values.filter((v, i) => {
		return (
			option.values.findIndex((x) => {
				return x.option_id == v.option_id && x.value == v.value;
			}) == i
		);
	});

	return uniqueValues;
}

export function timeAgo(input: string | number | Date) {
	const date = input instanceof Date ? input : new Date(input);
	const formatter = new Intl.RelativeTimeFormat('en');
	const ranges = {
		years: 3600 * 24 * 365,
		months: 3600 * 24 * 30,
		weeks: 3600 * 24 * 7,
		days: 3600 * 24,
		hours: 3600,
		minutes: 60,
		seconds: 1
	};
	const secondsElapsed = (date.getTime() - Date.now()) / 1000;

	for (const key in ranges) {
		if (ranges[key as keyof typeof ranges] < Math.abs(secondsElapsed)) {
			const delta = secondsElapsed / ranges[key as keyof typeof ranges];
			return formatter.format(Math.round(delta), key as keyof typeof ranges);
		}
	}
}

export function getFileSize(size: number) {
	if (size < 1024) {
		return `${size} bytes`;
	} else if (size >= 1024 && size < 1048576) {
		return `${(size / 1024).toFixed(2)} KB`;
	} else if (size >= 1048576) {
		return `${(size / 1048576).toFixed(2)} MB`;
	}
}

export function dropFiles(e: DragEvent) {
	const list: File[] = [];
	if (e.dataTransfer?.items) {
		for (const i of e.dataTransfer.items) {
			const file = i.getAsFile();
			if (file) list.push(file);
		}
	} else if (e.dataTransfer?.files) {
		for (const f of e.dataTransfer.files) {
			list.push(f);
		}
	}

	const valid = getValidTypes(list);
	return valid;
}

export function inputFiles(e: Event) {
	const files = (e.target as HTMLInputElement).files;
	if (files && files.length) {
		const list: File[] = [];
		for (const f of files) {
			list.push(f);
		}

		const valid = getValidTypes(list);
		return valid;
	}

	return null;
}

export function deleteFile(remove: string, files: File[]) {
	const filtered = files.filter((u) => u.name !== remove);
	files = [...filtered];

	return files;
}

export function addFiles(add: File[], files: File[]) {
	const filtered = add.filter((f) => !files.some((u) => u.name === f.name));
	files = [...filtered, ...files];

	return files;
}

export function getProductCondition(conditions: ProductCondition) {
	switch (conditions) {
		case ProductCondition.NEW:
			return 'New';
		case ProductCondition.USED:
			return 'Used';
		case ProductCondition.NOT_WORKING:
			return 'For Parts (Not Working)';
	}
}

export function getProductConditionStore(conditions: ProductCondition) {
	switch (conditions) {
		case ProductCondition.NEW:
			return 'Brand New';
		case ProductCondition.USED:
			return 'Pre-Owned';
		case ProductCondition.NOT_WORKING:
			return 'Parts Only';
	}
}

export function getInventoryCounts(variants: ProductVariant[]) {
	return variants.map((v) => v.inventory_quantity).reduce((acc, curr) => acc + curr);
}

export function getUniqueImages(images: (string | null)[]) {
	const unique = new Set<string>();

	for (const url of images) {
		if (url) unique.add(url);
	}

	return unique;
}
