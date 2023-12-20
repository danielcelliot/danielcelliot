<script lang="ts">
	import type { PageServerData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import * as Card from '$lib/components/ui/card';
	import * as Alert from '$lib/components/ui/alert';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { loginSchema } from '$lib/schemas/login';
	import {
		PUBLIC_FRONTEND_URL,
		PUBLIC_MEDUSA_BACKEND_URL,
		PUBLIC_STORE_NAME,
		PUBLIC_TURNSTILE_SITE_KEY
	} from '$env/static/public';
	import Google from '$lib/assets/icons/Google.svelte';
	import Facebook from '$lib/assets/icons/Facebook.svelte';
	import { Turnstile } from 'sveltekit-turnstile';
	import { onMount } from 'svelte';
	import { page } from '$app/stores';

	export let data: PageServerData;

	let show_password = false;
	let mounted = false;
	let messageParam = $page.url.searchParams.get('message');
	let redirectTo = $page.url.searchParams.get('redirectTo');

	$: type = show_password ? 'text' : 'password';
	$: label = show_password ? 'Show password as plain text.' : 'Hide password.';

	const { form, enhance, errors, message, delayed, submitting } = superForm(data.form, {
		validators: loginSchema,
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
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
					<Card.Title class="text-2xl">Hello</Card.Title>
					<Card.Description>
						Sign in to {PUBLIC_STORE_NAME} or
						<a
							href="/accounts/customer/register"
							class="font-medium text-foreground underline underline-offset-4 hover:no-underline">
							create an account
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
					<div class="grid grid-cols-2 gap-4">
						<Button
							variant="outline"
							class="rounded-2xl"
							href="{PUBLIC_MEDUSA_BACKEND_URL}/store/auth/google{redirectTo
								? `?redirectTo=${PUBLIC_FRONTEND_URL}${redirectTo}`
								: ''}">
							<Google class="mr-2 h-4 w-4" />
							Google
						</Button>
						<Button
							variant="outline"
							class="rounded-2xl"
							href="{PUBLIC_MEDUSA_BACKEND_URL}/store/auth/facebook{redirectTo
								? `?redirectTo=${PUBLIC_FRONTEND_URL}${redirectTo}`
								: ''}">
							<Facebook class="mr-2 h-4 w-4" />
							Facebook
						</Button>
					</div>

					<div class="relative">
						<div class="absolute inset-0 flex items-center">
							<span class="w-full border-t" />
						</div>
						<div class="relative flex justify-center text-xs uppercase">
							<span class="bg-background px-2 text-muted-foreground">Or continue with</span>
						</div>
					</div>

					<div class="grid gap-2">
						<Label for="email">Email</Label>
						<Input
							id="email"
							name="email"
							type="email"
							placeholder={$errors.email ? '' : 'name@example.com'}
							autocomplete="email"
							aria-invalid={$errors.email ? 'true' : undefined}
							bind:value={$form.email}
							class="rounded-2xl
                {$errors.email ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.email}
							<p transition:slide class="text-xs font-medium text-destructive">{$errors.email}</p>
						{/if}
					</div>

					<div class="grid gap-2">
						<Label for="password">Password</Label>
						<div
							class="flex overflow-clip rounded-2xl border shadow-sm focus-within:ring-1
              {$errors.password
								? 'border-destructive focus-within:ring-destructive'
								: 'border-input focus-within:ring-ring'}">
							<Input
								id="password"
								name="password"
								{type}
								autocomplete="current-password"
								aria-label={label}
								aria-invalid={$errors.password ? 'true' : undefined}
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

						<a
							href="/accounts/customer/recover"
							class="w-fit text-sm font-medium underline underline-offset-4 hover:no-underline">
							Forgot password?
						</a>
					</div>
				</Card.Content>

				<Card.Footer class="grid gap-6">
					<div class={$submitting ? 'cursor-not-allowed' : ''}>
						<Button disabled={$submitting} class="w-full rounded-2xl font-semibold" type="submit">
							{#if $delayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{/if}
							<span>{$delayed ? 'Signing in...' : 'Sign in'}</span>
						</Button>
					</div>
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
