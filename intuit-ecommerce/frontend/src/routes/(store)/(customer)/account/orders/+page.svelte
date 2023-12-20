<script lang="ts">
	import type { PageData } from './$types';
	import { formatPrice } from '$lib/client/shop';
	import * as Card from '$lib/components/ui/card';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Image } from 'lucide-svelte';
	import { OrderStatus } from '$lib/types/medusa';

	export let data: PageData;
	$: ({ orders } = data);
</script>

<main class="container mx-auto px-2 min-[380px]:px-4">
	<div class="grid gap-3 py-4">
		<div class="flex h-8 items-center">
			<h1 class="text-base font-normal tracking-tight text-muted-foreground">My Orders</h1>
		</div>

		{#if orders.length > 0}
			{#each orders as order}
				<a href="/orders/{order.id}" class="group font-medium">
					<Card.Root class="group-hover:bg-muted">
						<Card.Content class="px-4 py-3 text-sm">
							<div class="grid gap-2">
								<div class="flex justify-between">
									<p class="font-semibold underline underline-offset-4 group-hover:no-underline">
										Order # {order.display_id}
									</p>
									<p>
										{new Intl.DateTimeFormat('en-US', {
											dateStyle: 'short'
										}).format(new Date(order.created_at))}
									</p>
								</div>

								<div class="flex items-center">
									{#if order.status === OrderStatus.COMPLETED}
										<span class="mr-2 h-2 w-2 rounded-full bg-green-500" />
									{:else if order.status === OrderStatus.PENDING}
										<span class="mr-2 h-2 w-2 rounded-full bg-primary" />
									{:else if order.status === OrderStatus.CANCELED}
										<span class="mr-2 h-2 w-2 rounded-full bg-destructive" />
									{/if}

									{#if order.status === OrderStatus.PENDING}
										Processing
									{:else}
										{order.status.charAt(0).toUpperCase() + order.status.slice(1)}
									{/if}
								</div>

								{#if order.items.length === 1}
									<div class="flex items-center gap-2">
										<div class="w-[30px]">
											{#if order.items[0].thumbnail || order.items[0].variant.thumbnail}
												<AspectRatio ratio={3 / 4}>
													<img
														class="h-full w-full rounded-md object-cover"
														src={order.items[0].variant.thumbnail ?? order.items[0].thumbnail}
														alt="" />
												</AspectRatio>
											{:else}
												<Image strokeWidth={1} class="h-full w-full" />
											{/if}
										</div>
										<p class="truncate">{order.items[0].title}</p>
									</div>
								{:else}
									<div class="flex flex-wrap gap-1">
										{#each order.items as { thumbnail, variant }}
											<div class="w-[50px]">
												{#if thumbnail || variant.thumbnail}
													<AspectRatio ratio={3 / 4}>
														<img
															class="h-full w-full rounded-md object-cover"
															src={variant.thumbnail ?? thumbnail}
															alt="" />
													</AspectRatio>
												{:else}
													<Image strokeWidth={1} class="h-full w-full" />
												{/if}
											</div>
										{/each}
									</div>
								{/if}

								<div class="flex justify-end">
									<p>
										Order total: <span class="font-bold">{formatPrice(order.total)}</span>
									</p>
								</div>
							</div>
						</Card.Content>
					</Card.Root>
				</a>
			{/each}
		{:else}
			No orders yet.
		{/if}
	</div>
</main>
