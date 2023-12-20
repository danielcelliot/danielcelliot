<script lang="ts">
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Button } from '$lib/components/ui/button';
	import { createRadioGroup, melt } from '@melt-ui/svelte';
	import { ChevronLeft, ChevronRight } from 'lucide-svelte';
	import { createEventDispatcher } from 'svelte';

	export let uploads: File[];
	export let selected: string | undefined;

	const dispatch = createEventDispatcher<{ prev: boolean; next: boolean }>();

	const {
		elements: { root, item, hiddenInput },
		helpers: { isChecked }
	} = createRadioGroup({
		loop: true,
		orientation: 'horizontal',
		defaultValue: selected
	});

	$: disabled = selected === undefined;
	$: selected = $hiddenInput.value;
</script>

<div id="header" class="flex flex-col space-y-1.5 p-6">
	<h3 class="font-semibold leading-none tracking-tight">Product Thumbnail</h3>
	<p class="text-sm text-muted-foreground">Select an image as your product's thumbnail.</p>
</div>

<div id="content" class="flex-1 space-y-4 overflow-y-auto overscroll-contain px-6 py-0.5">
	<div class="grid gap-2">
		<h4 class="text-xs font-medium text-muted-foreground">Images</h4>

		{#if uploads.length > 0}
			<div use:melt={$root} class="grid grid-cols-3 gap-2">
				{#each uploads as upload}
					<button
						use:melt={$item(upload.name)}
						class="flex justify-center rounded-md border-2 bg-transparent {$isChecked(upload.name)
							? 'border-ring hover:border-ring'
							: 'border-transparent hover:border-border'}">
						<div class="w-[80px] overflow-hidden rounded-sm">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-sm object-cover" src={URL.createObjectURL(upload)} alt="" />
							</AspectRatio>
						</div>
					</button>
				{/each}
			</div>
		{/if}
	</div>
</div>

<div id="footer" class="flex justify-between p-6">
	<Button
		variant="ghost"
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();
			dispatch('prev', true);
		}}>
		<ChevronLeft size={16} strokeWidth={2.75} class="mr-2 transition group-hover:-translate-x-1" />
		Back
	</Button>

	<div class={disabled ? 'cursor-not-allowed' : ''}>
		<Button
			{disabled}
			class="group w-28 rounded-2xl font-semibold"
			on:click={(e) => {
				e.preventDefault();
				dispatch('next', true);
			}}>
			Next
			<ChevronRight
				size={16}
				strokeWidth={2.75}
				class="ml-2 transition group-hover:translate-x-1" />
		</Button>
	</div>
</div>
