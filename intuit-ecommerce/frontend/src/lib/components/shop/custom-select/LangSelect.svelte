<script lang="ts">
	import { flyAndScale } from '$lib/utils/ui';
	import { createSelect, melt } from '@melt-ui/svelte';
	import { CaretSort, Check } from 'radix-icons-svelte';
	import { scale } from 'svelte/transition';

	let languages = [
		{
			label: 'English',
			value: 'eng'
		},
		{
			label: 'Espanol',
			value: 'esp'
		}
	];

	export let label: string;

	const {
		elements: { trigger, menu, option: selectOption, group, groupLabel },
		states: { selectedLabel, open, selected },
		helpers: { isSelected }
	} = createSelect({
		defaultSelected: {
			value: languages[0].value,
			label: languages[0].label
		},
		preventScroll: true,
		forceVisible: true,
		positioning: {
			placement: 'bottom',
			fitViewport: false,
			sameWidth: true
		}
	});
</script>

<button
	id={label}
	use:melt={$trigger}
	on:click={(e) => e.preventDefault()}
	class="col-span-2 flex h-9 w-full items-center justify-between rounded-2xl border border-input bg-transparent px-3 py-2 text-sm shadow-sm
    ring-offset-background placeholder:text-muted-foreground
    focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50
    aria-expanded:pointer-events-none aria-expanded:focus:ring-0">
	{$selectedLabel}
	<CaretSort class="h-4 w-4 opacity-50" />
</button>

{#if $open}
	<div
		use:melt={$menu}
		in:flyAndScale
		out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
		class="relative z-50 min-w-[8rem] overflow-hidden rounded-2xl border bg-popover text-popover-foreground shadow-md focus:outline-none">
		<div class="w-full p-1">
			{#each languages as lang}
				<div
					use:melt={$selectOption({
						value: lang.value,
						label: lang.label
					})}
					class="relative flex w-full cursor-default select-none items-center rounded-xl py-1.5 pl-2 pr-8 text-sm outline-none data-[disabled]:pointer-events-none data-[highlighted]:bg-accent data-[highlighted]:text-accent-foreground data-[disabled]:opacity-50">
					<div class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
						{#if $isSelected(lang.value)}
							<Check class="h-4 w-4" />
						{/if}
					</div>
					{lang.label}
				</div>
			{/each}
		</div>
	</div>
{/if}
