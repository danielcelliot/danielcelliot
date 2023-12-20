<script lang="ts">
	import type { PageServerData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';
	import { fly, slide } from 'svelte/transition';
	import * as Card from '$lib/components/ui/card';
	import * as Alert from '$lib/components/ui/alert';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { newCustomerSchema } from '$lib/schemas/login';
	import { zxcvbnOptions, type OptionsType, zxcvbnAsync, debounce } from '@zxcvbn-ts/core';
	import * as zxcvbnCommonPackage from '@zxcvbn-ts/language-common';
	import * as zxcvbnEnPackage from '@zxcvbn-ts/language-en';
	import { matcherPwnedFactory } from '@zxcvbn-ts/matcher-pwned';
	import { createProgress, melt } from '@melt-ui/svelte';
	import { writable } from 'svelte/store';
	import type {
		CountryCode,
		DetailedValue,
		E164Number,
		TelInputOptions
	} from 'svelte-tel-input/types';
	import AdvancedPhoneInput from '$lib/components/ui/input-phone/AdvancedPhoneInput.svelte';
	import { PUBLIC_STORE_NAME, PUBLIC_TURNSTILE_SITE_KEY } from '$env/static/public';
	import { page } from '$app/stores';
	import { onMount } from 'svelte';
	import { Turnstile } from 'sveltekit-turnstile';

	export let data: PageServerData;
	let mounted = false;
	let messageParam = $page.url.searchParams.get('message');
	let show_password = false;
	let show_confirm = false;

	$: password_type = show_password ? 'text' : 'password';
	$: confirm_type = show_confirm ? 'text' : 'password';

	const { form, enhance, errors, message, delayed, submitting } = superForm(data.form, {
		validators: newCustomerSchema,
		delayMs: 500,
		timeoutMs: 8000,
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	if (messageParam)
		$message = {
			type: 'error',
			text: messageParam
		};

	const value = writable(0);
	const {
		elements: { root },
		options: { max }
	} = createProgress({
		value,
		max: 5
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

	let msg = ['Weak', 'Average', 'Good', 'Strong', 'Very strong'];
	let color = ['#EA2027', '#EE5A24', '#F79F1F', '#A3CB38', '#009432'];
	let isStrong: string;
	let isStrongColor: string;

	const matcherPwned = matcherPwnedFactory(fetch, zxcvbnOptions);
	zxcvbnOptions.addMatcher('pwned', matcherPwned);

	const options: OptionsType = {
		dictionary: {
			...zxcvbnCommonPackage.dictionary,
			...zxcvbnEnPackage.dictionary
		},
		graphs: zxcvbnCommonPackage.adjacencyGraphs,
		translations: zxcvbnEnPackage.translations,
		useLevenshteinDistance: true
	};

	zxcvbnOptions.setOptions(options);

	const getPasswordStrength = () => {
		zxcvbnAsync($form.password).then((response) => {
			$value = response.score.valueOf() + 1;
			isStrong = msg[response.score];
			isStrongColor = color[response.score];
		});
	};

	const debouncedZxcvbn = debounce(getPasswordStrength, 300);

	telValue = $form.phone ?? null;
	$: $form.phone = telValue?.length ? telValue : undefined;

	onMount(() => {
		mounted = true;

		// Modify Cloudflare Turnstile iframe width
		// https://community.cloudflare.com/t/width-for-turnstile/422811
		window.addEventListener('message', function (e) {
			if (e.data.event !== 'init') {
				return;
			}

			let turnstileIframe = document.getElementById('cf-chl-widget-' + e.data.widgetId);
			if (!turnstileIframe) {
				return;
			}

			turnstileIframe.style.width = '100%';
			turnstileIframe.style.height = '65px';
			turnstileIframe.style.display = '';
			e.stopImmediatePropagation();
		});
	});
</script>

<section class="w-full">
	<form method="POST" class="space-y-4" use:enhance>
		<Card.Root class="rounded-xl">
			<Card.Header class="space-y-0">
				<div class="grid gap-1">
					<Card.Title class="text-2xl">Create an account</Card.Title>
					<Card.Description>
						Create your {PUBLIC_STORE_NAME} account or
						<a
							href="/accounts/customer/signin"
							class="font-medium text-foreground underline underline-offset-4 hover:no-underline">
							sign in
						</a>
					</Card.Description>
				</div>

				{#if $message}
					<div transition:slide class="pt-4">
						<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
							<Alert.Description class="flex items-center">
								<AlertCircle class="mr-2 h-4 w-4" />
								{$message.text}
							</Alert.Description>
						</Alert.Root>
					</div>
				{/if}
			</Card.Header>

			<div class="grid gap-6">
				<Card.Content class="grid gap-4 px-6 py-0">
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
							<p transition:slide class="text-xs font-medium text-destructive">{$errors.email}</p>
						{/if}
					</div>

					<div class="grid gap-2">
						<Label for="phone">Phone number</Label>
						<AdvancedPhoneInput
							bind:selectedCountry={countryCode}
							bind:detailedValue={detailedTelValue}
							bind:value={telValue}
							bind:valid={validTel}
							options={telOptions} />

						{#if $errors.phone}
							<p transition:slide class="text-xs font-medium text-destructive">{$errors.phone}</p>
						{/if}
					</div>

					<div class="grid gap-2">
						<Label for="first_name">
							First name
							<sup class="text-destructive">*</sup>
						</Label>
						<Input
							id="first_name"
							name="first_name"
							type="text"
							aria-invalid={$errors.first_name ? 'true' : undefined}
							bind:value={$form.first_name}
							class="rounded-2xl
                {$errors.first_name ? 'border-destructive focus-visible:ring-destructive' : ''}" />

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
							type="text"
							aria-invalid={$errors.last_name ? 'true' : undefined}
							bind:value={$form.last_name}
							class="rounded-2xl
                {$errors.last_name ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.last_name}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.last_name}
							</p>
						{/if}
					</div>

					<div class="grid gap-2">
						<div class="flex items-baseline justify-between">
							<Label for="password">
								Password
								<sup class="text-destructive">*</sup>
							</Label>

							{#if $form.password.length && $value}
								<div class="flex items-baseline" transition:fly>
									<p
										class="mr-1.5 text-xs font-medium leading-none"
										style="color: {isStrongColor};">
										{isStrong}
									</p>

									<div
										use:melt={$root}
										class="relative h-1.5 w-[80px] overflow-hidden rounded-2xl bg-muted">
										<div
											class="h-full w-full transition-transform duration-[660ms]
                      ease-[cubic-bezier(0.65,0,0.35,1)]"
											style={`background: ${isStrongColor}; transform: translateX(-${
												100 - (100 * ($value ?? 0)) / ($max ?? 1)
											}%)`} />
									</div>
								</div>
							{/if}
						</div>

						<div
							class="flex overflow-clip rounded-2xl border shadow-sm focus-within:ring-1
              {$errors.password
								? 'border-destructive focus-within:ring-destructive'
								: 'border-input focus-within:ring-ring'}">
							<Input
								id="password"
								name="password"
								type={password_type}
								placeholder="At least 6 characters"
								autocomplete="new-password"
								aria-invalid={$errors.password ? 'true' : undefined}
								on:input={debouncedZxcvbn}
								bind:value={$form.password}
								class="rounded-none border-none shadow-none focus-visible:ring-0" />

							<div class="flex h-9 items-center justify-center py-1.5 pr-1.5">
								<button
									type="button"
									on:click={() => (show_password = !show_password)}
									class="inline-flex h-full w-[60px] items-center justify-center whitespace-nowrap rounded-[11px] text-xs font-medium transition-colors hover:bg-accent hover:text-accent-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring">
									{show_password ? 'Hide' : 'Show'}
								</button>
							</div>
						</div>

						{#if $errors.password}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.password}
							</p>
						{/if}

						<p class="text-xs font-medium text-muted-foreground">
							Tip: Include symbols, numbers and capital letters in your password.
						</p>
					</div>

					<div class="grid gap-2">
						<Label for="confirm">
							Re-enter password
							<sup class="text-destructive">*</sup>
						</Label>

						<div
							class="flex overflow-clip rounded-2xl border shadow-sm focus-within:ring-1
              {$errors.confirm
								? 'border-destructive focus-within:ring-destructive'
								: 'border-input focus-within:ring-ring'}">
							<Input
								id="confirm"
								name="confirm"
								type={confirm_type}
								autocomplete="new-password"
								aria-invalid={$errors.confirm ? 'true' : undefined}
								bind:value={$form.confirm}
								class="rounded-none border-none shadow-none focus-visible:ring-0" />

							<div class="flex h-9 items-center justify-center py-1.5 pr-1.5">
								<button
									type="button"
									on:click={() => (show_confirm = !show_confirm)}
									class="inline-flex h-full w-[60px] items-center justify-center whitespace-nowrap rounded-[11px] text-xs font-medium transition-colors hover:bg-accent hover:text-accent-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring">
									{show_confirm ? 'Hide' : 'Show'}
								</button>
							</div>
						</div>

						{#if $errors.confirm}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.confirm}
							</p>
						{/if}
					</div>
				</Card.Content>

				<Card.Footer class="grid gap-2">
					<div class={$submitting ? 'cursor-not-allowed' : ''}>
						<Button disabled={$submitting} class="w-full rounded-2xl font-semibold" type="submit">
							{#if $delayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{/if}
							<span>{$delayed ? 'Saving...' : 'Create account'}</span>
						</Button>
					</div>

					<p class="text-xs font-medium text-muted-foreground">
						By creating an account, you agree to {PUBLIC_STORE_NAME}'s
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
				</Card.Footer>
			</div>
		</Card.Root>

		<div class="flex h-[66px] w-full justify-center">
			{#if mounted}
				<Turnstile siteKey={PUBLIC_TURNSTILE_SITE_KEY} />
			{/if}
		</div>
	</form>
</section>
