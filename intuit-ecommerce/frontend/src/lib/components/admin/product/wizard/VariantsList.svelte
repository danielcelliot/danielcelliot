<script lang="ts">
	import type { SuperValidated } from 'sveltekit-superforms';
	import { variantsSchema, type VariantsSchema } from '$lib/schemas/productWizard';
	import { VariantType } from '$lib/types/medusa';
	import { superForm } from 'sveltekit-superforms/client';
	import { afterUpdate, beforeUpdate, createEventDispatcher, onDestroy, onMount } from 'svelte';
	import { fly, slide } from 'svelte/transition';
	import { Label } from '$lib/components/ui/label';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import * as Alert from '$lib/components/ui/alert';
	import * as Card from '$lib/components/ui/card';
	import { AlertCircle, ChevronLeft, ChevronRight, PlusCircle } from 'lucide-svelte';
	import { IMask } from '@imask/svelte';
	import type { InputMask } from 'imask/esm/index';

	export let form: SuperValidated<VariantsSchema>;
	export let list: Variant[];
	export let options: string[];
	export let variantType: VariantType;

	// TODO: Infer type from Zod schema
	type Variant = {
		title: string;
		options: {
			title?: string;
			value: string;
		}[];
		inventory_quantity: number;
		price: number;
	};

	const dispatch = createEventDispatcher<{
		prev: Variant[];
		next: Variant[];
	}>();

	const {
		form: formStore,
		errors,
		allErrors,
		validate,
		enhance
	} = superForm(form, {
		dataType: 'json',
		validators: variantsSchema,
		validationMethod: variantType === VariantType.MULTI ? 'submit-only' : 'auto'
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

	let moneyValue: number;

	function initInput() {
		if (variantType === VariantType.MULTI) {
			$formStore.variants = [
				{
					title: '',
					price: 1.0,
					inventory_quantity: 1,
					options: options.map((o) => {
						return {
							title: o,
							value: ''
						};
					})
				}
			];
		} else {
			$formStore.variants = list;
		}

		maskinput.value = $formStore.variants[0].price.toString();
	}

	async function validateInput(input: Variant) {
		const invalidPrice = await validate('variants[0].price', {
			value: input.price,
			update: 'errors'
		});
		const invalidQty = await validate('variants[0].inventory_quantity', {
			value: input.inventory_quantity,
			update: 'errors'
		});
		const invalidOptions = await Promise.all(
			input.options.map(async (option, i) =>
				validate(`variants[0].options[${i}].value`, { value: option.value, update: 'errors' })
			)
		);

		if (invalidPrice || invalidQty || invalidOptions.some((error) => error !== undefined))
			return false;

		return true;
	}

	function addVariant(variant: Variant) {
		const duplicate = list.some((i) => i.title === variant.title);
		if (duplicate) {
			errorMessage = 'This variant has already been added.';
		} else {
			list = [...list, variant];
			initInput();
		}
	}

	let disabled: boolean;
	let errorMessage: string | undefined;
	let autoscroll = false;
	let div: HTMLDivElement;
	let moneyInput: HTMLInputElement;
	let maskinput: InputMask<{
		mask: string;
		blocks: {
			num: {
				mask: NumberConstructor;
				scale: number;
				thousandsSeparator: string;
				padFractionalZeros: boolean;
				normalizeZeros: boolean;
				radix: string;
				mapToRadix: string[];
				min: number;
				max: number;
			};
		};
	}>;

	beforeUpdate(() => {
		if (div) {
			const scrollableDistance = div.scrollHeight - div.offsetHeight;
			autoscroll = div.scrollTop > scrollableDistance - 20;
		}
	});

	afterUpdate(() => {
		if (div && autoscroll) div.scrollTo({ left: 0, top: div.scrollHeight, behavior: 'smooth' });
	});

	onMount(() => {
		maskinput = IMask(moneyInput, maskOptions);
		initInput();
	});

	onDestroy(() => {
		maskinput.destroy();
	});

	$: if ($formStore.variants?.[0] && variantType === VariantType.MULTI) {
		const values = $formStore.variants[0].options.map((o) => o.value);
		$formStore.variants[0].title = values.join(' / ');
	}

	$: disabled = variantType === VariantType.MULTI ? list.length < 1 : $allErrors.length > 0;
</script>

<Card.Header>
	<Card.Title>
		{variantType === VariantType.MULTI ? 'Product variants' : 'Product details'}
	</Card.Title>
	<Card.Description>
		{variantType === VariantType.MULTI
			? 'Create variants for your product and fill out the details.'
			: 'Fill out the details for your product.'}
	</Card.Description>
</Card.Header>

<div bind:this={div} class="flex-1 overflow-y-auto overscroll-contain">
	<form method="POST" use:enhance>
		<Card.Content class="space-y-4">
			{#if variantType === VariantType.MULTI}
				{#each $formStore.variants[0].options as _, i}
					<div class="grid gap-2">
						<Label for="opt-{i}">
							{$formStore.variants[0].options[i].title}
							<sup class="text-destructive">*</sup>
						</Label>
						<Input
							bind:value={$formStore.variants[0].options[i].value}
							on:input={() => {
								if ($errors.variants?.[0]?.options?.[i]?.value)
									$errors.variants[0].options[i].value = undefined;
							}}
							id="opt-{i}"
							type="text"
							class="rounded-2xl
              {$errors.variants?.[0]?.options?.[i]?.value
								? 'border-destructive focus-visible:ring-destructive'
								: ''}" />

						{#if $errors.variants?.[0]?.options?.[i]?.value}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.variants[0].options[i].value}
							</p>
						{/if}
					</div>
				{/each}
			{/if}

			<div class="grid gap-2">
				<Label for="title" class="text-muted-foreground">Variant title</Label>
				<Input
					disabled
					value={$formStore.variants[0].title}
					id="title"
					type="text"
					class="rounded-2xl" />
			</div>

			<div class="grid gap-2">
				<Label for="price">
					Price
					<sup class="text-destructive">*</sup>
				</Label>
				<input
					bind:this={moneyInput}
					on:input={() => {
						if ($errors.variants?.[0]?.price && variantType === VariantType.MULTI)
							$errors.variants[0].price = undefined;
						$formStore.variants[0].price = Number(maskinput.unmaskedValue);
					}}
					on:change={() => ($formStore.variants[0].price = Number(maskinput.unmaskedValue))}
					id="price"
					value={moneyValue}
					class="flex h-9 w-full rounded-2xl border bg-background px-3 py-1 text-sm shadow-sm
            transition-colors placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1
            disabled:cursor-not-allowed disabled:opacity-50
            {$errors.variants?.[0]?.price
						? 'border-destructive focus-visible:ring-destructive'
						: 'border-input focus-visible:ring-ring'}" />

				{#if $errors.variants?.[0]?.price}
					<p transition:slide class="text-xs font-medium text-destructive">
						{$errors.variants[0].price[0]}
					</p>
				{/if}
			</div>

			<div class="grid gap-2">
				<Label for="qty">
					Quantity
					<sup class="text-destructive">*</sup>
				</Label>
				<Input
					id="qty"
					type="number"
					step="1"
					min="1"
					class="rounded-2xl
              {$errors.variants?.[0]?.inventory_quantity
						? 'border-destructive focus-visible:ring-destructive'
						: ''}"
					bind:value={$formStore.variants[0].inventory_quantity}
					on:input={() => {
						if ($errors.variants?.[0]?.inventory_quantity)
							$errors.variants[0].inventory_quantity = undefined;
					}} />

				{#if $errors.variants?.[0]?.inventory_quantity}
					<p transition:slide class="text-xs font-medium text-destructive">
						{$errors.variants[0].inventory_quantity[0]}
					</p>
				{/if}
			</div>

			{#if variantType === VariantType.MULTI}
				{#if errorMessage}
					<div transition:slide>
						<Alert.Root variant="destructive">
							<Alert.Description class="flex text-xs">
								<AlertCircle class="mr-2 h-4 w-4" />
								{errorMessage}
							</Alert.Description>
						</Alert.Root>
					</div>
				{/if}

				<Button
					variant="outline"
					size="sm"
					class="mt-6 w-full rounded-2xl font-semibold hover:text-green-500"
					on:click={async (e) => {
						e.preventDefault();
						if (errorMessage) errorMessage = undefined;

						if ($formStore.variants?.[0]) {
							const valid = await validateInput($formStore.variants[0]);
							if (valid) addVariant($formStore.variants[0]);
						}
					}}>
					<PlusCircle size={16} strokeWidth={2.75} class="mr-2" />
					Add variant
				</Button>
			{/if}

			{#if list.length && variantType === VariantType.MULTI}
				<div>
					<p class="text-xs font-medium leading-none text-muted-foreground">
						Saved variants ({list.length})
					</p>

					<div class="grid divide-y" transition:slide>
						{#each list as _, i}
							<div transition:fly class="flex flex-col pt-2 text-xs">
								<div class="flex justify-between">
									<p class="col-span-2 truncate font-semibold">{list[i].title}</p>
									<p class="pr-3">
										{new Intl.NumberFormat('en-US', {
											style: 'currency',
											currency: 'usd',
											minimumFractionDigits: 2
										}).format(list[i].price)}
									</p>
								</div>

								<div class="flex items-center justify-between">
									<p class="font-medium">
										<span class="text-muted-foreground">Qty:</span>
										{list[i].inventory_quantity}
									</p>

									<Button
										class="text-muted-foreground"
										variant="link"
										size="sm"
										on:click={(e) => {
											e.preventDefault();

											list.splice(i, 1);
											list = [...list];
										}}>
										Remove
									</Button>
								</div>
							</div>
						{/each}
					</div>
				</div>
			{/if}
		</Card.Content>
	</form>
</div>

<Card.Footer class="flex justify-between pt-2">
	<Button
		variant="ghost"
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();

			if (variantType === VariantType.SINGLE) {
				dispatch('prev', $formStore.variants);
			} else {
				dispatch('prev', list);
			}
		}}>
		<ChevronLeft size={16} strokeWidth={2.75} class="mr-2 transition group-hover:-translate-x-1" />
		Back
	</Button>

	<div class={disabled ? 'cursor-not-allowed' : ''}>
		<Button
			class="group w-28 rounded-2xl font-semibold"
			{disabled}
			on:click={async (e) => {
				e.preventDefault();

				if (variantType === VariantType.SINGLE) {
					const valid = await validateInput($formStore.variants[0]);
					if (valid) dispatch('next', $formStore.variants);
				} else {
					dispatch('next', list);
				}
			}}>
			Next
			<ChevronRight
				size={16}
				strokeWidth={2.75}
				class="ml-2 transition group-hover:translate-x-1" />
		</Button>
	</div>
</Card.Footer>
