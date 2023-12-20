<script lang="ts">
	import type { SuperValidated } from 'sveltekit-superforms';
	import { createVariantSchema, type CreateVariantSchema } from '$lib/schemas/product';
	import { createEventDispatcher } from 'svelte';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import * as Alert from '$lib/components/ui/alert';
	import type { ProductOption } from '$lib/types/medusa';
	import { imask } from '@imask/svelte';

	export let variantForm: SuperValidated<CreateVariantSchema>;
	export let productId: string;
	export let options: ProductOption[] = [];
	export let href: string;

	let disabled = false;

	const dispatch = createEventDispatcher();

	const { form, errors, enhance, message, delayed, constraints } = superForm(variantForm, {
		validators: createVariantSchema,
		delayMs: 500,
		timeoutMs: 8000,
		dataType: 'json',
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') {
				dispatch('view', {
					show: false
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

	const maskOptions = {
		mask: '$num',
		blocks: {
			num: {
				mask: Number,
				scale: 2,
				thousandsSeparator: ',',
				padFractionalZeros: true,
				normalizeZeros: true,
				radix: '.',
				mapToRadix: ['.'],
				min: 0,
				max: 5000000
			}
		}
	};

	let moneyValue = '';

	function accept({ detail: maskRef }) {
		moneyValue = maskRef.value;
		$form.price = maskRef.unmaskedValue;
	}

	$form.product_id = productId;
	$form.options = options.map((o) => {
		return {
			option_id: o.id,
			title: o.title,
			value: ''
		};
	});

	$: if ($form.options) {
		const values = $form.options.map((o) => o.value);
		$form.title = $form.options.length > 1 ? values.join(' / ') : $form.options[0].value;
	}
</script>

{#if $message}
	<div transition:slide>
		<Alert.Root variant="destructive">
			<AlertCircle class="h-4 w-4" />
			<Alert.Title>Error</Alert.Title>
			<Alert.Description>{$message.text}</Alert.Description>
		</Alert.Root>
	</div>
{/if}

<form action={href} method="post" use:enhance>
	<div class="mt-2 grid gap-6">
		{#if $form.options}
			{#each $form.options as _, i}
				<div class="grid w-full max-w-sm items-center gap-2">
					<Label for="opt-title">
						{$form.options[i].title}
						<sup class="text-destructive">*</sup>
					</Label>
					<Input
						id="opt-title"
						type="text"
						aria-invalid={$errors.options?.[i]?.value ? 'true' : undefined}
						class="rounded-2xl
            {$errors.options?.[i]?.value
							? 'border-destructive focus-visible:ring-destructive'
							: ''}"
						bind:value={$form.options[i].value} />

					{#if $errors.options?.[i]?.value}
						<p transition:slide class="text-xs font-medium text-destructive">
							{$errors.options[i].value}
						</p>
					{/if}
				</div>
			{/each}
		{/if}

		<div class="grid w-full max-w-sm items-center gap-2">
			<Label for="title" class="text-muted-foreground">Variant title</Label>
			<Input disabled id="title" type="text" class="rounded-2xl" value={$form.title} />
		</div>

		<div class="grid w-full max-w-sm items-center gap-2">
			<Label for="price">
				Price
				<sup class="text-destructive">*</sup>
			</Label>
			<input
				id="price"
				value={moneyValue}
				use:imask={maskOptions}
				on:accept={accept}
				class="flex h-9 w-full rounded-2xl border bg-background px-3 py-1 text-sm shadow-sm
          transition-colors placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1
          disabled:cursor-not-allowed disabled:opacity-50
          {$errors.price
					? 'border-destructive focus-visible:ring-destructive'
					: 'border-input focus-visible:ring-ring'}" />

			{#if $errors.price}
				<p transition:slide class="text-xs font-medium text-destructive">
					{$errors.price[0]}
				</p>
			{/if}
		</div>

		<div class="grid w-full max-w-sm items-center gap-2">
			<Label for="qty">
				Quantity in stock
				<sup class="text-destructive">*</sup>
			</Label>
			<Input
				id="qty"
				type="number"
				step="1"
				aria-invalid={$errors.inventory_quantity ? 'true' : undefined}
				{...$constraints.inventory_quantity}
				class="rounded-2xl
        {$errors.inventory_quantity ? 'border-destructive focus-visible:ring-destructive' : ''}"
				bind:value={$form.inventory_quantity} />

			{#if $errors.inventory_quantity}
				<p transition:slide class="text-xs font-medium text-destructive">
					{$errors.inventory_quantity[0]}
				</p>
			{/if}
		</div>

		<div class={disabled ? 'cursor-not-allowed' : ''}>
			<Button {disabled} class="w-full rounded-2xl font-semibold" type="submit">
				{#if $delayed}
					<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
				{/if}
				<span>{$delayed ? 'Saving changes...' : 'Save changes'}</span>
			</Button>
		</div>
	</div>
</form>
