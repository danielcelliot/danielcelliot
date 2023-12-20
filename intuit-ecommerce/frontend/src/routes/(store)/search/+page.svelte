<script lang="ts">
	import type { PageData } from './$types';
	import * as Card from '$lib/components/ui/card';
	import { Image } from 'lucide-svelte';
	import type { SearchAttributes } from '$lib/types/shop';
	import type { Hits } from 'meilisearch';
	import {
		formatPrice,
		formatPricing,
		getProductConditionStore,
		getProductVariantPricing,
		isPricingVariable
	} from '$lib/client/shop';
	import { Button } from '$lib/components/ui/button';
	import { ChevronLeft, ChevronRight } from 'radix-icons-svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';
	import { getUniqueImages } from '$lib/client/shop';

	type Variant = {
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
	};

	export let data: PageData;

	let currencyCode = PUBLIC_STORE_CURRENCY_CODE;
	let hits: Hits<SearchAttributes> | undefined;
	let totalHits: number | undefined;
	let totalPages: number | undefined;
	let page: number | undefined;
	let hitsPerPage: number | undefined;
	let query: string;

	function getProductQuantity(variants: Variant[]) {
		return variants.map((v) => v.inventory_quantity).reduce((acc, curr) => acc + curr);
	}

	$: if (data.results) {
		hits = data.results.hits as Hits<SearchAttributes>;
		totalHits = data.results.totalHits;
		totalPages = data.results.totalPages;
		page = data.results.page;
		hitsPerPage = data.results.hitsPerPage;
		query = data.results.query;
	}

	// $: console.log(data.results);
</script>

<main class="container mx-auto px-2 min-[380px]:px-4">
	<div class="grid gap-4 py-4">
		<div class="flex justify-center">
			{#if totalHits && totalHits > 0}
				<p class="text-sm">
					{totalHits}
					{totalHits === 1 ? 'result' : 'results'} for
					<span class="font-semibold">"{query}"</span>
				</p>
			{/if}
		</div>

		{#if hits && hits.length}
			<div class="grid grid-cols-2 gap-2">
				{#each hits as { handle, thumbnail, title, condition, variants, options }}
					<Card.Root class="h-full overflow-clip group-hover:bg-muted">
						<div class="flex h-full flex-col">
							<a href="/products/{handle}">
								{#key handle}
									{#if thumbnail}
										<AspectRatio ratio={3 / 4}>
											<img class="h-full w-full object-cover" src={thumbnail} alt="" />
										</AspectRatio>
									{:else}
										<Image strokeWidth={1} class="h-full w-full" />
									{/if}
								{/key}
							</a>

							<div class="flex h-full flex-col gap-2 p-2">
								<div class="grid gap-0.5">
									<a
										href="/products/{handle}"
										class="line-clamp-3 w-fit text-sm font-medium text-foreground hover:underline hover:underline-offset-4">
										{title}
									</a>

									<p class="text-xs leading-none text-muted-foreground">
										{getProductConditionStore(condition)}
									</p>
								</div>

								<div class="grid gap-1">
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

									{#if isPricingVariable(getProductVariantPricing( variants.flatMap((v) => v.prices), currencyCode ))}
										<p class="text-xs leading-none">
											From
											<span class="text-base font-medium">
												{formatPrice(
													getProductVariantPricing(
														variants.flatMap((v) => v.prices),
														currencyCode
													).low
												)}
											</span>
										</p>
									{:else}
										<p class="text-base font-medium leading-none">
											{formatPricing(
												getProductVariantPricing(
													variants.flatMap((v) => v.prices),
													currencyCode
												)
											)}
										</p>
									{/if}
								</div>

								{#if variants && variants.length > 1 && options.length}
									<div class="grid gap-1">
										<p class="text-xs leading-tight text-muted-foreground">
											Multiple options available
										</p>

										{#key handle}
											<div
												class="no-scrollbar no-scrollbar::-webkit-scrollbar grid grid-flow-col place-content-start gap-4 overflow-x-scroll">
												{#each getUniqueImages(variants.map((v) => v.thumbnail)) as image}
													<div class="w-[30px]">
														<AspectRatio ratio={3 / 4}>
															<img class="h-full w-full rounded object-cover" src={image} alt="" />
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
				{/each}
			</div>
		{:else}
			<div class="flex justify-center">
				<p class="text-sm">
					No results found for <span class="font-semibold">"{query}"</span>
				</p>
			</div>
		{/if}

		<div class="flex flex-col items-center gap-2">
			{#if page === totalPages}
				<p class="text-sm">End of results</p>
			{/if}

			{#if page && totalPages !== 0}
				<p class="text-sm">Page {page} of {totalPages}</p>

				<div class="flex justify-between gap-2">
					{#if page > 1}
						<Button
							href="/search?q={query}&page={page - 1}&limit={hitsPerPage}"
							variant="outline"
							class="group w-28 rounded-2xl font-semibold">
							<ChevronLeft
								size={16}
								strokeWidth={2.75}
								class="mr-2 transition group-hover:-translate-x-1" />
							Back
						</Button>
					{/if}

					{#if page !== totalPages}
						<Button
							href="/search?q={query}&page={page + 1}&limit={hitsPerPage}"
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
			{/if}
		</div>
	</div>
</main>
