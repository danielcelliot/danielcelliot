<script lang="ts">
	import { imask } from '@imask/svelte';

	const maskOptions = {
		mask: '$num{.}`cents',
		blocks: {
			num: {
				mask: Number,
				signed: true,
				scale: 0,
				thousandsSeparator: ','
			},
			cents: {
				mask: '`0`0',
				normalizeZeros: true,
				padFractionalZeros: true
			}
		},
		overwrite: true
	};

	export let moneyValue = '';

	function accept({ detail: maskRef }) {
		console.log('accept', maskRef.value);
		console.log('accept', maskRef.unmaskedValue);
		moneyValue = maskRef.value;
	}

	function complete({ detail: maskRef }) {
		console.log('complete', maskRef.unmaskedValue);
	}
</script>

<input
	value={moneyValue}
	use:imask={maskOptions}
	on:accept={accept}
	on:complete={complete}
	class="flex h-9 w-full rounded-md border border-input bg-background px-3 py-1 text-sm shadow-sm
    transition-colors placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1
    focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50" />
