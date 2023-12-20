<script lang="ts">
	import type { FloatingConfig } from '@melt-ui/svelte/internal/actions';
	import type { ProductCategory } from '$lib/types/medusa';
	import { createEventDispatcher } from 'svelte';
	import { slide } from 'svelte/transition';
	import { Badge } from '$lib/components/ui/badge';
	import { Button } from '$lib/components/ui/button';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import * as Card from '$lib/components/ui/card';
	import { ChevronLeft, ChevronRight, XCircle } from 'lucide-svelte';

	export let categories: ProductCategory[];
	export let selected: {
		id: string;
		name: string;
	}[] = [];

	// TODO: Move to svelte store
	export let currentList = categories;
	export let completed: boolean;

	const dispatch = createEventDispatcher<{
		next: boolean;
		prev: boolean;
	}>();

	const tooltipPosLeft: FloatingConfig = {
		placement: 'left'
	};
</script>

<Card.Header>
	<Card.Title>Categories</Card.Title>
	<Card.Description>Select the categories that are relevant to your product.</Card.Description>
</Card.Header>

<Card.Content class="flex-1 overflow-y-auto overscroll-contain">
	{#if selected.length}
		<div class="sticky top-0 z-10 bg-background">
			<div class="flex items-center justify-between pb-4" transition:slide>
				<div class="space-y-1">
					{#each selected as { name }}
						<div transition:slide>
							<Badge class="ml-1" variant="secondary">{name}</Badge>
						</div>
					{/each}
				</div>

				<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
					<Tooltip.Trigger asChild let:builder>
						<Button
							builders={[builder]}
							size="icon"
							variant="outline"
							class="rounded-lg hover:text-destructive"
							on:click={(e) => {
								e.preventDefault();

								// Default state
								currentList = categories;
								selected = [];
								completed = false;
							}}>
							<XCircle size={20} strokeWidth={2.75} />
						</Button>
					</Tooltip.Trigger>
					<Tooltip.Content
						class="bg-background font-medium text-foreground shadow-md
              dark:bg-foreground dark:text-background">
						<span>Clear selections</span>
					</Tooltip.Content>
				</Tooltip.Root>
			</div>
		</div>
	{/if}

	{#if currentList.length}
		{#key completed}
			<div
				class="divide-y overflow-hidden rounded-xl border border-border text-xs font-medium {completed
					? 'text-muted-foreground'
					: 'text-foreground'}">
				{#each currentList as { id, name, category_children }}
					{#if category_children?.length}
						<button
							disabled={completed}
							class="flex h-10 w-full items-center justify-between truncate px-3
              {completed ? '' : 'hover:bg-muted'}"
							on:click={(e) => {
								e.preventDefault();
								selected = [...selected, { id, name }];
								currentList = category_children ?? [];
							}}>
							{name}
							<ChevronRight size={12} />
						</button>
					{:else}
						<div class="flex h-10 items-center justify-between truncate px-3">
							{name}
							<Button
								disabled={completed}
								size="sm"
								variant="outline"
								class="h-5 rounded-2xl font-semibold"
								on:click={(e) => {
									e.preventDefault();
									selected = [...selected, { id, name }];
									completed = true;
								}}>
								Select
							</Button>
						</div>
					{/if}
				{/each}
			</div>
		{/key}
	{/if}
</Card.Content>

<Card.Footer class="flex justify-between pt-2">
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

	<div class={!completed ? 'cursor-not-allowed' : ''}>
		<Button
			class="group w-28 rounded-2xl font-semibold"
			disabled={!completed}
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
</Card.Footer>
