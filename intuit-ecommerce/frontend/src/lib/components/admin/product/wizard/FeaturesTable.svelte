<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import type { FloatingConfig } from '@melt-ui/svelte/internal/actions';
	import { fly, slide } from 'svelte/transition';
	import { Input } from '$lib/components/ui/input';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import { Button } from '$lib/components/ui/button';
	import { ChevronLeft, ChevronRight, PlusCircle, XCircle } from 'lucide-svelte';
	import { createEventDispatcher } from 'svelte';

	export let list: Record<string, string>;

	const MAX_KEY_LENGTH = 20;
	const MAX_VALUE_LENGTH = 50;

	const dispatch = createEventDispatcher<{
		next: boolean;
		prev: boolean;
	}>();

	const tooltipPosTop: FloatingConfig = {
		placement: 'top-start'
	};

	const tooltipPosLeft: FloatingConfig = {
		placement: 'left'
	};

	function clearErrors() {
		if (specKey.error) specKey.error = undefined;
		if (specValue.error) specValue.error = undefined;
	}

	function validateInput(key: string, value: string) {
		if (key.length === 0) specKey.error = 'Name cannot be empty';
		if (value.length === 0) specValue.error = 'Value cannot be empty';
		if (key.length > MAX_KEY_LENGTH)
			specKey.error = `Name cannot be more than ${MAX_KEY_LENGTH} characters`;
		if (value.length > MAX_VALUE_LENGTH)
			specValue.error = `Value cannot be more than ${MAX_VALUE_LENGTH} characters`;

		return specKey.error || specValue.error ? false : true;
	}

	let specKey: {
		value: string;
		error?: string;
	};
	let specValue: {
		value: string;
		error?: string;
	};
	specKey = { value: '' };
	specValue = { value: '' };
</script>

<Card.Header>
	<Card.Title>Product specifications & features</Card.Title>
	<Card.Description>Add specifications and features to your product details.</Card.Description>
</Card.Header>

{#if specKey.error}
	<div transition:slide class="px-6 pb-2">
		<p class="text-xs font-medium text-destructive">
			{specKey.error}
		</p>
	</div>
{/if}

{#if specValue.error}
	<div transition:slide class="px-6 pb-2">
		<p class="text-xs font-medium text-destructive">
			{specValue.error}
		</p>
	</div>
{/if}

<Card.Content class="flex-1 overflow-y-auto overscroll-contain px-2">
	<div class="rounded-xl border">
		<table class="w-full text-sm">
			<thead class="[&_tr]:border-b">
				<tr class="border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
					<th class="h-10 px-2 text-left align-middle font-medium text-muted-foreground">Name</th>

					<th class="h-10 px-2 text-left align-middle font-medium text-muted-foreground">Value</th>

					<th class="h-10 px-2 text-left align-middle font-medium text-muted-foreground"></th>
				</tr>
			</thead>

			<tbody class="[&_tr:last-child]:border-0">
				<tr class="h-9 border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
					<td class="py-2 pl-2 pr-0.5 align-middle">
						<Input
							on:input={() => {
								if (specKey.error) specKey.error = undefined;
							}}
							bind:value={specKey.value}
							class="rounded-2xl text-xs
            {specKey.error ? 'border-destructive focus-visible:ring-destructive' : ''}" />
					</td>

					<td class="py-2 pl-0.5 pr-0.5 align-middle">
						<Input
							on:input={() => {
								if (specValue.error) specValue.error = undefined;
							}}
							bind:value={specValue.value}
							class="rounded-2xl text-xs
            {specValue.error ? 'border-destructive focus-visible:ring-destructive' : ''}" />
					</td>

					<td class="py-2 pl-0.5 pr-2 align-middle">
						<Tooltip.Root openDelay={100} positioning={tooltipPosTop}>
							<Tooltip.Trigger asChild let:builder>
								<Button
									builders={[builder]}
									size="icon"
									variant="outline"
									class="h-9 rounded-lg hover:text-green-500"
									on:click={(e) => {
										e.preventDefault();

										specKey.value = specKey.value.trim();
										specValue.value = specValue.value.trim();

										const valid = validateInput(specKey.value, specValue.value);

										if (valid) {
											list[specKey.value] = specValue.value;

											// Clear
											specKey.value = '';
											specValue.value = '';
											clearErrors();
										}
									}}>
									<PlusCircle size={16} strokeWidth={2.75} />
								</Button>
							</Tooltip.Trigger>
							<Tooltip.Content
								class="bg-background font-medium text-foreground shadow-md
                  dark:bg-foreground dark:text-background">
								<span>Add row</span>
							</Tooltip.Content>
						</Tooltip.Root>
					</td>
				</tr>

				{#each Object.entries(list) as [key, value]}
					<tr
						transition:fly
						class="h-9 border-b transition-colors hover:bg-muted/50 data-[state=selected]:bg-muted">
						<td class="py-2 pl-2 pr-0.5 align-middle text-xs">{key}</td>

						<td class="py-2 pl-0.5 pr-0.5 align-middle text-xs">{value}</td>

						<td class="py-2 pl-0.5 pr-2 align-middle">
							<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
								<Tooltip.Trigger asChild let:builder>
									<Button
										builders={[builder]}
										size="icon"
										variant="outline"
										class="h-9 rounded-lg hover:text-destructive"
										on:click={(e) => {
											e.preventDefault();
											delete list[key];
											list = list;
										}}>
										<XCircle size={16} strokeWidth={2.75} />
									</Button>
								</Tooltip.Trigger>
								<Tooltip.Content
									class="bg-background font-medium text-foreground shadow-md
                    dark:bg-foreground dark:text-background">
									<span>Remove row</span>
								</Tooltip.Content>
							</Tooltip.Root>
						</td>
					</tr>
				{/each}
			</tbody>
		</table>
	</div>
</Card.Content>

<Card.Footer class="flex justify-between pt-2">
	<Button
		variant="ghost"
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();
			clearErrors();

			dispatch('prev', true);
		}}>
		<ChevronLeft size={16} strokeWidth={2.75} class="mr-2 transition group-hover:-translate-x-1" />
		Back
	</Button>

	<Button
		variant={Object.entries(list).length ? 'default' : 'outline'}
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();
			clearErrors();

			dispatch('next', true);
		}}>
		{Object.entries(list).length ? 'Next' : 'Skip'}
		<ChevronRight size={16} strokeWidth={2.75} class="ml-2 transition group-hover:translate-x-1" />
	</Button>
</Card.Footer>
