<script lang="ts">
	import { ProductStatus, type Product } from '$lib/types/medusa.js';
	import { Image, PlusSquare, ShoppingBag } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import * as Card from '$lib/components/ui/card';
	import * as Tabs from '$lib/components/ui/tabs';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import { getInventoryCounts } from '$lib/client/shop';

	export let data;

	let filteredProducts: Product[] | null | undefined;

	$: ({ products } = data);
	$: filteredProducts = products;
</script>

<main class="container px-2 min-[380px]:px-4">
	{#if products && products.length > 0}
		<div class="flex justify-center py-4">
			<Tabs.Root value="all" class="w-full max-w-[400px]">
				<Tabs.List class="grid grid-cols-3 rounded-2xl">
					<Tabs.Trigger
						class="rounded-xl"
						value="all"
						on:click={() => (filteredProducts = products)}>
						All
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="published"
						on:click={() =>
							(filteredProducts = products?.filter((p) => p.status == ProductStatus.PUBLISHED))}>
						Published
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="draft"
						on:click={() =>
							(filteredProducts = products?.filter((p) => p.status == ProductStatus.DRAFT))}>
						Draft
					</Tabs.Trigger>
				</Tabs.List>
			</Tabs.Root>
		</div>

		{#if filteredProducts}
			<ul class="space-y-2 pb-48">
				{#each filteredProducts as product}
					<li>
						<a id={product.id} href="/dashboard/products/{product.id}">
							<Card.Root class="hover:bg-muted">
								<div class="flex justify-between px-3 py-2">
									<div class="flex">
										<div class="mr-2 w-[40px] overflow-hidden rounded-sm">
											<AspectRatio ratio={3 / 4} class="flex items-center">
												{#if product.thumbnail}
													<img class="rounded-sm object-cover" src={product.thumbnail} alt="" />
												{:else}
													<Image strokeWidth={1} class="h-full w-full" />
												{/if}
											</AspectRatio>
										</div>

										<div class="flex flex-col justify-evenly">
											<p class="text-sm font-medium">{product.title}</p>

											<div class="flex items-center">
												{#if product.status === ProductStatus.PUBLISHED}
													<span class="mr-1.5 h-1.5 w-1.5 rounded-full bg-green-500" />
												{:else}
													<span class="mr-1.5 h-1.5 w-1.5 rounded-full bg-slate-500" />
												{/if}

												<p class="text-xs font-medium capitalize text-muted-foreground">
													{product.status}
												</p>
											</div>
										</div>
									</div>

									<div class="flex flex-col items-end justify-evenly">
										<p class="text-lg font-medium">
											{product.variants && product.variants.length > 0
												? getInventoryCounts(product.variants)
												: 0}
										</p>

										<p class="text-xs font-medium text-muted-foreground">In stock</p>
									</div>
								</div>
							</Card.Root>
						</a>
					</li>
				{/each}
			</ul>
		{/if}

		<div class="fixed bottom-24 right-4">
			<Tooltip.Root openDelay={100}>
				<Tooltip.Trigger asChild let:builder>
					<Button
						builders={[builder]}
						href="/dashboard/products/wizard"
						class="h-16 w-16 rounded-2xl shadow-lg">
						<PlusSquare size={28} strokeWidth={2.75} />
					</Button>
				</Tooltip.Trigger>
				<Tooltip.Content
					class="bg-background font-medium text-foreground shadow-md
            dark:bg-foreground dark:text-background">
					<p>Add new product</p>
				</Tooltip.Content>
			</Tooltip.Root>
		</div>
	{:else}
		<div
			class="mx-auto flex h-[450px] max-w-[420px] flex-col items-center justify-center text-center">
			<ShoppingBag size={36} />

			<h3 class="mt-4 text-lg font-semibold">No products added</h3>

			<p class="mb-4 mt-2 text-sm text-muted-foreground">
				You have not added any products. Add one below.
			</p>

			<Button size="sm" class="w-32 rounded-2xl font-semibold" href="/dashboard/products/wizard">
				Add Product
			</Button>
		</div>
	{/if}
</main>
