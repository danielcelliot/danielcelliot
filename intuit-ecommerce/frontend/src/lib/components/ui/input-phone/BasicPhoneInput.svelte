<script lang="ts">
	import { TelInput, normalizedCountries } from 'svelte-tel-input';
	import type {
		DetailedValue,
		E164Number,
		CountryCode,
		TelInputOptions
	} from 'svelte-tel-input/types';

	// E164 formatted value, usually you should store and use this.
	export let value: E164Number | null;

	// Selected country
	export let country: CountryCode | null = null;

	// Validity
	export let valid: boolean;

	// Phone number details
	export let detailedValue: DetailedValue | null = null;

	export let options: TelInputOptions;
</script>

<div class="flex">
	<select
		class="form-select m-0
    block
    cursor-pointer
    appearance-none
    rounded-l-lg
    border
    border-gray-300 bg-gray-100 bg-clip-padding
    bg-no-repeat px-3 py-1.5 text-base font-normal text-gray-500 hover:bg-gray-200 focus:border-blue-600 focus:bg-white focus:text-gray-700
    focus:outline-none
    dark:border-gray-600 dark:bg-gray-700 dark:text-white dark:hover:bg-gray-600"
		aria-label="Default select example"
		name="Country"
		bind:value={country}>
		<option value={null} hidden={country !== null}>Please select</option>
		{#each normalizedCountries as currentCountry (currentCountry.id)}
			<option
				value={currentCountry.iso2}
				selected={currentCountry.iso2 === country}
				aria-selected={currentCountry.iso2 === country}>
				{currentCountry.iso2} (+{currentCountry.dialCode})
			</option>
		{/each}
	</select>

	<TelInput
		{options}
		bind:country
		bind:valid
		bind:value
		bind:detailedValue
		class="w-full rounded-r-lg bg-gray-50 px-4 py-1 
        text-gray-900 focus:outline-none dark:bg-gray-700 dark:text-white dark:placeholder-gray-400 {valid
			? 'border border-gray-300 border-l-gray-100 dark:border-gray-600 dark:border-l-gray-700'
			: 'border-2 border-red-600'}" />
</div>
