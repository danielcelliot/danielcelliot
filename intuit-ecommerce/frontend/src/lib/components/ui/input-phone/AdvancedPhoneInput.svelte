<script lang="ts">
	import { createEventDispatcher } from 'svelte';
	import { clickOutsideAction } from 'svelte-tel-input/utils';
	import { TelInput, isSelected, normalizedCountries } from 'svelte-tel-input';
	import type {
		DetailedValue,
		CountrySelectEvents,
		CountryCode,
		E164Number,
		TelInputOptions,
		Country
	} from 'svelte-tel-input/types';
	import 'svelte-tel-input/styles/flags.css';
	import { ChevronDown } from 'lucide-svelte';
	import { flyAndScale } from '$lib/utils/ui';
	import { scale } from 'svelte/transition';

	export let clickOutside = true;
	export let closeOnClick = true;
	export let disabled = false;
	export let detailedValue: DetailedValue | null = null;
	export let value: E164Number | null;
	export let searchPlaceholder: string | null = 'Search';
	export let selectedCountry: CountryCode | null;
	export let valid: boolean;
	export let options: TelInputOptions;
	let searchText = '';
	let isOpen = false;

	$: selectedCountryDialCode =
		normalizedCountries.find((el) => el.iso2 === selectedCountry)?.dialCode || null;

	const toggleDropDown = (e?: Event) => {
		e?.preventDefault();
		if (disabled) return;
		isOpen = !isOpen;
	};

	const closeDropdown = (e?: Event) => {
		if (isOpen) {
			e?.preventDefault();
			isOpen = false;
			searchText = '';
		}
	};

	const selectClick = () => {
		if (closeOnClick) closeDropdown();
	};

	const closeOnClickOutside = () => {
		if (clickOutside) {
			closeDropdown();
		}
	};

	const sortCountries = (countries: Country[], text: string) => {
		const normalizedText = text.trim().toLowerCase();
		if (!normalizedText) {
			return countries.sort((a, b) => a.label.localeCompare(b.label));
		}
		return countries.sort((a, b) => {
			const aNameLower = a.name.toLowerCase();
			const bNameLower = b.name.toLowerCase();
			const aStartsWith = aNameLower.startsWith(normalizedText);
			const bStartsWith = bNameLower.startsWith(normalizedText);
			if (aStartsWith && !bStartsWith) return -1;
			if (!aStartsWith && bStartsWith) return 1;
			const aIndex = aNameLower.indexOf(normalizedText);
			const bIndex = bNameLower.indexOf(normalizedText);
			if (aIndex === -1 && bIndex === -1) return a.id.localeCompare(b.id);
			if (aIndex === -1) return 1;
			if (bIndex === -1) return -1;
			const aWeight = aIndex + (aStartsWith ? 0 : 1);
			const bWeight = bIndex + (bStartsWith ? 0 : 1);
			return aWeight - bWeight;
		});
	};

	const handleSelect = (val: CountryCode, e?: Event) => {
		if (disabled) return;
		e?.preventDefault();
		if (
			selectedCountry === undefined ||
			selectedCountry === null ||
			(typeof selectedCountry === typeof val && selectedCountry !== val)
		) {
			selectedCountry = val;
			onChange(val);
			selectClick();
		} else {
			dispatch('same', { option: val });
			selectClick();
		}
	};

	const dispatch = createEventDispatcher<CountrySelectEvents<CountryCode>>();

	const onChange = (selectedCountry: CountryCode) => {
		dispatch('change', { option: selectedCountry });
	};
</script>

<div
	class="relative flex h-9 rounded-2xl border shadow-sm focus-within:ring-1 {valid
		? 'border-input focus-within:ring-ring'
		: 'border-destructive focus-within:ring-destructive'}">
	<div class="flex" use:clickOutsideAction={closeOnClickOutside}>
		<button
			id="states-button"
			data-dropdown-toggle="dropdown-states"
			class="relative z-10 inline-flex flex-shrink-0 items-center overflow-hidden whitespace-nowrap rounded-l-2xl bg-background px-4 py-2.5 text-center text-sm font-medium text-muted-foreground
        hover:bg-foreground/5 focus:outline-none"
			type="button"
			role="combobox"
			aria-controls="dropdown-countries"
			aria-expanded="false"
			aria-haspopup="false"
			on:click={toggleDropDown}>
			{#if selectedCountry && selectedCountry !== null}
				<div class="inline-flex items-center text-left">
					<span class="flag flag-{selectedCountry.toLowerCase()} mr-3 flex-shrink-0" />
					{#if options.format === 'national'}
						<span class=" text-gray-600 dark:text-gray-400">+{selectedCountryDialCode}</span>
					{/if}
				</div>
			{:else}
				Please select
			{/if}
			<ChevronDown
				strokeWidth={2}
				class="ml-1 h-4 w-4 transition-transform duration-200 {isOpen ? 'rotate-180' : ''}" />
		</button>

		{#if isOpen}
			<div
				in:flyAndScale
				out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
				id="dropdown-countries"
				class="absolute z-10 max-w-fit translate-y-11 divide-y divide-gray-100 overflow-hidden rounded-lg border bg-popover shadow-md"
				data-popper-reference-hidden=""
				data-popper-escaped=""
				data-popper-placement="bottom"
				aria-orientation="vertical"
				aria-labelledby="country-button"
				tabindex="-1">
				<div
					class="max-h-48 overflow-y-auto text-sm text-foreground"
					aria-labelledby="countries-button"
					role="listbox">
					<input
						aria-autocomplete="list"
						type="text"
						class="sticky top-0 w-full border border-l-0 border-r-0 border-t-0 bg-background px-4 py-2 text-foreground placeholder:text-muted-foreground focus:outline-none"
						bind:value={searchText}
						placeholder={searchPlaceholder} />
					{#each sortCountries(normalizedCountries, searchText) as country (country.id)}
						{@const isActive = isSelected(country.iso2, selectedCountry)}
						<div id="country-{country.iso2}" role="option" aria-selected={isActive}>
							<button
								value={country.iso2}
								type="button"
								class="inline-flex w-full overflow-hidden px-4 py-2 text-sm hover:bg-muted
                             active:bg-gray-800
                            {isActive ? 'bg-foreground/5 text-primary' : ''}"
								on:click={(e) => {
									handleSelect(country.iso2, e);
								}}>
								<div class="inline-flex items-center text-left">
									<span class="flag flag-{country.iso2.toLowerCase()} mr-3 flex-shrink-0" />
									<span class="mr-2">{country.name}</span>
									<span class="text-muted-foreground">+{country.dialCode}</span>
								</div>
							</button>
						</div>
					{/each}
				</div>
			</div>
		{/if}
	</div>

	<TelInput
		id="phone"
		name="phone"
		bind:country={selectedCountry}
		bind:detailedValue
		bind:value
		bind:valid
		{options}
		class="block w-full rounded-r-2xl bg-background p-2.5 text-sm text-foreground placeholder:text-muted-foreground focus:outline-none" />
</div>
