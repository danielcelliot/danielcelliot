<script lang="ts">
	import type { SuperValidated } from 'sveltekit-superforms';
	import type { ProductVariantFormData } from '$lib/types/shop';
	import { updateVariantSchema, type UpdateVariantSchema } from '$lib/schemas/product';
	import { VariantType, type Product } from '$lib/types/medusa';
	import { createEventDispatcher } from 'svelte';
	import { createRadioGroup, createToggleGroup, melt } from '@melt-ui/svelte';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Button } from '$lib/components/ui/button';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import * as Alert from '$lib/components/ui/alert';
	import { invalidateAll } from '$app/navigation';
	import { imask } from '@imask/svelte';

	export let variantForm: SuperValidated<UpdateVariantSchema>;
	export let variantData: ProductVariantFormData;
	export let product: Product;
	export let href: string;

	const dispatch = createEventDispatcher();

	const { form, errors, enhance, message, delayed, constraints } = superForm(variantForm, {
		validators: updateVariantSchema,
		delayMs: 500,
		timeoutMs: 8000,
		dataType: 'json',
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') {
				dispatch('view', {
					show: false
				});

				/* By default, re-running the load function with invalidateAll() immediately after a successful form
          submission causes MedusaJS to respond with stale data. A timeout is required to resolve this issue. */
				setTimeout(() => invalidateAll(), 2000);
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

	const {
		elements: { root, item, hiddenInput },
		helpers: { isChecked }
	} = createRadioGroup({
		loop: false,
		orientation: 'horizontal',
		defaultValue: variantData.thumbnail ?? undefined
	});

	const {
		elements: { root: toggleRoot, item: toggleItem },
		helpers: { isPressed },
		states: { value: selectedImages }
	} = createToggleGroup({
		type: 'multiple',
		loop: true,
		defaultValue: variantData.images
	});

	let disabled: boolean;

	$form = {
		product_id: product.id,
		variant_id: variantData.variant_id,
		title: variantData.title,
		options: variantData.options,
		price: variantData.price,
		inventory_quantity: variantData.inventory_quantity,
		thumbnail: $hiddenInput.value,
		images: Array.isArray($selectedImages) ? $selectedImages : undefined
	};

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

	let moneyValue = $form.price;

	function accept({ detail: maskRef }) {
		moneyValue = maskRef.value;
		$form.price = maskRef.unmaskedValue;
	}

	$: $form.thumbnail = $hiddenInput.value;
	$: $form.images = Array.isArray($selectedImages) ? $selectedImages : undefined;

	$: if ($form.options && product.variant_type === VariantType.MULTI) {
		const values = $form.options.map((o) => o.value);
		$form.title = values.join(' / ');
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
		{#if $form.options && product.variant_type === VariantType.MULTI}
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

		{#if product.variant_type === VariantType.MULTI}
			<div class="grid w-full max-w-sm items-center gap-2">
				<Label for="title" class="text-muted-foreground">Variant title</Label>
				<Input disabled id="title" type="text" class="rounded-2xl" value={$form.title} />
			</div>
		{/if}

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

		{#if product.images.length}
			<div class="grid gap-2">
				<Label for="thumbnail">Select thumbnail</Label>
				<div
					id="thumbnail"
					use:melt={$root}
					class="no-scrollbar no-scrollbar::-webkit-scrollbar flex snap-x snap-mandatory justify-start gap-3 overflow-auto">
					{#each product.images as image}
						<button
							use:melt={$item(image.url)}
							class="flex snap-start justify-center rounded-xl border-2 bg-transparent {$isChecked(
								image.url
							)
								? 'border-ring hover:border-ring'
								: 'border-transparent hover:border-border'}">
							<div class="w-[80px] overflow-hidden rounded-lg">
								<AspectRatio ratio={3 / 4} class="flex items-center">
									<img class="rounded-lg object-cover" src={image.url} alt="" />
								</AspectRatio>
							</div>
						</button>
					{/each}
				</div>
			</div>

			<div class="grid gap-2">
				<Label for="images">Select images</Label>
				<div id="images" use:melt={$toggleRoot} class="grid grid-cols-3 gap-2">
					{#each product.images as image}
						<button
							use:melt={$toggleItem(image.url)}
							value={image.url}
							class="flex justify-center rounded-xl border-2 bg-transparent {$isPressed(image.url)
								? 'border-ring hover:border-ring'
								: 'border-transparent hover:border-border'}">
							<div class="w-[80px] overflow-hidden rounded-lg">
								<AspectRatio ratio={3 / 4} class="flex items-center">
									<img class="rounded-lg object-cover" src={image.url} alt="" />
								</AspectRatio>
							</div>
						</button>
					{/each}
				</div>
			</div>
		{/if}

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

<style>
	/* Hide scrollbar for Chrome, Safari and Opera */
	.no-scrollbar::-webkit-scrollbar {
		display: none;
	}

	/* Hide scrollbar for IE, Edge and Firefox */
	.no-scrollbar {
		-ms-overflow-style: none; /* IE and Edge */
		scrollbar-width: none; /* Firefox */
	}
</style>
