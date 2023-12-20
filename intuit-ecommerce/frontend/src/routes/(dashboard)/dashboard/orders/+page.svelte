<script lang="ts">
	import * as Tabs from '$lib/components/ui/tabs';
	import * as Card from '$lib/components/ui/card';
	import { OrderStatus, type Order } from '$lib/types/medusa.js';
	import { formatPrice, timeAgo } from '$lib/client/shop.js';

	export let data;

	let filteredOrders: Order[] | null | undefined;
	let stackLimit = 4;

	$: ({ orders } = data);
	$: filteredOrders = orders;

	function getCustomerName(order: Order) {
		return order.customer.first_name && order.customer.last_name
			? `${order.customer.first_name} ${order.customer.last_name}`
			: `${order.shipping_address.first_name} ${order.shipping_address.last_name}`;
	}
</script>

<main class="container px-2 min-[380px]:px-4">
	{#if orders && orders.length > 0}
		<div class="no-scrollbar no-scrollbar::-webkit-scrollbar flex justify-start overflow-auto py-4">
			<Tabs.Root value="all">
				<Tabs.List class="grid grid-flow-col rounded-2xl [&>*]:min-w-[98px]">
					<Tabs.Trigger class="rounded-xl" value="all" on:click={() => (filteredOrders = orders)}>
						All
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="complete"
						on:click={() =>
							(filteredOrders = orders?.filter((o) => o.status == OrderStatus.COMPLETED))}>
						Complete
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="incomplete"
						on:click={() =>
							(filteredOrders = orders?.filter((o) => o.status == OrderStatus.PENDING))}>
						Incomplete
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="canceled"
						on:click={() =>
							(filteredOrders = orders?.filter((o) => o.status == OrderStatus.CANCELED))}>
						Canceled
					</Tabs.Trigger>
				</Tabs.List>
			</Tabs.Root>
		</div>

		{#if filteredOrders}
			<ul class="space-y-2 pb-48">
				{#each filteredOrders as order}
					<li>
						<a id={order.id} href="/dashboard/orders/{order.id}">
							<Card.Root class="px-4 py-2 hover:bg-muted">
								<div class="mb-3 flex items-center justify-between">
									<div class="flex">
										<p class="mr-2 text-lg font-bold">#{order.display_id}</p>

										<span class="flex items-center text-xs font-medium capitalize">
											{#if order.status === OrderStatus.COMPLETED}
												<span class="mr-1.5 h-2 w-2 rounded-full bg-green-500" />
											{:else if order.status === OrderStatus.PENDING}
												<span class="mr-1.5 h-2 w-2 rounded-full bg-yellow-500" />
											{:else if order.status === OrderStatus.CANCELED}
												<span class="mr-1.5 h-2 w-2 rounded-full bg-red-500" />
											{:else}
												<span class="mr-1.5 h-2 w-2 rounded-full bg-blue-500" />
											{/if}
											{order.status}
										</span>
									</div>

									<p class="text-xs font-medium">{timeAgo(order.created_at)}</p>
								</div>

								<div class="flex items-baseline -space-x-4">
									{#each order.items as item, i}
										{#if i < stackLimit}
											<img
												class="w-14 rounded-sm border-2 border-background"
												src={item.thumbnail}
												alt="" />
										{/if}
									{/each}
									{#if order.items.length > stackLimit}
										<p class="pl-5 text-xs text-muted-foreground">
											+{order.items.length - stackLimit} more items
										</p>
									{/if}
								</div>

								<div class="flex items-baseline justify-between">
									<p class="text-xs font-normal">
										<span class="text-muted-foreground">Ordered by</span>
										<span class="font-medium">{getCustomerName(order)}</span>
									</p>
									<p class="text-lg font-semibold">{formatPrice(order.total)}</p>
								</div>
							</Card.Root>
						</a>
					</li>
				{/each}
			</ul>
		{/if}
	{:else}
		No orders yet...
	{/if}
</main>

<style>
	/* Hide scrollbar for Chrome, Safari and Opera */
	.no-scrollbar::-webkit-scrollbar {
		display: none;
	}

	/* Hide scrollbar for IE, Edge and Firefox */
	.no-scrollbar {
		-ms-overflow-style: none; /* IE and Edge */
		scrollbar-width: none; /* Firefox */
	}
</style>
