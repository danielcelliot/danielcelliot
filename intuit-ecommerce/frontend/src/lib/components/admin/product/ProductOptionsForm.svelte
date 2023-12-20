<script lang="ts">
	import type { ProductOptionsSchema } from '$lib/schemas/product';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { invalidateAll } from '$app/navigation';
	import { createEventDispatcher } from 'svelte';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import Button from '$lib/components/ui/button/button.svelte';
	import Input from '$lib/components/ui/input/input.svelte';
	import Label from '$lib/components/ui/label/label.svelte';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Loader2, Plus, Trash2 } from 'lucide-svelte';

	export let optionsForm: SuperValidated<ProductOptionsSchema>;
	export let optionsData: { option_id?: string; title: string }[];
	export let productId: string;
	export let href: string;

	let disabled = false;
	let errorMessage: string;

	const dispatch = createEventDispatcher();
	const { form, errors, enhance, delayed } = superForm(optionsForm, {
		delayMs: 500,
		timeoutMs: 10000,
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
			errorMessage = result.error.message;
		}
	});

	$form.options = optionsData;
	$form.product_id = productId;

	$: if ($errors.options?._errors && $errors.options._errors.length) {
		errorMessage = $errors.options._errors[0];
	}
</script>

{#if errorMessage}
	<div transition:slide>
		<Alert.Root variant="destructive">
			<AlertCircle class="h-4 w-4" />
			<Alert.Title>Error</Alert.Title>
			<Alert.Description>{errorMessage}</Alert.Description>
		</Alert.Root>
	</div>
{/if}

<form action={href} method="post" use:enhance>
	<input type="hidden" name="product_id" value={$form.product_id} />

	<div class="mt-2 grid gap-2">
		<Label class="text-sm font-medium">Option title</Label>

		<div class="grid gap-2">
			{#each $form.options as _, i}
				<input type="hidden" name="option_id" bind:value={$form.options[i].option_id} />

				<div transition:slide={{ duration: 150 }} class="flex items-center">
					<Input
						bind:value={$form.options[i].title}
						autofocus={$form.options[i].title ? undefined : true}
						name="title"
						type="text"
						class="mr-2 rounded-2xl
              {$errors.options?.[i]?.title
							? 'border-destructive focus-visible:ring-destructive'
							: ''}"
						on:focus={() => {
							if ($errors.options?.[i]?.title) $errors.options[i].title = undefined;
						}}
						on:input={() => {
							if ($errors.options?.[i]?.title) $errors.options[i].title = undefined;
						}} />

					<Button
						{disabled}
						size="icon"
						variant="outline"
						class="h-9 rounded-lg text-muted-foreground"
						on:click={(e) => {
							e.preventDefault();
							if ($errors.options) $errors.options = undefined;
							$form.options.splice(i, 1);
							$form.options = [...$form.options];
						}}>
						<Trash2 class="h-5 w-5" />
					</Button>
				</div>

				{#if $errors.options?.[i]?.title}
					<p transition:slide class="text-sm font-medium text-destructive">
						{$errors.options[i].title}
					</p>
				{/if}
			{/each}

			<Button
				{disabled}
				variant="outline"
				size="sm"
				class="w-full rounded-2xl"
				on:click={(e) => {
					e.preventDefault();
					$form.options = [...$form.options, { title: '' }];
				}}>
				<Plus class="mr-2 h-4 w-4" />
				<span>Add an option</span>
			</Button>
		</div>
	</div>

	<Button {disabled} class="mt-6 w-full rounded-2xl" type="submit">
		{#if $delayed}
			<div transition:slide>
				<Loader2 size={16} class="mr-4 animate-spin" />
			</div>
			<!-- <svg
				transition:slide={{ axis: 'x' }}
				class="mr-4 inline h-4 w-4 animate-spin"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
				stroke-linecap="round"
				stroke-linejoin="round">
				<path d="M21 12a9 9 0 1 1-6.219-8.56" />
			</svg> -->
		{/if}
		<span>{$delayed ? 'Saving changes...' : 'Save changes'}</span>
	</Button>
</form>
