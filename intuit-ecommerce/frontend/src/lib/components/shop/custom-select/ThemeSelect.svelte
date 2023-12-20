<script lang="ts">
	import { flyAndScale } from '$lib/utils/ui';
	import { createSelect, melt } from '@melt-ui/svelte';
	import { CaretSort, Check } from 'radix-icons-svelte';
	import { scale } from 'svelte/transition';
	import { setMode, mode } from 'mode-watcher';
	import { Moon, Sun, SunMoon } from 'lucide-svelte';

	export let label: string;

	const themes: { label: string; value: 'dark' | 'light' | 'system' }[] = [
		{
			label: 'System',
			value: 'system'
		},
		{
			label: 'Light',
			value: 'light'
		},
		{
			label: 'Dark',
			value: 'dark'
		}
	];

	let defaultSelected: { value: string; label: string } = getDefaultTheme();

	const {
		elements: { trigger, menu, option: selectOption },
		states: { selectedLabel, open, selected },
		helpers: { isSelected }
	} = createSelect({
		defaultSelected: defaultSelected ?? undefined,
		preventScroll: true,
		forceVisible: true,
		positioning: {
			placement: 'bottom',
			fitViewport: false,
			sameWidth: true
		}
	});

	function getDefaultTheme() {
		switch ($mode) {
			case 'light':
				return { value: 'light', label: 'Light' };
			case 'dark':
				return { value: 'dark', label: 'Dark' };
			default:
				return { value: 'system', label: 'System' };
		}
	}

	function setTheme(value: string) {
		switch (value) {
			case 'light':
				setMode('light');
				break;
			case 'dark':
				setMode('dark');
				break;
			case 'system':
				setMode('system');
				break;
		}
	}

	$: if ($selected) setTheme($selected.value);
</script>

<button
	id={label}
	use:melt={$trigger}
	on:click={(e) => e.preventDefault()}
	class="flex h-9 w-[180px] items-center justify-between rounded-2xl border border-foreground/60 bg-transparent px-3 py-2 text-sm shadow-sm
    ring-offset-background placeholder:text-muted-foreground
    focus:outline-none focus:ring-1 focus:ring-ring disabled:cursor-not-allowed disabled:opacity-50
    aria-expanded:pointer-events-none aria-expanded:focus:ring-0">
	<div class="inline-flex items-center">
		{#if $selectedLabel.toLowerCase() === 'light'}
			<Sun size={16} class="mr-3" />
		{:else if $selectedLabel.toLowerCase() === 'dark'}
			<Moon size={16} class="mr-3" />
		{:else if $selectedLabel.toLowerCase() === 'system'}
			<SunMoon size={16} class="mr-3" />
		{/if}
		{$selectedLabel}
	</div>
	<CaretSort class="h-4 w-4 opacity-50" />
</button>

{#if $open}
	<div
		use:melt={$menu}
		in:flyAndScale
		out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
		class="relative z-50 min-w-[8rem] overflow-hidden rounded-2xl border bg-popover text-popover-foreground shadow-md focus:outline-none">
		<div class="w-full p-1">
			{#each themes as theme}
				<div
					use:melt={$selectOption({
						value: theme.value,
						label: theme.label
					})}
					class="relative flex w-full cursor-default select-none items-center rounded-xl py-1.5 pl-2 pr-8 text-sm outline-none data-[disabled]:pointer-events-none data-[highlighted]:bg-accent data-[highlighted]:text-accent-foreground data-[disabled]:opacity-50">
					<div class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
						{#if $isSelected(theme.value)}
							<Check class="h-4 w-4" />
						{/if}
					</div>
					{#if theme.value === 'light'}
						<Sun size={16} class="mr-3" />
					{:else if theme.value === 'dark'}
						<Moon size={16} class="mr-3" />
					{:else if theme.value === 'system'}
						<SunMoon size={16} class="mr-3" />
					{/if}
					{theme.label}
				</div>
			{/each}
		</div>
	</div>
{/if}
