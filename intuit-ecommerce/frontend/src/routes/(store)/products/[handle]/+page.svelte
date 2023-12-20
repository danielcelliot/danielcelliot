<script lang="ts">
	import type { ActionData, PageServerData } from './$types';
	import type { ProductPageOption } from '$lib/types/shop';
	import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';
	import { page } from '$app/stores';
	import {
		DEFAULT_PAGE_LIMIT,
		formatPrice,
		formatPricing,
		getProductCondition,
		getProductVariantPricing
	} from '$lib/client/shop';
	import { VariantType, type Item } from '$lib/types/medusa';
	import { isEqual } from 'lodash';
	import { superForm, type FormResult } from 'sveltekit-superforms/client';
	import { onMount } from 'svelte';
	import { scale, slide } from 'svelte/transition';
	import { flyAndScale } from '$lib/utils/ui';
	import { createSelect, melt } from '@melt-ui/svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Label } from '$lib/components/ui/label';
	import { Button } from '$lib/components/ui/button';
	import { Separator } from '$lib/components/ui/separator';
	import * as Select from '$lib/components/ui/select';
	import * as Accordion from '$lib/components/ui/accordion';
	import * as Card from '$lib/components/ui/card';
	import * as Sheet from '$lib/components/ui/sheet';
	import * as Alert from '$lib/components/ui/alert';
	import { CaretSort, Check } from 'radix-icons-svelte';
	import { AlertCircle, CheckCircle2, Image, Loader2, ShoppingBag } from 'lucide-svelte';
	import { queryParam } from 'sveltekit-search-params';

	export let data: PageServerData;

	$: ({ product } = data);

	let mounted = false;
	let maxQuantity = 10;
	let quantityRange = Array.from({ length: maxQuantity }, (_, i) => i + 1);
	let price: number | undefined;
	let priceRange: string | undefined;
	let userSelections: Record<string, string> = {};
	let productVariants: Record<string, Record<string, string>> = {};
	let stockAmt: number | undefined;
	let variantId: string | undefined;
	let disableBtn: boolean;
	let images: string[] = [];
	let addedToCartOpen = false;
	let cartItem: Item | undefined;
	let defaultSelections: { id: string; name: string; value: string }[] = [];

	const currencyCode: string = PUBLIC_STORE_CURRENCY_CODE;

	const { enhance, errors, message, delayed, submitting } = superForm(data.form, {
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onResult: (event) => {
			const result = event.result as FormResult<ActionData>;
			if (result.type === 'success') {
				console.log('Line item returned from form:', result.data?.form.message.data);

				cartItem = result.data?.form.message.data;
				if (cartItem) addedToCartOpen = true;
			}
		},
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const {
		elements: { trigger, menu, option: selectOption, group, groupLabel },
		states: { selectedLabel, open, selected },
		helpers: { isSelected }
	} = createSelect({
		defaultSelected: {
			value: quantityRange[0],
			label: quantityRange[0].toString()
		},
		preventScroll: true,
		forceVisible: true,
		positioning: {
			placement: 'top',
			fitViewport: false,
			sameWidth: true
		}
	});

	function updateSelected(option_id: string, value: string) {
		userSelections[option_id] = value;

		let allSelected = true;
		disableBtn = false;

		// Check if user selected all available options
		for (const selection of Object.values(userSelections)) {
			if (selection == undefined) allSelected = false;
		}

		if (allSelected) {
			if ($errors.variant_id) $errors.variant_id = undefined;

			variantId = findVariant(userSelections);
			if (variantId) {
				const variantImages = getVariantImages(variantId);
				if (variantImages && variantImages.length) {
					images = variantImages;
				} else {
					images = product.images;
				}

				stockAmt = getVariantStockAmt(variantId);

				if (stockAmt && stockAmt < maxQuantity) {
					maxQuantity = stockAmt;
					if ($selected && $selected.value > stockAmt) {
						$selected = {
							label: stockAmt.toString(),
							value: stockAmt
						};
					}
				} else if (stockAmt && stockAmt > maxQuantity) {
					maxQuantity = 10;
				} else {
					disableBtn = true;
				}

				price = getVariantPrice(variantId, currencyCode);
			} else {
				stockAmt = 0;
				price = undefined;
				disableBtn = true;
				images = product.images;
			}
		}
	}

	function findVariant(options: Record<string, string>) {
		let id: string | undefined;
		for (const key in productVariants) {
			if (isEqual(productVariants[key], options)) id = key;
		}

		return id;
	}

	function getVariantStockAmt(id: string) {
		return product.variants.find((variant) => variant.id == id)?.quantity;
	}

	function getVariantPrice(id: string, code: string) {
		return product.variants
			.find((variant) => variant.id == id)
			?.prices.find((price) => price.currency_code == code)?.amount;
	}

	function getVariantImages(variantId: string) {
		return product.variants.find((v) => v.id === variantId)?.images;
	}

	function getDefaultSelect(option: ProductPageOption) {
		const found = defaultSelections.find((s) => s.id === option.id);

		if (found) return { value: found.value, label: found.value };

		return undefined;
	}

	onMount(() => {
		if (product.variant_type === VariantType.SINGLE) {
			variantId = product.variants[0].id;
			stockAmt = product.variants[0].quantity;
			price = getVariantPrice(variantId, currencyCode);
		}

		images = product.images;

		priceRange = formatPricing(
			getProductVariantPricing(
				product.variants.flatMap(
					(v) =>
						v.prices?.map((p) => {
							return {
								amount: p.amount,
								currency_code: p.currency_code
							};
						}) ?? []
				),
				currencyCode
			)
		);

		// Initialize user selections
		for (const option of product.options) {
			Object.assign(userSelections, { [option.id]: undefined });
		}

		// Get all variant combinations
		for (const variant of product.variants) {
			const temp: Record<string, string> = {};

			for (const option of variant.options) {
				temp[option.option_id] = option.value;
			}

			productVariants[variant.id] = temp;
		}

		// Get all search params
		const searchParams = $page.url.searchParams;

		// Check if search param exists in products.options
		if (searchParams) {
			for (const [key, value] of searchParams.entries()) {
				const foundKey = product.options.find(
					(o) => o.name.toLowerCase() === key.replace('_', ' ').toLowerCase()
				);

				if (foundKey) {
					const foundVal = foundKey.values.find(
						(v) => v.value.toLowerCase() === value.replace('_', ' ').toLowerCase()
					);

					if (foundVal) {
						const defaultSelection = {
							id: foundKey.id,
							name: foundKey.name,
							value: foundVal.value
						};

						defaultSelections = [...defaultSelections, defaultSelection];
					}
				}
			}

			if (defaultSelections.length)
				defaultSelections.forEach((selection) => updateSelected(selection.id, selection.value));

			mounted = true;
		}
	});

	$: quantityRange = Array.from({ length: maxQuantity }, (_, i) => i + 1);

	// $: console.log('Product options:', product.options);
	// $: console.log('Default selections:', defaultSelections);
</script>

<main class="container mx-auto my-4 px-2 min-[380px]:px-4">
	<div class="grid gap-4">
		<!-- Breadcrumbs -->
		<div class="flex flex-wrap items-center space-x-0.5 text-sm font-normal text-muted-foreground">
			<a href="/">
				<p class="underline underline-offset-4 hover:no-underline">Home</p>
			</a>

			<span class="px-1">/</span>

			{#each product.categories as { name, handle }, i}
				<a href="/categories/{handle}?limit={DEFAULT_PAGE_LIMIT}&offset=0">
					<p class="text-muted-foreground underline underline-offset-4 hover:no-underline">
						{name}
					</p>
				</a>
				{#if i !== product.categories.length - 1}
					<span class="px-1">/</span>
				{/if}
			{/each}
		</div>

		<div class="grid gap-1.5 pt-2">
			<!-- Product title -->
			<h1 class="text-xl font-semibold leading-none tracking-tight">{product.title}</h1>

			<!-- Pricing -->
			{#if priceRange}
				<p class="truncate text-base font-normal text-muted-foreground">
					{priceRange}
				</p>
			{/if}
		</div>

		<!-- Image carousel -->
		<div
			class="no-scrollbar no-scrollbar::-webkit-scrollbar grid h-full snap-x snap-mandatory grid-flow-col gap-2 overflow-x-scroll px-12">
			{#each images as url}
				<div class="w-[320px] snap-center">
					<AspectRatio ratio={3 / 4}>
						<img class="h-full w-full rounded-xl object-cover" src={url} alt="" />
					</AspectRatio>
				</div>
			{/each}
		</div>

		<!-- Seller info -->

		<!-- Selections -->
		<div class="grid gap-2">
			<div class="grid grid-cols-4 items-center gap-4">
				<p class="col-span-1 text-sm font-medium leading-5 text-muted-foreground">Condition</p>
				<p class="col-span-3 text-sm font-medium">
					{getProductCondition(product.condition)}
				</p>

				{#if product.variant_type === VariantType.MULTI && mounted}
					{#each product.options as option}
						<Label for={option.name.toLowerCase()} class="col-span-1 line-clamp-2 leading-5">
							{option.name}
						</Label>
						<Select.Root
							positioning={{ placement: 'top', sameWidth: true }}
							selected={getDefaultSelect(option)}>
							<Select.Trigger
								class="col-span-3 rounded-2xl 
                  {$errors.variant_id
									? 'border-destructive focus:ring-destructive focus-visible:ring-destructive'
									: ''}">
								<Select.Value placeholder="Select {option.name.toLowerCase()}" class="truncate" />
							</Select.Trigger>
							<Select.Content class="rounded-2xl">
								<Select.Group>
									{#each option.values as { value, isAvailable }}
										<Select.Item
											class="rounded-xl"
											on:click={() => {
												updateSelected(option.id, value);

												// Update url parameters
												const selected = queryParam(option.name.replaceAll(' ', '_').toLowerCase());
												selected.set(value.replaceAll(' ', '_').toLowerCase());
											}}
											disabled={!isAvailable}
											{value}
											label={value}>
											{isAvailable ? `${value}` : `${value} (Out of stock)`}
										</Select.Item>
									{/each}
								</Select.Group>
							</Select.Content>
						</Select.Root>
					{/each}
				{/if}
			</div>
		</div>

		<form action="?/add" method="POST" use:enhance>
			<input type="hidden" name="variant_id" value={variantId ? variantId : ''} />
			<input type="hidden" name="quantity" value={$selected?.value} />

			<div class="grid gap-2">
				{#if $errors.variant_id}
					<div transition:slide>
						<Alert.Root
							variant="destructive"
							class="mx-auto w-fit bg-destructive text-destructive-foreground">
							<Alert.Description class="flex text-xs">
								<AlertCircle class="mr-2 h-4 w-4" />
								{$errors.variant_id}
							</Alert.Description>
						</Alert.Root>
					</div>
				{/if}

				<!-- Stock info: Variants -->
				<div class="flex items-center gap-2">
					{#if stockAmt !== undefined}
						<div class="flex items-center" transition:slide>
							<span
								class="mr-1.5 h-2 w-2 rounded-full {stockAmt > 0
									? 'bg-[#22C55E]'
									: 'bg-[#F23030]'}" />
							<p
								class="text-base font-normal leading-none {stockAmt > 0
									? 'text-[#22C55E]'
									: 'text-[#F23030]'}">
								{stockAmt > 0 ? 'In stock' : 'Not available'}
							</p>
						</div>
					{/if}

					{#if price !== undefined && formatPrice(price) !== priceRange}
						<div transition:slide>
							<p class="truncate text-base font-medium leading-none">
								{formatPrice(price)}
							</p>
						</div>
					{/if}
				</div>

				<!-- Quantity selection -->
				<div class="grid grid-flow-col grid-cols-5 gap-1">
					<button
						use:melt={$trigger}
						on:click={(e) => e.preventDefault()}
						class="col-span-2 flex h-9 w-full items-center justify-between rounded-2xl border border-input bg-transparent px-3 py-2 text-sm shadow-sm
                  ring-offset-background placeholder:text-muted-foreground
                  focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50
                  aria-expanded:pointer-events-none aria-expanded:focus:ring-0">
						{`Qty: ${$selectedLabel}`}
						<CaretSort class="h-4 w-4 opacity-50" />
					</button>

					{#if $open}
						<div
							use:melt={$menu}
							in:flyAndScale
							out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
							class="relative z-50 min-w-[8rem] overflow-hidden rounded-2xl border bg-popover text-popover-foreground shadow-md focus:outline-none">
							<div class="w-full p-1" use:melt={$group('Quantity')}>
								<div class="px-2 py-1.5 text-sm font-semibold" use:melt={$groupLabel('Quantity')}>
									Select quantity
								</div>

								{#each quantityRange as qty}
									<div
										use:melt={$selectOption({
											value: qty,
											label: qty.toString()
										})}
										class="relative flex w-full cursor-default select-none items-center rounded-xl py-1.5 pl-2 pr-8 text-sm outline-none data-[disabled]:pointer-events-none data-[highlighted]:bg-accent data-[highlighted]:text-accent-foreground data-[disabled]:opacity-50">
										<div class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
											{#if $isSelected(qty)}
												<Check class="h-4 w-4" />
											{/if}
										</div>
										{qty}
									</div>
								{/each}
							</div>
						</div>
					{/if}

					<!-- Add to Bag Btn -->
					<Button
						class="col-span-3 w-full rounded-2xl"
						type="submit"
						disabled={disableBtn || $submitting}>
						{#if $delayed}
							<Loader2 size={20} strokeWidth={2.75} class="mr-3 animate-spin" />
						{:else}
							<ShoppingBag size={20} strokeWidth={2.25} class="mr-3" />
						{/if}
						<span class="text-sm font-semibold">{$delayed ? 'Adding...' : 'Add to bag'}</span>
					</Button>
				</div>

				{#if $message?.type === 'error'}
					<div transition:slide>
						<Alert.Root
							variant="destructive"
							class="mx-auto w-fit bg-destructive text-destructive-foreground">
							<Alert.Description class="flex items-center text-xs">
								<AlertCircle class="mr-2 h-4 w-4" />
								{$message.text}
							</Alert.Description>
						</Alert.Root>
					</div>
				{/if}
			</div>
		</form>

		<!-- About product -->
		<div class="flex flex-col items-center gap-3 py-2">
			<h3 class="text-base font-medium leading-none tracking-tight">About this item</h3>

			<Card.Root class="shado w-full px-4 pb-8 pt-4">
				<Accordion.Root class="w-full sm:max-w-[70%]">
					<Accordion.Item value="item-1">
						<Accordion.Trigger class="text-base font-medium">Details</Accordion.Trigger>
						<Accordion.Content>
							<h4 class="text-base font-semibold tracking-tight">Description</h4>
							<p class="leading-5 [&:not(:first-child)]:mt-2">
								{product.description ? product.description : 'No description given.'}
							</p>
						</Accordion.Content>
					</Accordion.Item>

					<Accordion.Item value="item-2">
						<Accordion.Trigger class="text-base font-medium">Specifications</Accordion.Trigger>
						<Accordion.Content>
							{#if product.metadata && Object.entries(product.metadata).length}
								<div class="grid gap-2">
									{#each Object.entries(product.metadata) as [key, value], i}
										<!-- prettier-ignore -->
										<p><span class="font-semibold">{key}</span>: {value}</p>
										{#if i !== Object.entries(product.metadata).length - 1}
											<Separator />
										{/if}
									{/each}
								</div>
							{:else}
								<p class="leading-5 [&:not(:first-child)]:mt-2">No specifications listed.</p>
							{/if}
						</Accordion.Content>
					</Accordion.Item>

					<Accordion.Item value="item-3">
						<Accordion.Trigger class="text-base font-medium">Shipping & Returns</Accordion.Trigger>
						<Accordion.Content>
							<p class="leading-5 [&:not(:first-child)]:mt-2">
								Yes. It's animated by default, but you can disable it if you prefer.
							</p>
						</Accordion.Content>
					</Accordion.Item>
				</Accordion.Root>
			</Card.Root>

			<Sheet.Root bind:open={addedToCartOpen}>
				<Sheet.Content side="right" class="overflow-y-scroll">
					<Sheet.Header>
						<Sheet.Title class="text-left text-2xl font-extrabold tracking-tight">
							My Bag
						</Sheet.Title>
					</Sheet.Header>

					{#if cartItem}
						<div class="flex items-center pt-2 text-sm">
							<CheckCircle2 size={20} class="mr-3 text-green-500" />
							Item added to your bag
						</div>

						<div class="grid gap-8 py-8">
							<div class="grid grid-flow-col grid-cols-5 gap-3">
								<div class="col-span-2">
									{#if cartItem.thumbnail || cartItem.variant.thumbnail}
										<AspectRatio ratio={3 / 4}>
											<img
												class="h-full w-full rounded-lg object-cover"
												src={cartItem.variant.thumbnail ?? cartItem.thumbnail}
												alt="" />
										</AspectRatio>
									{:else}
										<Image strokeWidth={1} class="h-full w-full" />
									{/if}
								</div>

								<div class="col-span-3 flex flex-col items-start justify-between text-left">
									<div class="grid gap-1.5">
										<p class="line-clamp-3 w-fit text-sm font-medium">
											{cartItem.title}
										</p>

										{#if cartItem.variant.product?.variant_type === VariantType.MULTI}
											<div class="flex flex-col text-xs font-medium text-muted-foreground">
												<div>
													<span>Option:</span>
													<span class="text-foreground">{cartItem.variant.title}</span>
												</div>
											</div>
										{/if}
									</div>

									<div class="text-xs font-medium text-muted-foreground">
										<span>Quantity:</span>
										<span class="text-lg font-bold text-foreground">{cartItem.quantity}</span>
									</div>
								</div>
							</div>

							<div class="grid gap-3 font-semibold">
								<Button
									on:click={() => (addedToCartOpen = false)}
									variant="secondary"
									class="rounded-2xl">
									Continue shopping
								</Button>

								<div class="relative">
									<div class="absolute inset-0 flex items-center">
										<span class="w-full border-t" />
									</div>
									<div class="relative flex justify-center text-xs uppercase">
										<span class="bg-background px-2 text-muted-foreground">Or</span>
									</div>
								</div>

								<Button
									on:click={() => (addedToCartOpen = false)}
									variant="outline"
									href="/cart"
									class="rounded-2xl">
									View items in bag
								</Button>
							</div>
						</div>
					{/if}
				</Sheet.Content>
			</Sheet.Root>
		</div>
	</div>
</main>
