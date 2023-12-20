<script lang="ts">
	import { formatPrice } from '$lib/client/shop';
	import type { PageData } from './$types';
	import * as Card from '$lib/components/ui/card';
	import Button from '$lib/components/ui/button/button.svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { ChevronLeft, Image } from 'lucide-svelte';

	export let data: PageData;
	$: ({ order } = data);
</script>

<main class="container mx-auto px-2 min-[380px]:px-4">
	<div class="grid gap-3 py-4">
		{#if data.customerData.customer}
			<div class="flex h-8 items-center">
				<a
					href="/account/orders"
					class="group flex w-fit items-center text-base font-normal tracking-tight">
					<ChevronLeft size={16} strokeWidth={2} class="mr-2" />
					<span class="underline underline-offset-4 group-hover:no-underline">Back to Orders</span>
				</a>
			</div>
		{/if}

		<!-- Order details -->
		<Card.Root class="w-full rounded-xl">
			<Card.Header>
				<Card.Title class="text-lg leading-tight">Order details</Card.Title>
			</Card.Header>

			<Card.Content class="text-sm">
				<div class="grid grid-flow-col grid-cols-2">
					<p class="text-muted-foreground">Order date</p>
					<p>
						{new Intl.DateTimeFormat('en-US', {
							dateStyle: 'medium'
						}).format(new Date(order.created_at))}
					</p>
				</div>

				<div class="grid grid-flow-col grid-cols-2">
					<p class="text-muted-foreground">Order #</p>
					<p>{order.display_id}</p>
				</div>

				<div class="grid grid-flow-col grid-cols-2">
					<p class="text-muted-foreground">Order total</p>
					<p>{formatPrice(order.total)}</p>
				</div>
			</Card.Content>

			<Card.Footer>
				<Button
					variant="secondary"
					class="h-8 w-full rounded-2xl"
					href="/orders/{order.id}/invoice">
					View invoice
				</Button>
			</Card.Footer>
		</Card.Root>

		<!-- Items -->
		<Card.Root class="w-full rounded-xl">
			<Card.Header>
				<Card.Title class="text-lg leading-tight">Items</Card.Title>
			</Card.Header>

			<Card.Content>
				<div class="grid gap-4">
					{#each order.items as { quantity, unit_price, thumbnail, variant, title }}
						<div class="grid grid-flow-col grid-cols-5 gap-2 text-xs">
							<div class="col-span-1">
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

							<div class="col-span-3 flex flex-col justify-between">
								<p class="line-clamp-3 text-sm font-bold">{title}</p>
								<p class="text-muted-foreground">{variant.title}</p>
								<p class="text-muted-foreground">Qty: {quantity}</p>
								<p class="text-muted-foreground">Sold by ABC International</p>
							</div>

							<div class="col-span-1 flex justify-end">
								<p>{formatPrice(unit_price)}</p>
							</div>
						</div>
					{/each}
				</div>
			</Card.Content>
		</Card.Root>

		<!-- Payment information -->
		<Card.Root class="w-full rounded-xl">
			<Card.Header>
				<Card.Title class="text-lg leading-tight">Payment information</Card.Title>
			</Card.Header>

			<Card.Content>
				<div class="grid text-sm">
					<p class="font-bold text-muted-foreground">Payment method</p>
					<p>
						{order.payments[0].provider_id.charAt(0).toUpperCase() +
							order.payments[0].provider_id.slice(1)}
					</p>
				</div>
			</Card.Content>
		</Card.Root>

		<!-- Shipping address -->
		<Card.Root class="w-full rounded-xl">
			<Card.Header>
				<Card.Title class="text-lg leading-tight">Shipping address</Card.Title>
			</Card.Header>

			<Card.Content>
				<div class="grid text-sm">
					<p>{order.shipping_address.first_name} {order.shipping_address.last_name}</p>
					<p>{order.shipping_address.address_1}</p>
					<p>{order.shipping_address.address_2}</p>
					<p>{order.shipping_address.city}</p>
					<p>{order.shipping_address.phone}</p>
				</div>
			</Card.Content>
		</Card.Root>

		<!-- Order summary -->
		<Card.Root class="w-full rounded-xl">
			<Card.Header>
				<Card.Title class="text-lg leading-tight">Order summary</Card.Title>
			</Card.Header>

			<Card.Content class="text-sm">
				<div class="flex justify-between">
					<p class="text-muted-foreground">Items</p>
					<p>{formatPrice(order.subtotal)}</p>
				</div>

				<div class="flex justify-between">
					<p class="text-muted-foreground">Shipping</p>
					<p>{formatPrice(order.shipping_methods[0].price)}</p>
				</div>

				<div class="flex justify-between text-base font-bold">
					<p class="text-muted-foreground">Order total</p>
					<p>{formatPrice(order.total)}</p>
				</div>
			</Card.Content>
		</Card.Root>
	</div>
</main>
