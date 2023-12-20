<script lang="ts">
	import { FulfillmentStatus, OrderStatus } from '$lib/types/medusa.js';
	import { formatPrice, timeAgo } from '$lib/client/shop.js';
	import { superForm } from 'sveltekit-superforms/client';
	import {
		ArrowLeft,
		Loader2,
		Mail,
		MoreHorizontal,
		Package,
		PackageCheck,
		PackageX,
		Phone,
		Truck
	} from 'lucide-svelte';
	import * as Card from '$lib/components/ui/card';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import * as Avatar from '$lib/components/ui/avatar';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import { Button } from '$lib/components/ui/button';
	import { Separator } from '$lib/components/ui/separator';
	import FulfillmentForm from '$lib/components/admin/order/FulfillmentForm.svelte';
	import ShipmentForm from '$lib/components/admin/order/ShipmentForm.svelte';
	import { slide } from 'svelte/transition';
	import { addToast } from '$lib/components/ui/toast/toaster.svelte';

	export let data;

	let disabled = false;

	let fulfillmentId: string;
	let openFulfillmentModal = false;
	let openCancelFulfillmentModal = false;

	let openShipmentModal = false;

	const avatarColors = [
		'bg-blue-600',
		'bg-purple-600',
		'bg-green-600',
		'bg-orange-600',
		'bg-rose-600',
		'bg-pink-600',
		'bg-slate-600'
	];
	const colorVal = Math.floor(Math.random() * avatarColors.length);

	const { enhance, delayed } = superForm(data.cancelFulfillmentForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') openCancelFulfillmentModal = false;
			disabled = false;
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) {
				openCancelFulfillmentModal = false;
				disabled = false;
			}
		},
		onError({ result }) {
			openCancelFulfillmentModal = false;
			disabled = false;
			addToast({
				data: {
					title: 'Error',
					description: result.error.message,
					color: 'bg-red-500'
				}
			});
		}
	});

	$: ({ order } = data);

	$: shipments =
		order?.fulfillments
			?.map((fulfillments) => {
				if (!fulfillments.canceled_at) return fulfillments;
			})
			.filter((s): s is Exclude<typeof s, undefined> => s !== undefined)
			.reverse() ?? [];

	$: fulfillmentItems =
		order?.items
			.map((item) => {
				if (item.quantity !== item.fulfilled_quantity)
					return {
						id: item.id,
						quantity: item.quantity - (item.fulfilled_quantity ?? 0),
						max_quantity: item.quantity - (item.fulfilled_quantity ?? 0),
						thumbnail: item.thumbnail ?? undefined,
						title: item.title,
						variant_title: item.variant.title
					};
			})
			.filter((item): item is Exclude<typeof item, undefined> => item !== undefined) ?? [];

	function getItemDetails(
		items: {
			fulfillment_id: string;
			item_id: string;
			quantity: number;
		}[]
	) {
		return items
			.map((item) => {
				const found = order?.items.findIndex((i) => i.id === item.item_id);
				if (found !== undefined && found > -1) {
					return {
						fulfillment_id: item.fulfillment_id,
						item_id: item.item_id,
						quantity: item.quantity,
						thumbnail: order?.items[found].thumbnail,
						title: order?.items[found].title,
						variant_title: order?.items[found].variant.title
					};
				}
			})
			.filter((item): item is Exclude<typeof item, undefined> => item !== undefined);
	}
</script>

