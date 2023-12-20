<script lang="ts" context="module">
	export type ToastData = {
		title: string;
		description: string;
		color: string;
	};

	const {
		elements: { content, title, description, close },
		helpers,
		states: { toasts },
		actions: { portal }
	} = createToaster<ToastData>();

	export const addToast = helpers.addToast;
</script>

<script lang="ts">
	import { createToaster, createProgress, melt } from '@melt-ui/svelte';
	import { flip } from 'svelte/animate';
	import { fly } from 'svelte/transition';
	import { X } from 'lucide-svelte';
</script>

<div class="fixed bottom-24 right-0 z-50 m-4 flex flex-col items-end gap-2" use:portal>
	{#each $toasts as { id, data } (id)}
		<div
			use:melt={$content(id)}
			animate:flip={{ duration: 500 }}
			in:fly={{ duration: 150, x: '100%' }}
			out:fly={{ duration: 150, x: '100%' }}
			class="relative rounded-lg border bg-card text-card-foreground shadow-md">
			<!-- <div
				use:melt={$progress}
				class="absolute left-5 top-2 h-1 w-[10%] overflow-hidden rounded-full bg-gray-900">
				<div
					class="bg-red-500 h-full w-full"
					style={`transform: translateX(-${100 - (100 * ($percentage ?? 0)) / ($max ?? 1)}%)`} />
			</div> -->

			<!-- <div
				class="relative flex w-[24rem] max-w-[calc(100vw-2rem)] items-center justify-between gap-4 p-5 pt-6"> -->
			<div
				class="relative flex w-[24rem] max-w-[calc(100vw-2rem)] items-center justify-between gap-4 p-4">
				<div>
					<h3 use:melt={$title(id)} class="flex items-center gap-2 font-medium tracking-tight">
						{data.title}
						<span class="h-1.5 w-1.5 rounded-full {data.color}" />
					</h3>
					<div use:melt={$description(id)} class="text-sm leading-relaxed">
						{data.description}
					</div>
				</div>

				<button
					use:melt={$close(id)}
					class="absolute right-4 top-4 grid h-6 w-6 place-items-center rounded-full text-card-foreground hover:bg-foreground/5">
					<X class="h-4 w-4" />
				</button>
			</div>
		</div>
	{/each}
</div>
