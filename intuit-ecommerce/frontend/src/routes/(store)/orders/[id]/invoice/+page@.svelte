<script lang="ts">
	import { PUBLIC_STORE_NAME } from '$env/static/public';
	import { formatPrice } from '$lib/client/shop';
	import type { PageServerData } from './$types';

	export let data: PageServerData;
	$: ({ order } = data);
</script>

<div class="mx-auto h-a4 w-a4">
	<div class="logo-container">
		<a href="/" class="text-4xl font-normal leading-none tracking-widest">
			{PUBLIC_STORE_NAME.toUpperCase()}
		</a>
	</div>

	<br />

	<div class="container text-sm leading-tight">
		<h2 class="font-semibold">
			Final Details for Order #
			<span>{order.display_id}</span>
		</h2>

		<button class="underline underline-offset-4" id="print" on:click={() => window.print()}>
			Print this page for your records.
		</button>

		<br />

		<b>Order Placed:</b>
		<span>
			{new Intl.DateTimeFormat('en-US', {
				dateStyle: 'long'
			}).format(new Date(order.created_at))}
		</span>

		<br />

		<b>Order Number:</b>
		<span>{order.display_id}</span>

		<br />
		<br />

		<b>
			Order Total: <span>{formatPrice(order.total)}</span>
		</b>

		<br />
		<br />

		<div class="order-wrapper border-2 border-foreground">
			<!-- TODO: Change to appropriate heading -->
			<h1 class="border-b-2 border-foreground font-bold">
				Estimated Delivery Date: <span>July 27, 2020</span>
			</h1>

			<br />

			<div class="grid gap-1">
				<div class="order-heading">
					<b>Items Ordered</b>
					<b>Price</b>
				</div>

				{#each order.items as item}
					<div class="item text-sm">
						<div class="col-left">
							<p>
								<span>{item.quantity}</span>
								of:
								<span><i>{item.title}</i></span>
							</p>
							<p class="text-xs">Condition: New</p>
							<p class="text-xs">Sold by: ABC International</p>
						</div>

						<div class="col-right">
							<span>{formatPrice(item.unit_price)}</span>
						</div>
					</div>

					<br />
				{/each}
			</div>
		</div>

		<div class="shipping-wrapper border-2 border-foreground">
			<b>Shipping Address:</b>
			<br />
			<span>{order.shipping_address.first_name} {order.shipping_address.last_name}</span>
			<br />
			<span>
				{order.shipping_address.address_1}{order.shipping_address.address_2
					? `, ${order.shipping_address.address_2}`
					: ''}
			</span>
			<br />
			<span>{order.shipping_address.city}</span>
			<br />
			<br />
			<b>Shipping Speed:</b>
			<br />
			<span>Standard Shipping</span>
		</div>

		<div class="payment-wrapper border-2 border-foreground">
			<h1 class="border-b-2 border-foreground font-bold">Payment Information</h1>

			<div class="py-1">
				<div class="col-left">
					<b>Payment Method:</b>
					<br />
					<span>
						{order.payments[0].provider_id.charAt(0).toUpperCase() +
							order.payments[0].provider_id.slice(1)}
					</span>
				</div>

				<div class="col-right">
					<div class="flex w-full justify-between gap-1">
						<p>Item(s) subtotal:</p>
						<p>{formatPrice(order.subtotal)}</p>
					</div>

					<div class="flex w-full justify-between gap-1">
						<p>Shipping cost:</p>
						<p>{formatPrice(order.shipping_methods[0].price)}</p>
					</div>

					<p>-------</p>

					<div class="flex w-full justify-between gap-1 font-bold">
						<p>Grand Total:</p>
						<p>{formatPrice(order.total)}</p>
					</div>
				</div>
			</div>
		</div>

		<p class="footer">
			To view the status of your order, return to <a
				class="underline underline-offset-4"
				href="/orders/{order.id}">
				Order Summary.
			</a>
		</p>
	</div>
</div>

<style>
	.logo-container {
		width: 100px;
		margin: 0 auto;
	}

	.container {
		width: 85%;
		margin: 0 auto;
	}

	h1 {
		font-size: 110%;
		text-align: center;
		margin: 0;
		padding: 0.5em 0;
	}

	h2 {
		font-size: 105%;
		color: red;
		text-align: center;
		margin: 0;
	}

	#print {
		text-align: center;
		display: block;
		margin: 0 auto;
	}

	.order-wrapper {
		padding-left: 1%;
		padding-right: 1%;
		padding-bottom: 0.5rem;
	}

	.order-heading {
		display: flex;
		justify-content: space-between;
	}

	.item {
		display: flex;
		justify-content: space-between;
	}

	.shipping-wrapper {
		padding: 0 1%;
		margin-top: 0.5%;
		padding-top: 4px;
		padding-bottom: 4px;
	}

	.payment-wrapper {
		margin-top: 0.5%;
		padding: 0 1%;
	}

	.payment-wrapper > div {
		display: flex;
		justify-content: space-between;
	}

	.payment-wrapper .col-right {
		display: flex;
		flex-direction: column;
		align-items: flex-end;
	}
	.payment-wrapper .col-right p {
		margin: 0;
	}
	.payment-wrapper .col-right p span {
		margin-left: 10px;
	}

	.footer {
		text-align: center;
		padding-top: 0.5rem;
	}
</style>
