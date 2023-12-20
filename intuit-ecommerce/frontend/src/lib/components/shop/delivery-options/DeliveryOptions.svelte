<script lang="ts">
	import { formatPrice } from '$lib/client/shop';
	import { createRadioGroup, melt } from '@melt-ui/svelte';
	import { Package, Store } from 'lucide-svelte';

	export let shippingTotal: number;

	const {
		elements: { root, item, hiddenInput },
		helpers: { isChecked }
	} = createRadioGroup({
		loop: true,
		orientation: 'vertical',
		defaultValue: 'ship'
	});
</script>

<div use:melt={$root} class="grid gap-2">
	<button
		use:melt={$item('ship')}
		class="w-full rounded-lg border-2 bg-transparent p-4 hover:bg-muted {$isChecked('ship')
			? 'border-ring'
			: 'border-muted'}">
		<div class="flex items-center justify-between text-sm leading-none">
			<div class="flex items-center gap-1">
				<Package size={16} class="mr-2" />
				<p class="font-medium">Standard Delivery</p>
			</div>
			<p class="font-normal text-muted-foreground">
				{formatPrice(shippingTotal)}
			</p>
		</div>
	</button>

	<button
		use:melt={$item('pick-up')}
		class="w-full rounded-lg border-2 bg-transparent p-4 hover:bg-muted {$isChecked('pick-up')
			? 'border-ring'
			: 'border-muted'}">
		<div class="flex items-center justify-between text-sm leading-none">
			<div class="flex items-center gap-1">
				<Store size={16} class="mr-2" />
				<p class="font-medium">Pick-up Location</p>
			</div>
			<p class="font-normal text-muted-foreground">Free</p>
		</div>
	</button>
</div>
