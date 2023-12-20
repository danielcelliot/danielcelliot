<script lang="ts">
	import type { PageData } from './$types';
	import * as Card from '$lib/components/ui/card';
	import * as Alert from '$lib/components/ui/alert';
	import { PUBLIC_STORE_NAME, PUBLIC_TURNSTILE_SITE_KEY } from '$env/static/public';
	import { slide } from 'svelte/transition';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { superForm } from 'sveltekit-superforms/client';
	import { loginSchema } from '$lib/schemas/login';
	import { page } from '$app/stores';
	import { Turnstile } from 'sveltekit-turnstile';
	import { onMount } from 'svelte';

	export let data: PageData;

	let mounted = false;
	let messageParam = $page.url.searchParams.get('message');

	const { form, enhance, errors, message, delayed, submitting } = superForm(data.form, {
		validators: loginSchema.pick({ email: true }),
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
					<Card.Title class="text-2xl">Recover Password</Card.Title>
					<Card.Description>
						Enter the email address associated with your {PUBLIC_STORE_NAME} account.
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
						<Label for="email">Email</Label>
						<Input
							id="email"
							name="email"
							type="email"
							autocomplete="email"
							aria-invalid={$errors.email ? 'true' : undefined}
							bind:value={$form.email}
							class="rounded-2xl
                {$errors.email ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.email}
							<p transition:slide class="text-xs font-medium text-destructive">{$errors.email}</p>
						{/if}
					</div>
				</Card.Content>

				<Card.Footer class="grid gap-6">
					<div class={$submitting ? 'cursor-not-allowed' : ''}>
						<Button
							variant="secondary"
							disabled={$submitting}
							class="w-full rounded-2xl font-semibold"
							type="submit">
							{#if $delayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{:else}
								Send me a recovery link
							{/if}
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
