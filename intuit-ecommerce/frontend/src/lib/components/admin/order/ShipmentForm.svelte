<script lang="ts">
	import type { ShipItemsSchema } from '$lib/schemas/order';
	import { createEventDispatcher } from 'svelte';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { superForm } from 'sveltekit-superforms/client';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { slide } from 'svelte/transition';
	import Button from '$lib/components/ui/button/button.svelte';
	import Checkbox from '$lib/components/ui/checkbox/checkbox.svelte';
	import Label from '$lib/components/ui/label/label.svelte';
	import Input from '$lib/components/ui/input/input.svelte';

	export let shipmentForm: SuperValidated<ShipItemsSchema>;
	export let orderId: string;
	export let fulfillmentId: string;
	export let href: string;

	let disabled = false;
	let showTrackingNumInput = false;

	const dispatch = createEventDispatcher();

	const { enhance, message, delayed } = superForm(shipmentForm, {
		delayMs: 500,
		timeoutMs: 8000,
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

<form action={href} method="post" use:enhance>
	<input type="hidden" name="order_id" value={orderId} required />
	<input type="hidden" name="fulfillment_id" value={fulfillmentId} required />

	<div class="grid gap-4">
		<div class="flex items-center space-x-2">
			<Checkbox id="check" bind:checked={showTrackingNumInput} class="rounded" />
			<Label
				for="check"
				class="text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-70">
				Include tracking number
			</Label>
		</div>

		{#if showTrackingNumInput}
			<div class="grid gap-2" transition:slide>
				<Label for="tracking">Tracking number</Label>
				<Input id="tracking" name="tracking_number" class="rounded-2xl" autofocus />
			</div>
		{/if}
	</div>

	<Button {disabled} class="mt-6 w-full rounded-2xl font-semibold" type="submit">
		{#if $delayed}
			<div transition:slide={{ axis: 'x' }}>
				<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
			</div>
		{/if}
		<span>{$delayed ? 'Saving changes...' : 'Complete'}</span>
	</Button>
</form>
