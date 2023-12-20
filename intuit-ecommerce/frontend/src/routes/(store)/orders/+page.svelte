<script lang="ts">
	import { superForm } from 'sveltekit-superforms/client';
	import type { PageData } from './$types';
	import { slide } from 'svelte/transition';
	import * as Card from '$lib/components/ui/card';
	import * as Alert from '$lib/components/ui/alert';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { orderIdSchema } from '$lib/schemas/order';
	import { onMount } from 'svelte';
	import { Turnstile } from 'sveltekit-turnstile';
	import { PUBLIC_TURNSTILE_SITE_KEY } from '$env/static/public';

	export let data: PageData;

	let mounted = false;

	const { form, enhance, errors, message, delayed, submitting } = superForm(data.form, {
		validators: orderIdSchema,
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

<main class="container mx-auto my-4 px-2 min-[380px]:px-4">
	<form method="POST" class="space-y-4" use:enhance>
		<Card.Root class="w-full rounded-xl">
			<Card.Header class="space-y-0">
				<div class="grid gap-1">
					<Card.Title class="text-2xl">Orders</Card.Title>
					<Card.Description>Enter your Order ID below</Card.Description>
				</div>

				{#if $message}
					<div transition:slide class="pt-4">
						<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
							<div class="flex">
								<AlertCircle class="mr-2 mt-0.5 h-4 w-4 flex-none" />
								<Alert.Description>
									{$message.text}
								</Alert.Description>
							</div>
						</Alert.Root>
					</div>
				{/if}
			</Card.Header>

			<div class="grid gap-6">
				<Card.Content class="grid gap-4 px-6 py-0">
					<div class="grid gap-2">
						<Label for="order_id">Order ID</Label>
						<Input
							id="order_id"
							name="order_id"
							type="text"
							aria-invalid={$errors.order_id ? 'true' : undefined}
							bind:value={$form.order_id}
							class="rounded-2xl
                  {$errors.order_id ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.order_id}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.order_id}
							</p>
						{/if}

						<p class="text-xs font-medium text-muted-foreground">
							Tip: You can copy & paste your order ID into the field above, or you can click the
							link provided in your order confirmation email.
						</p>
					</div>
				</Card.Content>

				<Card.Footer class="grid gap-6">
					<div class={$submitting ? 'cursor-not-allowed' : ''}>
						<Button
							disabled={$submitting}
							variant="secondary"
							class="w-full rounded-2xl font-semibold"
							type="submit">
							{#if $delayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{/if}
							<span>{$delayed ? 'Loading order...' : 'Show my order'}</span>
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
</main>
