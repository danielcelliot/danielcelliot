<script lang="ts">
	import { formatPrice, getProductConditionStore } from '$lib/client/shop';
	import { VariantType } from '$lib/types/medusa';
	import { tick } from 'svelte';
	import { slide } from 'svelte/transition';
	import { debounce } from 'throttle-debounce';
	import { superForm } from 'sveltekit-superforms/client';
	import { Button } from '$lib/components/ui/button';
	import { Separator } from '$lib/components/ui/separator';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Input } from '$lib/components/ui/input';
	import * as Alert from '$lib/components/ui/alert';
	import * as Card from '$lib/components/ui/card';
	import * as Sheet from '$lib/components/ui/sheet';
	import { Minus, Plus } from 'radix-icons-svelte';
	import { AlertCircle, Image, Loader2 } from 'lucide-svelte';
	import undraw_successful_purchase from '$lib/assets/images/undraw_successful_purchase.svg';

	export let data;

	$: ({ cart } = data);

	let itemsForm: HTMLFormElement[] = [];

	const {
		enhance: updateEnhance,
		message: updateMessage,
		delayed: updateDelayed,
		submitting: updateSubmitting,
		formId: updateFormId
	} = superForm(data.updateItemForm, {
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onError({ result }) {
			$updateMessage = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const {
		enhance: deleteEnhance,
		message: deleteMessage,
		delayed: deleteDelayed,
		submitting: deleteSubmitting,
		formId: deleteFormId
	} = superForm(data.deleteItemForm, {
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onError({ result }) {
			$deleteMessage = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const {
		enhance: checkoutEnhance,
		message: checkoutMessage,
		delayed: checkoutDelayed,
		submitting: checkoutSubmitting
	} = superForm(data.checkoutForm, {
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onError({ result }) {
			$checkoutMessage = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const debounceSubmit = debounce(500, (form: HTMLFormElement) => {
		form.requestSubmit();
	});

	function handleFocus(e: Event) {
		const target = e.target as HTMLInputElement;
		target.select();
	}

	// $: console.log(cart);
	// $: console.log(data.customerData);
</script>

<main class="container mx-auto px-2 min-[380px]:px-4">
	{#if cart && cart.items?.length}
		<div class="grid gap-3 py-4">
			<div class="flex items-center justify-between">
				<h1 class="text-base font-normal tracking-tight text-muted-foreground">My Bag</h1>

				{#if data.customerData.customer}
					<form action="?/checkout" method="POST" use:checkoutEnhance>
						<input type="hidden" name="cart_id" value={cart.id} />

						<Button
							type="submit"
							disabled={$deleteSubmitting || $updateSubmitting || $checkoutSubmitting}
							size="sm"
							class="w-[180px] rounded-2xl text-sm font-semibold">
							{#if $checkoutDelayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{/if}
							{$checkoutDelayed ? 'Loading...' : 'Go to checkout'}
						</Button>
					</form>
				{:else}
					<Sheet.Root>
						<Sheet.Trigger>
							<Button
								disabled={$deleteSubmitting || $updateSubmitting}
								size="sm"
								class="w-[180px] rounded-2xl text-sm font-semibold">
								Go to checkout
							</Button>
						</Sheet.Trigger>
						<Sheet.Content side="bottom">
							<Sheet.Header class="pb-4">
								<Sheet.Title>Proceed to checkout</Sheet.Title>
							</Sheet.Header>
							<Sheet.Footer class="grid gap-2">
								<form action="?/checkout" method="POST" use:checkoutEnhance>
									<input type="hidden" name="cart_id" value={cart.id} />

									<Button
										type="submit"
										disabled={$checkoutSubmitting}
										variant="outline"
										class="w-full rounded-2xl">
										{#if $checkoutDelayed}
											<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
										{/if}
										{$checkoutDelayed ? 'Loading...' : 'Continue as guest'}
									</Button>
								</form>

								<Button class="rounded-2xl" href="/accounts/customer/signin?redirectTo=/cart">
									Sign in to my account
								</Button>
							</Sheet.Footer>
						</Sheet.Content>
					</Sheet.Root>
				{/if}
			</div>

			<Card.Root class="rounded-2xl">
				<Card.Content class="space-y-3 px-4 py-3">
					{#if $deleteMessage && $deleteMessage.type == 'error'}
						<div transition:slide>
							<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
								<Alert.Description class="flex items-center">
									<AlertCircle class="mr-2 h-4 w-4" />
									{$deleteMessage.text}
								</Alert.Description>
							</Alert.Root>
						</div>
					{/if}

					{#if $updateMessage && $updateMessage.type == 'error'}
						<div transition:slide>
							<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
								<Alert.Description class="flex items-center">
									<AlertCircle class="mr-2 h-4 w-4" />
									{$updateMessage.text}
								</Alert.Description>
							</Alert.Root>
						</div>
					{/if}

					{#if $checkoutMessage}
						<div transition:slide>
							<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
								<Alert.Description class="flex items-center">
									<AlertCircle class="mr-2 h-4 w-4" />
									{$checkoutMessage.text}
								</Alert.Description>
							</Alert.Root>
						</div>
					{/if}

					{#each cart.items as { thumbnail, title, variant, subtotal, unit_price, quantity, id }, i (id)}
						<div class="grid gap-1.5" out:slide>
							<div class="grid grid-flow-col grid-cols-4 gap-3">
								<div class="col-span-1">
									<a href="/products/{variant.product.handle}">
										{#if variant.thumbnail || thumbnail}
											<AspectRatio ratio={3 / 4}>
												<img
													class="h-full w-full rounded-lg object-cover"
													src={variant.thumbnail ?? thumbnail}
													alt="" />
											</AspectRatio>
										{:else}
											<Image strokeWidth={1} class="h-full w-full" />
										{/if}
									</a>
								</div>

								<div class="col-span-3 flex flex-col justify-between">
									<div class="space-y-0.5">
										<a
											href="/products/{variant.product.handle}"
											class="line-clamp-3 w-fit text-sm font-semibold underline underline-offset-4 hover:no-underline">
											{title}
										</a>

										{#if variant.product.variant_type === VariantType.MULTI}
											<div class="flex gap-4">
												{#each variant.options as { name, value }}
													<p class="text-sm">
														<span class="text-muted-foreground">{name}:</span>
														{value}
													</p>
												{/each}
											</div>
										{/if}
									</div>

									<div>
										<p class="text-xs text-muted-foreground">
											{getProductConditionStore(variant.product.condition)}
										</p>

										<p class="text-sm">
											{formatPrice(subtotal)}
											<span class="ml-2 text-xs text-muted-foreground">
												{quantity > 1 ? `${formatPrice(unit_price)} each` : ''}
											</span>
										</p>
									</div>
								</div>
							</div>

							<div class="flex items-center justify-between">
								<div class="flex gap-4">
									<form action="?/remove" method="POST" use:deleteEnhance>
										<input type="hidden" name="cart_id" value={cart.id} />
										<input type="hidden" name="item_id" value={id} />

										<Button
											on:click={() => ($deleteFormId = id)}
											disabled={($deleteSubmitting && $deleteFormId == id) ||
												($updateSubmitting && $updateFormId == id)}
											size="sm"
											variant="ghost"
											class="w-[100px] rounded-2xl text-muted-foreground">
											{#if $deleteDelayed && $deleteFormId == id}
												<Loader2 size={16} strokeWidth={2.75} class="animate-spin" />
											{:else}
												<span>Remove item</span>
											{/if}
										</Button>
									</form>
								</div>

								<form action="?/update" method="POST" use:updateEnhance bind:this={itemsForm[i]}>
									<input type="hidden" name="cart_id" value={cart.id} />
									<input type="hidden" name="item_id" value={id} />
									<input type="hidden" name="__superform_id" value={id} />

									<div
										class="flex w-[124px] items-center justify-between rounded-2xl border border-input p-0.5 focus-within:ring-1 focus-within:ring-ring">
										<Button
											disabled={($updateSubmitting && $updateFormId == id) ||
												($deleteSubmitting && $deleteFormId == id)}
											type="submit"
											size="icon"
											variant="ghost"
											class="h-7 w-7 rounded-full"
											on:click={async (e) => {
												e.preventDefault();
												$updateFormId = id;

												if (cart && quantity > 1) {
													cart.items[i].quantity -= 1;
													await tick();
													debounceSubmit(itemsForm[i]);
												}
											}}>
											<Minus />
										</Button>

										{#if $updateDelayed && $updateFormId == id}
											<Loader2 size={12} strokeWidth={2.75} class="animate-spin" />
										{:else}
											<Input
												on:change={() => {
													$updateFormId = id;
													itemsForm[i].requestSubmit();
												}}
												on:focus={handleFocus}
												type="number"
												name="quantity"
												bind:value={cart.items[i].quantity}
												step="1"
												min="1"
												max={cart.items[i].variant.inventory_quantity}
												class="h-7 w-[55px] rounded-none border-none text-center shadow-none [appearance:textfield] focus-visible:ring-0 [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none" />
										{/if}

										<Button
											disabled={$updateSubmitting && $updateFormId == id}
											type="submit"
											size="icon"
											variant="ghost"
											class="h-7 w-7 rounded-full"
											on:click={async (e) => {
												e.preventDefault();
												$updateFormId = id;

												if (cart && quantity < variant.inventory_quantity) {
													cart.items[i].quantity += 1;
													await tick();
													debounceSubmit(itemsForm[i]);
												}
											}}>
											<Plus />
										</Button>
									</div>
								</form>
							</div>
						</div>

						<Separator />
					{/each}

					<div class="flex justify-between text-sm">
						<p class="text-muted-foreground">
							Subtotal ({cart.items.length} items):
						</p>

						<p class="font-semibold">
							{formatPrice(cart.subtotal)}
						</p>
					</div>
				</Card.Content>
			</Card.Root>
		</div>
	{:else}
		<div class="grid place-items-center gap-4 px-2 py-8">
			<div class="grid place-items-center gap-1.5">
				<h3 class="text-2xl font-semibold tracking-tight">Your bag is empty</h3>
				{#if !data.customerData.customer}
					<p class="text-sm">Have an account? Sign in to see your bag</p>
				{/if}
			</div>

			{#if data.customerData.customer}
				<Button href="/" class="w-[220px] rounded-2xl font-semibold">Start shopping</Button>
			{:else}
				<Button href="/accounts/customer/signin" class="w-[220px] rounded-2xl font-semibold">
					Sign in
				</Button>
			{/if}

			<img src={undraw_successful_purchase} alt="" width="240px" class="mt-4" />
		</div>
	{/if}
</main>
