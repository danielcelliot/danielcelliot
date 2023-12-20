<script lang="ts">
	import { superForm } from 'sveltekit-superforms/client';
	import type { PageData } from './$types';
	import { formatPrice, getProductConditionStore } from '$lib/client/shop';
	import { VariantType } from '$lib/types/medusa';
	import { createRadioGroup, melt } from '@melt-ui/svelte';
	import * as Alert from '$lib/components/ui/alert';
	import * as Card from '$lib/components/ui/card';
	import JamPaypal from '$lib/assets/icons/JamPaypal.svelte';
	import {
		AlertCircle,
		CreditCard,
		Image,
		Loader2,
		ShoppingBag,
		Truck,
		Wallet
	} from 'lucide-svelte';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { slide } from 'svelte/transition';
	import AdvancedPhoneInput from '$lib/components/ui/input-phone/AdvancedPhoneInput.svelte';
	import type {
		CountryCode,
		DetailedValue,
		E164Number,
		TelInputOptions
	} from 'svelte-tel-input/types';
	import { Separator } from '$lib/components/ui/separator';
	import { Button } from '$lib/components/ui/button';
	import ListOutline from '$lib/assets/icons/ListOutline.svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import DeliveryOptions from '$lib/components/shop/delivery-options/DeliveryOptions.svelte';
	import SuperDebug from 'sveltekit-superforms/client/SuperDebug.svelte';
	import { checkoutSchema } from '$lib/schemas/checkout';
	import { onMount } from 'svelte';
	import { PUBLIC_STORE_NAME } from '$env/static/public';

	export let data: PageData;

	$: ({ cart } = data.customerData);
	$: ({ customer } = data.customerData);
	// $: ({ shippingOptions } = data.customerData);

	const { form, message, enhance, errors, delayed, submitting } = superForm(data.checkoutForm, {
		delayMs: 500,
		timeoutMs: 8000,
		validators: checkoutSchema,
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const {
		elements: { root, item, hiddenInput },
		helpers: { isChecked }
	} = createRadioGroup({
		loop: true,
		orientation: 'horizontal',
		defaultValue: 'card'
	});

	let telValue: E164Number | null;
	let countryCode: CountryCode = 'TT';
	let validTel: boolean;
	let detailedTelValue: DetailedValue | null = null;
	let telOptions: TelInputOptions = {
		autoPlaceholder: true,
		format: 'international',
		invalidateOnCountryChange: true
	};

	onMount(() => {
		$form.cart_id = cart?.id ?? '';
		$form.email = customer?.email ?? '';
		$form.payment_provider_id = cart?.payment_sessions?.[0].provider_id ?? '';
		$form.shipping_option_id = cart?.shipping_methods?.[0].shipping_option.id ?? '';
	});

	telValue = $form.phone ?? null;
	$: $form.phone = telValue?.length ? telValue : '';
	$: validTel = $errors.phone ? false : true;

	// $: console.log(data.customerData);
</script>

<main class="pb-8 pt-2">
	{#if cart?.items && cart?.items.length > 0}
		{#if cart.payment_sessions && cart.payment_sessions.length > 0}
			<div class="flex justify-center">
				<h1 class="pb-2 text-3xl font-semibold tracking-tight first:mt-0">Checkout</h1>
			</div>

			<!-- <div class="pb-2">
				<SuperDebug data={$form} />
			</div> -->

			<form action="?/complete" method="post" use:enhance>
				<input type="hidden" name="cart_id" value={cart.id} />

				<div class="grid gap-2">
					<!-- Items & delivery options -->
					<Card.Root class="w-full rounded-xl">
						<Card.Header>
							<div class="flex items-center gap-3">
								<ShoppingBag size={36} class="fill-primary" />

								<div class="space-y-1.5">
									<Card.Title class="flex items-end">My bag</Card.Title>

									<Card.Description class="flex items-center truncate text-xs">
										{formatPrice(cart.subtotal)} subtotal
										<span class="mx-1 h-1.5 w-1.5 rounded-full bg-muted-foreground" />
										{cart.items.length} items
									</Card.Description>
								</div>
							</div>
						</Card.Header>

						<Card.Content>
							<div class="grid gap-6">
								{#each cart.items as { thumbnail, title, variant, subtotal, quantity, id }, i (id)}
									<div class="grid gap-3">
										<p class="line-clamp-3 w-fit text-xs font-normal text-muted-foreground">
											Sold by ABC Enterprises Ltd.
										</p>

										<div class="grid grid-flow-col grid-cols-4 gap-3">
											<div class="col-span-1">
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
											</div>

											<div class="col-span-3 flex flex-col justify-between">
												<div class="space-y-0.5">
													<p class="line-clamp-3 w-fit text-sm font-semibold">
														{title}
													</p>

													{#if variant.product.variant_type === VariantType.MULTI}
														<div class="flex items-baseline gap-4">
															{#each variant.options as { name, value }}
																<p class="text-xs">
																	<span class="text-muted-foreground">{name}: {value}</span>
																</p>
															{/each}
														</div>
													{/if}
												</div>

												<div class="flex justify-between">
													<div>
														<p class="text-xs text-muted-foreground">
															{getProductConditionStore(variant.product.condition)}
														</p>

														<p class="text-sm">
															{formatPrice(subtotal)}
														</p>
													</div>

													<div class="flex flex-col items-center">
														<p class="text-xs text-muted-foreground">Quantity</p>

														<p class="text-right text-sm">
															{quantity}
														</p>
													</div>
												</div>
											</div>
										</div>

										<div class="grid gap-2">
											<p class="line-clamp-3 w-fit text-xs font-normal text-muted-foreground">
												Delivery options (Select one)
											</p>

											<DeliveryOptions shippingTotal={cart.shipping_total} />
										</div>
									</div>

									{#if i !== cart.items.length - 1}
										<Separator />
									{/if}
								{/each}
							</div>
						</Card.Content>
					</Card.Root>

					<!-- Delivery Address -->
					<Card.Root class="w-full rounded-xl">
						<Card.Header>
							<Card.Title class="flex items-end">
								<Truck size={18} class="mr-3" />
								Deliver to
							</Card.Title>
						</Card.Header>

						<input
							type="hidden"
							name="shipping_option_id"
							value={cart.shipping_methods ? cart.shipping_methods[0].shipping_option.id : ''} />

						<!-- {#if customer?.shipping_addresses && customer.shipping_addresses.length > 0}
							<h4>Saved addresses:</h4>
							<ul>
								{#each customer.shipping_addresses as address (address.id)}
									<li>
										<label>
											<input
												type="radio"
												name="address"
												value={address.id}
												on:click={() => updateAddress(address)} />
											<ul>
												<li><span>{address.first_name} {address.last_name}</span></li>
												<li>{address.address_1}</li>
												{#if address.address_2}
													<li>{address.address_2}</li>
												{/if}
												<li>{address.city}</li>
												<li>{address.phone}</li>
											</ul>
										</label>
									</li>
								{/each}
								<li>
									<label>
										<input type="radio" name="address" on:click={() => clearAddress()} />
										<ul>
											<li><span>Add new address</span></li>
										</ul>
									</label>
								</li>
							</ul>
						{/if} -->

						<Card.Content class="grid gap-4">
							<div class="grid gap-2">
								<Label for="first_name">
									First name
									<sup class="text-destructive">*</sup>
								</Label>
								<Input
									id="first_name"
									name="first_name"
									aria-invalid={$errors.first_name ? 'true' : undefined}
									bind:value={$form.first_name}
									class="rounded-2xl
                    {$errors.first_name
										? 'border-destructive focus-visible:ring-destructive'
										: ''}" />

								{#if $errors.first_name}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.first_name}
									</p>
								{/if}
							</div>

							<div class="grid gap-2">
								<Label for="last_name">
									Last name
									<sup class="text-destructive">*</sup>
								</Label>
								<Input
									id="last_name"
									name="last_name"
									aria-invalid={$errors.last_name ? 'true' : undefined}
									bind:value={$form.last_name}
									class="rounded-2xl
                    {$errors.last_name
										? 'border-destructive focus-visible:ring-destructive'
										: ''}" />

								{#if $errors.last_name}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.last_name}
									</p>
								{/if}
							</div>

							<div class="grid gap-2">
								<Label for="phone">
									Phone number
									<sup class="text-destructive">*</sup>
								</Label>

								<div aria-invalid={$errors.phone ? 'true' : undefined}>
									<AdvancedPhoneInput
										bind:selectedCountry={countryCode}
										bind:detailedValue={detailedTelValue}
										bind:value={telValue}
										bind:valid={validTel}
										options={telOptions} />
								</div>

								{#if $errors.phone}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.phone}
									</p>
								{/if}
							</div>

							<div class="grid gap-2">
								<Label for="address_1">
									Address Line 1
									<sup class="text-destructive">*</sup>
								</Label>
								<Input
									id="address_1"
									name="address_1"
									aria-invalid={$errors.address_1 ? 'true' : undefined}
									bind:value={$form.address_1}
									class="rounded-2xl
                    {$errors.address_1
										? 'border-destructive focus-visible:ring-destructive'
										: ''}" />

								{#if $errors.address_1}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.address_1}
									</p>
								{/if}
							</div>

							<div class="grid gap-2">
								<Label for="address_2">Address Line 2</Label>
								<Input
									id="address_2"
									name="address_2"
									aria-invalid={$errors.address_2 ? 'true' : undefined}
									bind:value={$form.address_2}
									class="rounded-2xl
                    {$errors.address_2
										? 'border-destructive focus-visible:ring-destructive'
										: ''}" />

								{#if $errors.address_2}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.address_2}
									</p>
								{/if}
							</div>

							<div class="grid gap-2">
								<Label for="city">
									City / Town
									<sup class="text-destructive">*</sup>
								</Label>
								<Input
									id="city"
									name="city"
									aria-invalid={$errors.city ? 'true' : undefined}
									bind:value={$form.city}
									class="rounded-2xl
                    {$errors.city ? 'border-destructive focus-visible:ring-destructive' : ''}" />

								{#if $errors.city}
									<p transition:slide class="text-xs font-medium text-destructive">
										{$errors.city}
									</p>
								{/if}
							</div>
						</Card.Content>
					</Card.Root>

					<!-- Payment Methods -->
					<Card.Root class="w-full rounded-xl">
						<Card.Header>
							<Card.Title class="flex items-end">
								<Wallet size={16} class="mr-3" />
								Pay with
							</Card.Title>
						</Card.Header>

						<input
							type="hidden"
							name="payment_provider_id"
							value={cart.payment_sessions[0].provider_id} />

						<Card.Content>
							<div use:melt={$root} class="grid grid-cols-2 gap-4">
								<button
									use:melt={$item('paypal')}
									class="rounded-lg border-2 bg-transparent p-4 hover:bg-muted {$isChecked('paypal')
										? 'border-ring'
										: 'border-muted'}">
									<div class="flex flex-col items-center gap-3">
										<JamPaypal class="h-6 w-6" />
										<p class="text-sm font-medium leading-none">PayPal</p>
									</div>
								</button>

								<button
									use:melt={$item('card')}
									class="rounded-lg border-2 bg-transparent p-4 hover:bg-muted {$isChecked('card')
										? 'border-ring'
										: 'border-muted'}">
									<div class="flex flex-col items-center gap-3">
										<CreditCard class="h-6 w-6" />
										<p class="text-sm font-medium leading-none">Credit Card</p>
									</div>
								</button>
							</div>
						</Card.Content>
					</Card.Root>

					<!-- Order Summary -->
					<Card.Root class="w-full rounded-xl">
						<Card.Header>
							<Card.Title class="flex items-end">
								<ListOutline class="mr-3 h-4 w-4" />
								Order summary
							</Card.Title>
						</Card.Header>

						<Card.Content>
							<div class="grid gap-4">
								<div class="flex justify-between">
									<p class="text-sm">Subtotal ({cart.items.length} items)</p>
									<p class="text-sm">{formatPrice(cart.subtotal)}</p>
								</div>

								<div class="flex justify-between">
									<p class="text-sm">Shipping</p>
									<p class="text-sm">
										{cart.shipping_total === 0 ? 'Free' : formatPrice(cart.shipping_total)}
									</p>
								</div>

								<Separator />
								<div class="flex justify-between">
									<p class="font-semibold">Total</p>
									<p class="font-semibold">{formatPrice(cart.total)}</p>
								</div>
								<Separator />
							</div>
						</Card.Content>
					</Card.Root>

					<!-- Finalize Order -->
					<Card.Root class={customer?.email ? 'border-none' : 'w-full rounded-xl'}>
						<Card.Content class="space-y-6 {customer?.email ? 'px-6' : 'pt-6'}">
							{#if customer?.email}
								<input type="hidden" name="email" value={customer.email} />
							{:else}
								<div class="grid gap-2">
									<Label for="email">
										Email
										<sup class="text-destructive">*</sup>
									</Label>
									<Input
										id="email"
										name="email"
										type="email"
										placeholder={$errors.email ? '' : 'name@example.com'}
										aria-invalid={$errors.email ? 'true' : undefined}
										bind:value={$form.email}
										class="rounded-2xl
                    {$errors.email ? 'border-destructive focus-visible:ring-destructive' : ''}" />

									{#if $errors.email}
										<p transition:slide class="text-xs font-medium text-destructive">
											{$errors.email}
										</p>
									{/if}

									<p class="text-xs font-medium text-muted-foreground">
										Order confirmation and updates will be emailed to this address
									</p>
								</div>
							{/if}

							{#if $message}
								<div transition:slide>
									<Alert.Root
										variant="destructive"
										class="bg-destructive text-destructive-foreground">
										<Alert.Description class="flex items-center">
											<AlertCircle class="mr-2 h-4 w-4" />
											{$message.text}
										</Alert.Description>
									</Alert.Root>
								</div>
							{/if}

							<div class="space-y-2">
								<Button
									type="submit"
									disabled={$submitting}
									class="w-full rounded-2xl font-semibold">
									{#if $delayed}
										<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
									{/if}
									{$delayed ? 'Completing order...' : 'Complete your order'}
								</Button>

								<p class="text-xs font-medium text-muted-foreground">
									By placing an order, you agree to {PUBLIC_STORE_NAME}'s
									<a
										href="/"
										target="_blank"
										class="font-medium text-foreground underline underline-offset-4 hover:no-underline">
										terms
									</a>
									and
									<a
										href="/"
										target="_blank"
										class="font-medium text-foreground underline underline-offset-4 hover:no-underline">
										privacy policy
									</a>
								</p>
							</div>
						</Card.Content>
					</Card.Root>
				</div>
			</form>
		{:else}
			<section>
				<form action="/cart?/checkout" method="post">
					<input type="hidden" name="cart_id" value={cart.id} required minlength="1" />
					<p>Your checkout session has not been created.</p>
					<button type="submit">Create checkout session</button>
				</form>
			</section>
		{/if}
	{:else}
		<section>
			<p>
				<b>Your checkout is empty.</b>
				<a href="/">Click here</a>
				to start shopping today!
			</p>
		</section>
	{/if}
</main>
