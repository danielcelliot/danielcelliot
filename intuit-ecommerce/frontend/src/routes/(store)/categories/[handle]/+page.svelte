<script lang="ts">
	import {
		getProductVariantPricing,
		getProductConditionStore,
		formatPricing,
		DEFAULT_PAGE_LIMIT
	} from '$lib/client/shop';
	import type { PageServerData } from './$types';
	import * as Card from '$lib/components/ui/card';
	import { ChevronLeft, ChevronRight, Image } from 'lucide-svelte';
	import type { Product, ProductVariant } from '$lib/types/medusa';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { getUniqueImages } from '$lib/client/shop';
	import { Button } from '$lib/components/ui/button';

	export let data: PageServerData;

	let products: Product[] | null = null;

	let count = 0;
	let limit = DEFAULT_PAGE_LIMIT;
	let offset = 0;
	let page = 0;
	let totalPages = 0;

	$: if (data.productsData) {
		(products = data.productsData.products),
			(count = data.productsData.count),
			(limit = data.productsData.limit),
			(offset = data.productsData.offset),
			(page = offset + limit / limit),
			(totalPages = Math.ceil(count / limit));
	}

	let currencyCode: string = 'usd';

	function getProductQuantity(variants: ProductVariant[]) {
		if (variants.length)
			return variants.map((v) => v.inventory_quantity).reduce((acc, curr) => acc + curr);
		return 0;
	}

	// $: console.log(data.productsData);
	// $: console.log('Total pages:', totalPages);
	// $: console.log('Current page:', page);
</script>

<main class="container mx-auto px-2 min-[380px]:px-4">
	<div class="grid gap-4 py-4">
		{#if products && count}
			<ul class="grid gap-2">
				{#each products as { thumbnail, handle, title, condition, variants, options, id }}
					<li>
						<Card.Root class="group overflow-clip">
							<div class="grid grid-flow-col grid-cols-5 gap-2">
								<div class="col-span-2">
									<a href="/products/{handle}">
										{#key id}
											{#if thumbnail}
												<AspectRatio ratio={3 / 4}>
													<img class="h-full w-full object-cover" src={thumbnail} alt="" />
												</AspectRatio>
											{:else}
												<Image strokeWidth={1} class="h-full w-full" />
											{/if}
										{/key}
									</a>
								</div>

								<div class="col-span-3 flex flex-col justify-between py-2 pr-2">
									<div class="space-y-0.5">
										<a
											href="/products/{handle}"
											class="line-clamp-3 text-sm font-medium text-foreground hover:underline hover:underline-offset-4">
											{title}
										</a>

										<p class="text-xs text-muted-foreground">
											{getProductConditionStore(condition)}
										</p>
									</div>

									{#if variants}
										<div class="grid gap-2">
											<div class="flex items-center">
												{#if getProductQuantity(variants) > 0}
													<span class="mr-1.5 h-1.5 w-1.5 rounded-full bg-[#22C55E]" />
													<p class="text-xs font-normal leading-none text-[#22C55E]">In stock</p>
												{:else}
													<span class="mr-1.5 h-1.5 w-1.5 rounded-full bg-[#F23030]" />
													<p class="text-xs font-normal leading-none text-[#F23030]">
														Currently unavailable
													</p>
												{/if}
											</div>

											<p class="truncate text-base font-medium leading-none">
												{formatPricing(
													getProductVariantPricing(
														variants.flatMap((v) => v.prices ?? []),
														currencyCode
													)
												)}
											</p>
										</div>
									{/if}

									{#if variants && variants.length > 1 && options && options.length}
										<div class="grid gap-1">
											<p class="text-xs leading-none text-muted-foreground">
												Multiple options available
											</p>

											{#key id}
												<div
													class="no-scrollbar no-scrollbar::-webkit-scrollbar grid grid-flow-col place-content-start gap-4 overflow-x-scroll">
													{#each getUniqueImages(variants.map((v) => v.thumbnail)) as image}
														<div class="w-[30px]">
															<AspectRatio ratio={3 / 4}>
																<img
																	class="h-full w-full rounded object-cover"
																	src={image}
																	alt="" />
															</AspectRatio>
														</div>
													{/each}
												</div>
											{/key}
										</div>
									{/if}
								</div>
							</div>
						</Card.Root>
					</li>
				{/each}
			</ul>

			<div class="flex justify-center gap-2">
				{#if offset > 0}
					<Button
						href="?limit={limit}&offset={offset - limit}"
						variant="outline"
						class="group w-28 rounded-2xl font-semibold">
						<ChevronLeft
							size={16}
							strokeWidth={2.75}
							class="mr-2 transition group-hover:-translate-x-1" />
						Back
					</Button>
				{/if}

				{#if page < totalPages}
					<Button
						href="?limit={limit}&offset={offset + limit}"
						variant="outline"
						class="group w-28 rounded-2xl font-semibold">
						Next
						<ChevronRight
							size={16}
							strokeWidth={2.75}
							class="ml-2 transition group-hover:translate-x-1" />
					</Button>
				{/if}
			</div>
		{:else}
			<div class="flex justify-center">
				<p class="text-sm">No products yet. Check back soon!</p>
			</div>
		{/if}
	</div>
</main>