<main class="container px-2 min-[380px]:px-4">
	<a
		href="/dashboard/orders{order?.id ? `#${order.id}` : ''}"
		class="group my-4 flex w-fit items-center text-foreground">
		<ArrowLeft size={16} class="mr-2" />
		<span class="text-sm font-medium underline-offset-4 group-hover:underline">Back to Orders</span>
	</a>

	{#if order}
		<Dialog.Root bind:open={openFulfillmentModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Items to fulfill</Dialog.Title>
					<!-- <Dialog.Description class="text-left">
          Make changes to your product options. Click save when you're done.
        </Dialog.Description> -->
				</Dialog.Header>
				<FulfillmentForm
					href="?/fulfill"
					fulfillmentForm={data.fulfillForm}
					fulfillmentData={fulfillmentItems}
					orderId={order.id}
					on:view={(event) => (openFulfillmentModal = event.detail.open)} />
			</Dialog.Content>
		</Dialog.Root>

		<Dialog.Root bind:open={openShipmentModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Mark Fulfillment as Shipped</Dialog.Title>
				</Dialog.Header>
				<ShipmentForm
					href="?/ship"
					shipmentForm={data.shipmentForm}
					orderId={order.id}
					{fulfillmentId}
					on:view={(event) => (openShipmentModal = event.detail.open)} />
			</Dialog.Content>
		</Dialog.Root>

		<AlertDialog.Root bind:open={openCancelFulfillmentModal} closeOnOutsideClick={true}>
			<AlertDialog.Content class="rounded-xl">
				<AlertDialog.Header>
					<AlertDialog.Title>Are you sure?</AlertDialog.Title>
					<AlertDialog.Description>This action cannot be undone.</AlertDialog.Description>
				</AlertDialog.Header>
				<AlertDialog.Footer>
					<AlertDialog.Cancel class="rounded-2xl">Cancel</AlertDialog.Cancel>
					<form action="?/cancelFulfill" method="post" use:enhance>
						<input type="hidden" name="order_id" value={order.id} required />
						<input type="hidden" name="fulfillment_id" value={fulfillmentId} required />

						<Button {disabled} variant="destructive" type="submit" class="w-full rounded-2xl">
							{#if $delayed}
								<div transition:slide={{ axis: 'x' }}>
									<Loader2 size={16} class="mr-4 animate-spin" />
								</div>
							{/if}
							<span>{$delayed ? 'Saving changes...' : 'Continue'}</span>
						</Button>
					</form>
				</AlertDialog.Footer>
			</AlertDialog.Content>
		</AlertDialog.Root>

		<div class="space-y-2 pb-20">
			<!-- Order Overview -->
			<Card.Root class="px-3 py-4 shadow-none">
				<div class="mb-4 flex items-center justify-between">
					<p class="font-bold">Order #{order.display_id}</p>

					<span class="flex items-center text-xs capitalize">
						{#if order.status === OrderStatus.COMPLETED}
							<span class="mr-1.5 h-2 w-2 rounded-full bg-green-500" />
						{:else if order.status === OrderStatus.CANCELED}
							<span class="mr-1.5 h-2 w-2 rounded-full bg-red-500" />
						{:else}
							<span class="mr-1.5 h-2 w-2 rounded-full bg-gray-500" />
						{/if}
						{order.status}
					</span>
				</div>

				<p class="text-xs">
					{new Intl.DateTimeFormat('en-US', {
						dateStyle: 'long',
						timeStyle: 'short'
					}).format(new Date(order.created_at))}
				</p>
			</Card.Root>

			<!-- Customer Details -->
			<Card.Root class="px-3 py-4 shadow-none">
				<div class="flex">
					{#if order.customer.first_name}
						<Avatar.Root class="mr-4">
							<Avatar.Image src="https://i.pravatar.cc/300" alt="" />
							<Avatar.Fallback class="text-background {avatarColors[colorVal]}">
								{order.customer.first_name.charAt(0).toUpperCase() ?? ''}{order.customer.last_name
									? order.customer.last_name.charAt(0).toUpperCase()
									: ''}
							</Avatar.Fallback>
						</Avatar.Root>
					{/if}

					<div class="flex flex-col">
						<p class="font-bold">
							{order.customer.first_name ?? ''}
							{order.customer.last_name ?? ''}
						</p>

						<p class="mb-4 text-xs">Customer</p>
					</div>
				</div>

				<p class="mb-2 text-xs">
					Contact {order.customer.first_name ?? 'customer'} via:
				</p>

				{#if order.customer.phone}
					<Button
						href="tel:{order.customer.phone}"
						size="sm"
						variant="outline"
						class="mr-2 rounded-2xl font-semibold">
						<Phone size={16} strokeWidth={2.75} class="mr-2" />
						Phone
					</Button>
				{/if}

				<Button
					href="mailto:{order.customer.email}"
					size="sm"
					variant="outline"
					class="mr-2 rounded-2xl font-semibold">
					<Mail size={16} strokeWidth={2.75} class="mr-2" />
					Email
				</Button>
			</Card.Root>

			<!-- Delivery Details -->
			<Card.Root class="px-3 py-4 shadow-none">
				<p class="mb-4 font-bold">Deliver to:</p>

				<ul class="mb-2">
					<li>
						<p class="text-xs">
							{order.shipping_address.first_name}
							{order.shipping_address.last_name}
						</p>
					</li>
					<li><p class="text-xs">{order.shipping_address.address_2 ?? ''}</p></li>
					<li><p class="text-xs">{order.shipping_address.address_1}</p></li>
					<li><p class="text-xs">{order.shipping_address.city}</p></li>
				</ul>

				{#if order.shipping_address.phone}
					<Button
						href="tel:{order.shipping_address.phone}"
						size="sm"
						variant="outline"
						class="mb-4 rounded-2xl font-semibold">
						<Phone size={16} strokeWidth={2.75} class="mr-2" />
						Call recipient
					</Button>
				{/if}

				<p class="text-xs">
					Delivery Method: <span class="font-bold">
						{order.shipping_methods[0].shipping_option.name}
					</span>
				</p>
			</Card.Root>

			<!-- Shipment Details -->
			{#if shipments.length}
				<Card.Root class="px-3 py-4 shadow-none">
					<p class="mb-4 font-bold">Shipments</p>

					<ul>
						{#each shipments as shipment}
							<li class="flex">
								{#if shipment.shipped_at}
									<div class="mr-2 flex flex-col justify-start">
										<Truck size={18} />
									</div>

									<div class="flex w-full flex-col">
										<div class="flex items-baseline justify-between">
											<p class="mb-1 text-xs font-bold">Items Shipped</p>
											<p class="text-xs text-muted-foreground">{timeAgo(shipment.shipped_at)}</p>
										</div>

										{#if shipment.tracking_links.length > 0}
											<p class="text-xs">
												{#if shipment.tracking_links[0].tracking_number.length > 0}
													Tracking: <span>{shipment.tracking_links[0].tracking_number}</span>
												{:else}
													Tracking: N/A
												{/if}
											</p>
										{/if}

										<ul>
											{#each getItemDetails(shipment.items) as item}
												<li class="mt-3 flex">
													<img src={item.thumbnail} alt="" width="40px" class="mr-2 rounded-sm" />

													<div class="flex w-full flex-col justify-evenly">
														<div class="flex justify-between">
															<p class="text-xs font-medium">{item.title}</p>
															<p class="text-xs">x {item.quantity}</p>
														</div>

														<p class="text-xs">{item.variant_title}</p>
													</div>
												</li>
											{/each}
										</ul>
									</div>
								{:else}
									<div class="flex w-full flex-col">
										<div class="flex justify-between">
											<span class="flex items-center text-xs">
												<span class="mr-1.5 h-2 w-2 rounded-full bg-yellow-500" />
												Ready to ship
											</span>

											<DropdownMenu.Root>
												<DropdownMenu.Trigger asChild let:builder>
													<Button
														builders={[builder]}
														variant="ghost"
														size="sm"
														class="rounded-full">
														<MoreHorizontal size={20} />
													</Button>
												</DropdownMenu.Trigger>

												<DropdownMenu.Content class="rounded-xl">
													<DropdownMenu.Item
														class="cursor-pointer rounded-lg"
														on:click={() => {
															fulfillmentId = shipment.id;
															openShipmentModal = true;
														}}>
														<PackageCheck class="mr-2 h-4 w-4" />
														<span class="text-medium">Mark order as shipped</span>
													</DropdownMenu.Item>

													<DropdownMenu.Item
														class="cursor-pointer rounded-lg"
														on:click={() => {
															fulfillmentId = shipment.id;
															openCancelFulfillmentModal = true;
														}}>
														<PackageX class="mr-2 h-4 w-4" />
														<span class="text-medium">Cancel shipment</span>
													</DropdownMenu.Item>
												</DropdownMenu.Content>
											</DropdownMenu.Root>
										</div>

										<ul>
											{#each getItemDetails(shipment.items) as item}
												<li class="mt-3 flex">
													<img src={item.thumbnail} alt="" width="40px" class="mr-2 rounded-sm" />

													<div class="flex w-full flex-col justify-evenly">
														<div class="flex justify-between">
															<p class="text-xs font-medium">{item.title}</p>
															<p class="text-xs">x {item.quantity}</p>
														</div>

														<p class="text-xs">{item.variant_title}</p>
													</div>
												</li>
											{/each}
										</ul>
									</div>
								{/if}
							</li>
						{/each}
					</ul>
				</Card.Root>
			{/if}

			<!-- Fulfillment Details -->
			{#if fulfillmentItems.length && order.status != OrderStatus.CANCELED}
				<Card.Root class="px-3 py-4 shadow-none">
					<div class="flex justify-between">
						<p class="font-bold">Fulfillments</p>

						<span class="flex items-center text-xs">
							{#if fulfillmentItems.length == 0}
								<span class="mr-1.5 h-2 w-2 rounded-full bg-green-500" />
								<span>Fulfilled</span>
							{:else if order.fulfillment_status == FulfillmentStatus.PARTIALLY_FULFILLED || order.fulfillment_status == FulfillmentStatus.PARTIALLY_SHIPPED}
								<span class="mr-1.5 h-2 w-2 rounded-full bg-yellow-500" />
								<span>Partially fulfilled</span>
							{:else if !order?.items.some((item) => item.fulfilled_quantity ?? 0 > 0)}
								<span class="mr-1.5 h-2 w-2 rounded-full bg-orange-500" />
								<span>Awaiting fulfillment</span>
							{/if}
						</span>
					</div>

					{#if fulfillmentItems.length}
						<Button
							size="sm"
							class="mt-4 w-full rounded-2xl font-semibold"
							on:click={() => (openFulfillmentModal = true)}>
							Create Fulfillment
						</Button>
					{/if}

					{#if order.fulfillments && order.fulfillments.length}
						<ul>
							{#each order.fulfillments.reverse() as fulfillment}
								{#if !fulfillment.canceled_at}
									<li class="mt-6 flex">
										<div class="mr-2 flex flex-col justify-start">
											<Package size={18} />
										</div>

										<div class="flex w-full flex-col">
											<p class="mb-1 text-xs font-bold">Items Fulfilled</p>
											<p class="text-xs">{timeAgo(fulfillment.created_at)}</p>

											<ul>
												{#each getItemDetails(fulfillment.items) as item}
													<li class="mt-3 flex">
														<img src={item.thumbnail} alt="" width="40px" class="mr-2 rounded-sm" />

														<div class="flex w-full flex-col justify-evenly">
															<div class="flex justify-between">
																<p class="text-xs font-medium">{item.title}</p>
																<p class="text-xs">x {item.quantity}</p>
															</div>

															<p class="text-xs">{item.variant_title}</p>
														</div>
													</li>
												{/each}
											</ul>
										</div>
									</li>
								{/if}
							{/each}
						</ul>
					{/if}
				</Card.Root>
			{/if}

			<!-- Order Summary -->
			<Card.Root class="px-3 py-4 shadow-none">
				<p class="mb-6 font-bold">Summary</p>

				<ul class="space-y-4">
					{#each order.items as item}
						<li>
							<div class="flex">
								<img src={item.thumbnail} alt="" width="40px" class="mr-2 rounded-sm" />

								<div class="flex w-full flex-col justify-around">
									<div class="grid grid-cols-6 gap-x-1">
										<p class="col-span-3 text-xs font-medium">{item.title}</p>
										<p class="col-span-2 justify-self-end text-xs text-muted-foreground">
											{formatPrice(item.unit_price)}
										</p>
										<p class="justify-self-end text-xs text-muted-foreground">x {item.quantity}</p>
									</div>

									<div class="flex justify-between">
										<p class="text-xs">{item.description}</p>
										<p class="text-xs font-normal">{formatPrice(item.total)}</p>
									</div>
								</div>
							</div>
						</li>
					{/each}
				</ul>

				<Separator class="my-6" />

				<div class="mb-2 flex items-baseline justify-between">
					<p class="text-xs font-medium">Subtotal</p>
					<p class="text-xs font-medium">{formatPrice(order.subtotal)}</p>
				</div>

				<div class="flex items-baseline justify-between">
					<p class="text-xs font-medium">Shipping</p>
					<p class="text-xs font-medium">
						{order.shipping_total > 0 ? formatPrice(order.shipping_total) : '--'}
					</p>
				</div>

				<div class="mt-4 flex items-baseline justify-between">
					<p class="text-xs font-bold">Total</p>
					<p class="text-xl font-bold">{formatPrice(order.total)}</p>
				</div>
			</Card.Root>

			{#if order.status == OrderStatus.PENDING && !order?.items.some((item) => item.fulfilled_quantity ?? 0 > 0)}
				<div class="px-3 py-2">
					<p class="text-sm font-normal">
						If you wish to request a cancellation for this order, <a
							href="#"
							class="font-medium text-foreground underline underline-offset-4">
							click here
						</a>
						to contact us.
					</p>
				</div>
			{/if}
		</div>
	{:else}
		<p>Order not found.</p>
	{/if}
</main>
