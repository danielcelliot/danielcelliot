<script lang="ts">
	import type { SuperValidated } from 'sveltekit-superforms';
	import { optionsSchema, type OptionsSchema } from '$lib/schemas/productWizard';
	import { superForm } from 'sveltekit-superforms/client';
	import { fly, slide } from 'svelte/transition';
	import { createEventDispatcher } from 'svelte';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Button } from '$lib/components/ui/button';
	import { Separator } from '$lib/components/ui/separator';
	import * as Card from '$lib/components/ui/card';
	import { ChevronLeft, ChevronRight, PlusCircle, XCircle } from 'lucide-svelte';

	export let form: SuperValidated<OptionsSchema>;
	export let formData: string[];

	const dispatch = createEventDispatcher<{ prev: string[]; next: string[] }>();

	const {
		form: formStore,
		errors,
		allErrors,
		validate,
		enhance
	} = superForm(form, {
		validators: optionsSchema
	});

	let input: string;
	let inputError: string | undefined;

	$formStore.options = formData;
	$: disabled = $formStore.options.length === 0 || $allErrors.length > 0;
</script>

<Card.Header>
	<Card.Title>Product options</Card.Title>
	<Card.Description>Enter your product options to create your variants.</Card.Description>
</Card.Header>

<Card.Content class="flex-1 space-y-4 overflow-y-auto overscroll-contain">
	<div class="grid gap-2">
		<Label for="opt-title">Option name</Label>
		<div
			id="opt-title"
			class="flex overflow-clip rounded-2xl border shadow-sm focus-within:ring-1
      {inputError
				? 'border-destructive focus-within:ring-destructive'
				: 'border-input focus-within:ring-ring'}">
			<Input
				bind:value={input}
				on:input={() => {
					if (inputError) inputError = undefined;
				}}
				class="rounded-none border-none shadow-none focus-visible:ring-0" />

			<Button
				size="sm"
				variant="outline"
				class="h-9 w-[140px] justify-start rounded-none border-b-0 border-l border-r-0 border-t-0 pl-3 pr-0 font-semibold shadow-none hover:text-green-500"
				on:click={async (e) => {
					e.preventDefault();

					const invalid = await validate('options[0]', {
						value: input,
						update: false
					});

					if (invalid) {
						inputError = invalid[0];
					} else {
						$formStore.options = [...$formStore.options, input];
						input = '';
					}
				}}>
				<PlusCircle size={16} strokeWidth={2.75} class="mr-2" />
				Add
			</Button>
		</div>

		{#if inputError}
			<div transition:slide>
				<p class="text-xs font-medium text-destructive">
					{inputError}
				</p>
			</div>
		{/if}
	</div>

	<Separator />

	<form method="POST" use:enhance class="space-y-4">
		{#each $formStore.options as _, i}
			<div class="grid gap-2">
				<div
					transition:fly
					class="flex overflow-clip rounded-2xl border shadow-sm focus-within:ring-1
            {$errors.options?.[i]
						? 'border-destructive focus-within:ring-destructive'
						: 'border-input focus-within:ring-ring'}">
					<Input
						bind:value={$formStore.options[i]}
						class="rounded-none border-none shadow-none focus-visible:ring-0" />

					<Button
						size="sm"
						variant="outline"
						class="h-9 w-[140px] justify-start rounded-none border-b-0 border-l border-r-0 border-t-0 pl-3 pr-0 font-semibold shadow-none hover:text-destructive"
						on:click={(e) => {
							e.preventDefault();

							// Clear error before deletion
							validate(`options[${i}]`, { value: 'Default' });

							$formStore.options.splice(i, 1);
							$formStore.options = [...$formStore.options];

							// Re-validate remaining options
							$formStore.options.forEach((option, i) => {
								validate(`options[${i}]`, { value: option });
							});
						}}>
						<XCircle size={16} strokeWidth={2.75} class="mr-2" />
						Remove
					</Button>
				</div>

				{#if $errors.options?.[i]}
					<p transition:slide class="text-xs font-medium text-destructive">{$errors.options[i]}</p>
				{/if}
			</div>
		{/each}
	</form>
</Card.Content>

<Card.Footer class="flex justify-between pt-2">
	<Button
		variant="ghost"
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();
			dispatch('prev', $formStore.options);
		}}>
		<ChevronLeft size={16} strokeWidth={2.75} class="mr-2 transition group-hover:-translate-x-1" />
		Back
	</Button>

	<div class={disabled ? 'cursor-not-allowed' : ''}>
		<Button
			class="group w-28 rounded-2xl font-semibold"
			{disabled}
			on:click={(e) => {
				e.preventDefault();
				dispatch('next', $formStore.options);
			}}>
			Next
			<ChevronRight
				size={16}
				strokeWidth={2.75}
				class="ml-2 transition group-hover:translate-x-1" />
		</Button>
	</div>
</Card.Footer>
