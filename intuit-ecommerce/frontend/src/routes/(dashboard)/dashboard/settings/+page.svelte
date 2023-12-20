<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import AdvancedPhoneInput from '$lib/components/ui/input-phone/AdvancedPhoneInput.svelte';
	import { ArrowLeft, Loader2 } from 'lucide-svelte';
	import { slide } from 'svelte/transition';
	import type { PageServerData } from './$types';
	import { superForm } from 'sveltekit-superforms/client';
	import type {
		DetailedValue,
		E164Number,
		CountryCode,
		TelInputOptions
	} from 'svelte-tel-input/types';
	import { addToast } from '$lib/components/ui/toast/toaster.svelte';
	import { businessDetailsSchema } from '$lib/schemas/vendor';
	import { afterNavigate } from '$app/navigation';
	import { base } from '$app/paths';

	let previousPage: string = base;

	afterNavigate(({ from }) => {
		previousPage = from?.url.pathname || previousPage;
	});

	export let data: PageServerData;

	const { form, enhance, errors, delayed } = superForm(data.form, {
		dataType: 'json',
		validators: businessDetailsSchema,
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onResult() {
			disabled = false;
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) disabled = false;
			if (form.message) {
				addToast({
					data: {
						title: form.message.type === 'success' ? 'Success' : 'Error',
						description: form.message.text,
						color: form.message.type === 'success' ? 'bg-green-500' : 'bg-bg-red-500'
					}
				});
			}
		},
		onError() {
			disabled = false;
		}
	});

	let disabled: boolean;

	let telValue: E164Number | null;
	let countryCode: CountryCode = 'TT';
	let validTel: boolean;
	let detailedTelValue: DetailedValue | null = null;
	let telOptions: TelInputOptions = {
		autoPlaceholder: true,
		format: 'international',
		invalidateOnCountryChange: true
	};

	if (data.store) {
		$form.business_name = data.store.metadata?.company_name ?? undefined;
		$form.email = data.store.metadata?.email ?? '';
		$form.phone = data.store.metadata?.phone ?? '';
	}

	telValue = $form.phone ?? null;
	$: $form.phone = telValue ?? '';
	$: if ($form.business_name?.length === 0) $form.business_name = undefined;
</script>

<main class="container px-2 min-[380px]:px-4">
	<div class="relative flex items-center justify-center pb-6 pt-4">
		<a href={previousPage} class="absolute left-0">
			<ArrowLeft size={16} class="mr-2" />
		</a>

		<p class="font-semibold">My Store</p>
	</div>

	<form method="post" use:enhance>
		<div class="grid gap-4">
			<div class="grid gap-2">
				<Label for="first_name">Business/Company name</Label>
				<Input
					id="first_name"
					name="first_name"
					type="text"
					aria-invalid={$errors.business_name ? 'true' : undefined}
					bind:value={$form.business_name}
					class="rounded-2xl
              {$errors.business_name ? 'border-destructive focus-visible:ring-destructive' : ''}" />

				{#if $errors.business_name}
					<p transition:slide class="text-xs font-medium text-destructive">
						{$errors.business_name}
					</p>
				{/if}
			</div>

			<div class="grid gap-2">
				<Label for="last_name">
					Business/Company email
					<sup class="text-destructive">*</sup>
				</Label>
				<Input
					id="last_name"
					name="last_name"
					type="text"
					aria-invalid={$errors.email ? 'true' : undefined}
					bind:value={$form.email}
					class="rounded-2xl
              {$errors.email ? 'border-destructive focus-visible:ring-destructive' : ''}" />

				{#if $errors.email}
					<p transition:slide class="text-xs font-medium text-destructive">{$errors.email}</p>
				{/if}
			</div>

			<div class="grid gap-2">
				<Label for="last_name">
					Business/Company phone
					<sup class="text-destructive">*</sup>
				</Label>
				<AdvancedPhoneInput
					bind:selectedCountry={countryCode}
					bind:detailedValue={detailedTelValue}
					bind:value={telValue}
					bind:valid={validTel}
					options={telOptions} />

				{#if $errors.phone}
					<p transition:slide class="text-xs font-medium text-destructive">{$errors.phone}</p>
				{/if}
			</div>

			<div class={disabled ? 'cursor-not-allowed' : ''}>
				<Button {disabled} class="w-full rounded-2xl font-semibold" type="submit">
					{#if $delayed}
						<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
					{/if}
					<span>{$delayed ? 'Saving...' : 'Save changes'}</span>
				</Button>
			</div>
		</div>
	</form>
</main>
