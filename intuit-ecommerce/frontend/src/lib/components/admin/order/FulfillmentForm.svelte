<script lang="ts">
	import type { FulfillItemsSchema } from '$lib/schemas/order';
	import { createEventDispatcher } from 'svelte';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { superForm } from 'sveltekit-superforms/client';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { slide } from 'svelte/transition';
	import Label from '$lib/components/ui/label/label.svelte';
	import Input from '$lib/components/ui/input/input.svelte';
	import Button from '$lib/components/ui/button/button.svelte';

	export let fulfillmentForm: SuperValidated<FulfillItemsSchema>;
	export let fulfillmentData: {
		id: string;
		quantity: number;
		max_quantity: number;
		thumbnail: string | undefined;
		title: string;
		variant_title: string;
	}[];
	export let orderId: string;
	export let href: string;

	let disabled = false;

	const dispatch = createEventDispatcher();

	const { form, errors, enhance, message, delayed } = superForm(fulfillmentForm, {
		delayMs: 500,
		timeoutMs: 8000,
		dataType: 'json',
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') {
				dispatch('view', {
					open: false
				});
			}
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) disabled = false;
		},
		onError({ result }) {
			disabled = false;
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	$: $form.items = fulfillmentData;
	$: $form.order_id = orderId;
</script>

{#if $message}
	<div transition:slide>
		<Alert.Root variant="destructive">
			<AlertCircle class="h-4 w-4" />
			<Alert.Title>Error</Alert.Title>
			<Alert.Description>{$message}</Alert.Description>
		</Alert.Root>
	</div>
{/if}

<form action={href} method="POST" use:enhance>
	<input type="hidden" value={$form.order_id} />

	<div class="mt-4 grid gap-6">
		<ul class="grid gap-6">
			{#each $form.items as _, i}
				<li>
					<input type="hidden" value={$form.items[i].id} />

					<div class="grid gap-2">
						<div class="flex">
							<img src={$form.items[i].thumbnail} alt="" width="40px" class="mr-2 rounded-sm" />

							<div class="flex flex-col justify-around">
								<p class="truncate text-sm font-medium">{$form.items[i].title}</p>
								<p class="text-sm font-normal text-muted-foreground">
									{$form.items[i].variant_title}
								</p>
							</div>
						</div>

						<Label for="qty">
							Quantity <span class="font-normal">(max: {$form.items[i].max_quantity})</span>
						</Label>
						<Input
							id="qty"
							type="number"
							step="1"
							min={$form.items.length === 1 ? 1 : 0}
							max={$form.items[i].max_quantity}
							data-invalid={$errors.items?.[i]?.quantity}
							class="rounded-2xl
                  {$errors.items?.[i]?.quantity
								? 'border-destructive focus-visible:ring-destructive'
								: ''}"
							bind:value={$form.items[i].quantity}
							on:focus={() => {
								if ($errors.items?.[i]?.quantity) $errors.items[i].quantity = undefined;
							}}
							on:input={() => {
								if ($errors.items?.[i]?.quantity) $errors.items[i].quantity = undefined;
							}} />

						{#if $errors.items?.[i]?.quantity}
							<p transition:slide class="text-sm font-medium text-destructive">
								{$errors.items?.[i]?.quantity}
							</p>
						{/if}
					</div>
				</li>
			{/each}
		</ul>
	</div>

	<Button {disabled} class="mt-6 w-full rounded-2xl font-semibold" type="submit">
		{#if $delayed}
			<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
		{/if}
		<span>{$delayed ? 'Saving changes...' : 'Complete'}</span>
	</Button>
</form>
