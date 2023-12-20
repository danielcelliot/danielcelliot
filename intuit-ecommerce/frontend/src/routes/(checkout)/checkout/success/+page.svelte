<script lang="ts">
	import { onMount } from 'svelte';
	import { fade, fly } from 'svelte/transition';
	import undraw_online_party from '$lib/assets/images/undraw_online_party.svg';
	import CheckLarge from '$lib/assets/icons/CheckLarge.svelte';
	import { Button } from '$lib/components/ui/button/index.js';
	import { confetti } from '@neoconfetti/svelte';
	import { mode } from 'mode-watcher';

	export let data;

	let { customer, order } = data;
	let showContent: boolean;
	let confettiColours = [
		'#FAD12C',
		$mode === 'light' ? '#020817' : '#FFFFFF',
		$mode === 'light' ? '#E6E6E6' : '#C6CACF'
	];

	onMount(() => (showContent = true));
</script>

<main class="container overflow-x-clip">
	{#if showContent}
		<div class="flex justify-center">
			<div use:confetti={{ colors: confettiColours }} />
		</div>

		<div class="flex h-full flex-col">
			<div
				in:fade={{ delay: 1250, duration: 1000 }}
				id="header"
				class="flex flex-col items-center justify-center gap-2 pt-6">
				<div class="flex h-16 w-16 items-center justify-center rounded-full bg-primary">
					<CheckLarge class="w-6" />
				</div>

				<h1 class="text-center text-4xl font-extrabold tracking-tight lg:text-5xl">
					{#if customer?.first_name}
						Thank You, {customer.first_name}!
					{:else}
						Thank You For Your Order!
					{/if}
				</h1>

				<p class="text-center text-sm text-muted-foreground">
					A confirmation e-mail will be sent to <span class="font-semibold">{order.email}</span>
					shortly
				</p>
			</div>

			<div id="content" class="flex-1 py-6">
				<div class="flex flex-col items-center justify-center gap-10">
					<div
						in:fade={{ delay: 1250, duration: 1000 }}
						class="flex w-fit rounded-2xl bg-muted px-4 py-2 text-sm">
						<p class="mr-3">
							Order #{order.display_id}
						</p>
						<a
							href="/"
							class="font-semibold text-foreground underline underline-offset-4 hover:no-underline">
							View Invoice
						</a>
					</div>

					<img
						in:fade={{ delay: 500, duration: 1000 }}
						src={undraw_online_party}
						alt=""
						class="w-72" />

					<div
						class="grid w-full justify-center gap-3 px-6"
						in:fly={{ delay: 1600, duration: 2000, y: 30 }}>
						{#if customer}
							<Button variant="secondary" class="w-full rounded-2xl font-semibold" href="/">
								View my orders
							</Button>

							<Button
								href="/"
								variant="link"
								class="w-fit rounded-2xl font-semibold text-foreground underline underline-offset-4 hover:no-underline">
								Continue shopping
							</Button>
						{:else}
							<Button variant="secondary" class="w-full rounded-2xl font-semibold" href="/">
								Continue shopping
							</Button>
						{/if}
					</div>

					<!-- TODO: Order summary Card -->
					<!-- <div in:fly={{ delay: 1250, duration: 1000, y: 30 }} class="w-full px-8">
						<Card.Root class="rounded-2xl p-4 shadow">
							<div class="grid gap-2">
								<p>Order number {order.display_id}</p>
								<p>Total {formatPrice(order.total)}</p>
								{#each order.items as item}
									<div class="grid grid-flow-col grid-cols-4">
										<div class="col-span-1">
											{#if item.variant.thumbnail || item.thumbnail}
												<AspectRatio ratio={3 / 4}>
													<img
														class="h-full w-full rounded-lg object-cover"
														src={item.variant.thumbnail ?? item.thumbnail}
														alt="" />
												</AspectRatio>
											{:else}
												<Image strokeWidth={1} class="h-full w-full" />
											{/if}
										</div>
										<div class="col-span-3 flex flex-col">
											<p>{item.title}</p>
											<p>X {item.quantity}</p>
										</div>
									</div>
								{/each}
							</div>
						</Card.Root>
					</div> -->
				</div>
			</div>
		</div>
	{/if}
</main>
