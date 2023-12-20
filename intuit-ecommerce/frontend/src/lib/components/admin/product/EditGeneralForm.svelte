<script lang="ts">
	import { invalidateAll } from '$app/navigation';
	import { getProductCondition } from '$lib/client/shop';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Textarea } from '$lib/components/ui/textarea';
	import { updateGeneralInfoSchema, type UpdateGeneralInfoSchema } from '$lib/schemas/product';
	import { ProductCondition } from '$lib/types/medusa';
	import { flyAndScale } from '$lib/utils/ui';
	import { createSelect, createTagsInput, melt, type Tag } from '@melt-ui/svelte';
	import { AlertCircle, Loader2, X } from 'lucide-svelte';
	import { CaretSort, Check } from 'radix-icons-svelte';
	import { createEventDispatcher } from 'svelte';
	import { fly, scale, slide } from 'svelte/transition';
	import type { SuperValidated } from 'sveltekit-superforms';
	import * as Alert from '$lib/components/ui/alert';
	import { superForm } from 'sveltekit-superforms/client';
	import type { z } from 'zod';

	export let form: SuperValidated<UpdateGeneralInfoSchema>;
	export let formData: z.infer<typeof updateGeneralInfoSchema>;
	export let href: string;

	const dispatch = createEventDispatcher();

	const {
		form: formStore,
		enhance,
		errors,
		delayed,
		validate,
		message
	} = superForm(form, {
		validators: updateGeneralInfoSchema,
		delayMs: 500,
		timeoutMs: 8000,
		dataType: 'json',
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') {
				dispatch('view', {
					show: false
				});

				/* By default, re-running the load function with invalidateAll() immediately after a successful form
          submission causes MedusaJS to respond with stale data. A timeout is required to resolve this issue. */
				setTimeout(() => invalidateAll(), 2000);
			}
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) disabled = false;
		},
		onError({ result }) {
			disabled = false;
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const {
		elements: { trigger, menu, option, label },
		states: { selectedLabel, open, selected },
		helpers: { isSelected }
	} = createSelect({
		defaultSelected: formData.condition
			? {
					value: Object.values(formData.condition)[0],
					label: getProductCondition(formData.condition)
			  }
			: undefined,
		preventScroll: true,
		forceVisible: true,
		positioning: {
			placement: 'top',
			fitViewport: false,
			sameWidth: true
		}
	});

	const {
		elements: { root: tagRoot, input, tag, deleteTrigger },
		states: { tags }
	} = createTagsInput({
		defaultTags: formData.tags?.map((t) => {
			return {
				id: t.id ?? '',
				value: t.value
			};
		}),
		trim: false,
		unique: false,
		editable: false,
		add: async (v: string) => {
			// TODO: Move checks to Zod schema
			const alphaRegex = new RegExp(/^[a-z0-9\s]+$/i);
			if (!alphaRegex.test(v)) {
				tagError = 'Tag can only include letters, spaces and numbers';
				throw new Error();
			}

			const trimmedTag = v.trim().replace(/\s+/g, ' ').toLowerCase();

			if (trimmedTag.length === 0) {
				tagError = 'Tag cannot be whitespace';
				throw new Error();
			}

			if ($tags.some((tag) => tag.value === trimmedTag)) {
				tagError = `${trimmedTag} already exists`;
				throw new Error();
			}

			const invalid = await validate('tags[0].value', { value: trimmedTag, update: false });
			if (invalid) {
				tagError = invalid[0];
				throw new Error();
			}

			if ($formStore.tags) $formStore.tags = [...$formStore.tags, { value: trimmedTag }];
			return trimmedTag;
		},
		remove: (tag: Tag) => {
			$formStore.tags = $formStore.tags?.filter((t) => t.value !== tag.value);
			return true;
		}
	});

	let disabled: boolean;
	let tagError: string | undefined;
	let selectError: string | undefined;

	$formStore = formData;

	$: if ($selected) {
		switch ($selected.value) {
			case 'new':
				$formStore.condition = ProductCondition.NEW;
				break;
			case 'used':
				$formStore.condition = ProductCondition.USED;
				break;
			case 'not_working':
				$formStore.condition = ProductCondition.NOT_WORKING;
				break;
		}
	}
</script>

{#if $message}
	<div transition:slide>
		<Alert.Root variant="destructive">
			<AlertCircle class="h-4 w-4" />
			<Alert.Title>Error</Alert.Title>
			<Alert.Description>{$message}</Alert.Description>
		</Alert.Root>
	</div>
{/if}

<form action={href} method="post" use:enhance>
	<div class="mt-4 grid gap-6">
		<div class="grid gap-2">
			<!-- prettier-ignore -->
			<Label for="product_name">
				Product name<sup class="text-destructive">*</sup>
			</Label>
			<Input
				id="product_name"
				bind:value={$formStore.title}
				class="rounded-2xl
          {$errors.title ? 'border-destructive focus-visible:ring-destructive' : ''}" />

			{#if $errors.title}
				<p transition:slide class="text-xs font-medium text-destructive">{$errors.title}</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<!-- prettier-ignore -->
			<label for="dept" use:melt={$label} class="text-sm font-medium leading-none">
        Condition<sup class="text-destructive">*</sup>
      </label>
			<button
				use:melt={$trigger}
				on:click={(e) => e.preventDefault()}
				on:focus={() => {
					if (selectError) selectError = undefined;
				}}
				class="flex h-9 w-full items-center justify-between rounded-2xl border
          {selectError ? 'border-destructive' : 'border-input'}
          bg-transparent px-3 py-2 text-sm shadow-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-1 aria-expanded:pointer-events-none aria-expanded:focus:ring-0
          {selectError
					? 'focus:ring-destructive focus-visible:ring-destructive'
					: 'focus:ring-ring'}
          disabled:cursor-not-allowed disabled:opacity-50">
				{$selectedLabel || 'Select product condition'}
				<CaretSort class="h-4 w-4 opacity-50" />
			</button>

			{#if $open}
				<div
					use:melt={$menu}
					in:flyAndScale={{ duration: 50 }}
					out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
					class="relative z-50 min-w-[8rem] overflow-hidden rounded-2xl border bg-popover text-popover-foreground shadow-md focus:outline-none">
					<div class="w-full p-1">
						{#each Object.values(ProductCondition) as condition}
							<div
								use:melt={$option({
									value: condition,
									label: getProductCondition(condition)
								})}
								class="relative flex w-full select-none items-center rounded-xl py-1.5 pl-2 pr-8 text-sm outline-none hover:bg-muted data-[disabled]:pointer-events-none data-[disabled]:opacity-50">
								<div class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
									{#if $isSelected(condition)}
										<Check class="h-4 w-4" />
									{/if}
								</div>
								{getProductCondition(condition)}
							</div>
						{/each}
					</div>
				</div>
			{/if}

			{#if selectError}
				<p transition:slide class="text-xs font-medium text-destructive">{selectError}</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<Label for="subtitle">Subtitle</Label>
			<Input
				id="subtitle"
				bind:value={$formStore.subtitle}
				class="rounded-2xl
          {$errors.subtitle ? 'border-destructive focus-visible:ring-destructive' : ''}" />

			{#if $errors.subtitle}
				<p transition:slide class="text-xs font-medium text-destructive">{$errors.subtitle}</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<Label for="description">Description</Label>
			<Textarea
				rows={4}
				id="description"
				bind:value={$formStore.description}
				class="resize-none rounded-2xl
          {$errors.description ? 'border-destructive focus-visible:ring-destructive' : ''}" />

			{#if $errors.description}
				<p transition:slide class="text-xs font-medium text-destructive">{$errors.description}</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<Label for="tags">Tags</Label>
			<div id="tags" class="flex flex-col items-start justify-center gap-2">
				<div
					use:melt={$tagRoot}
					class="flex w-full flex-row flex-wrap gap-2.5 rounded-2xl border px-3 py-2 text-sm shadow-sm focus-within:ring-1
            {tagError
						? 'border-destructive focus-within:ring-destructive'
						: 'border-input focus-within:ring-ring'}">
					{#each $tags as t}
						<div
							transition:fly
							use:melt={$tag(t)}
							class="flex items-center overflow-hidden rounded-lg border border-input bg-transparent
                [word-break:break-word] data-[selected]:bg-destructive data-[selected]:text-destructive-foreground">
							<span class="flex items-center border-r border-white/10 px-1.5">
								{t.value}
							</span>

							<button
								on:click={(e) => e.preventDefault()}
								use:melt={$deleteTrigger(t)}
								class="flex h-full items-center px-1 hover:text-destructive-foreground enabled:hover:bg-destructive">
								<X class="h-3 w-3" />
							</button>
						</div>
					{/each}

					<input
						use:melt={$input}
						on:input={() => {
							if (tagError) tagError = undefined;
						}}
						type="text"
						placeholder="Enter tags..."
						class="min-w-[4.5rem] shrink grow basis-0 border-0 bg-transparent outline-none focus:!ring-0 data-[invalid]:text-destructive" />
				</div>
			</div>

			{#if tagError}
				<p transition:slide class="text-xs font-medium text-destructive">{tagError}</p>
			{/if}
		</div>
	</div>

	<div class={disabled ? 'cursor-not-allowed' : ''}>
		<Button {disabled} class="mt-6 w-full rounded-2xl font-semibold" type="submit">
			{#if $delayed}
				<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
			{/if}
			<span>{$delayed ? 'Saving changes...' : 'Save changes'}</span>
		</Button>
	</div>
</form>
