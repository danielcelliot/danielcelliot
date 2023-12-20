<script lang="ts">
	import type { Label as TicketLabel } from '$lib/types/chatwoot';
	import type { TicketSchema } from '$lib/schemas/ticket';
	import { createEventDispatcher } from 'svelte';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { superForm } from 'sveltekit-superforms/client';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Check } from 'lucide-svelte';
	import { scale, slide } from 'svelte/transition';
	import Label from '$lib/components/ui/label/label.svelte';
	import Input from '$lib/components/ui/input/input.svelte';
	import Button from '$lib/components/ui/button/button.svelte';
	import { createSelect, melt } from '@melt-ui/svelte';
	import { CaretSort } from 'radix-icons-svelte';
	import { flyAndScale } from '$lib/utils/ui';
	import Textarea from '$lib/components/ui/textarea/textarea.svelte';
	import { capitalize } from 'lodash';

	export let formData: SuperValidated<TicketSchema>;
	export let labels: TicketLabel[];

	let disabled = false;

	const dispatch = createEventDispatcher();

	const {
		elements: { trigger, menu, option, label },
		states: { selectedLabel, open, selected },
		helpers: { isSelected }
	} = createSelect({
		forceVisible: true,
		positioning: {
			placement: 'top',
			fitViewport: true,
			sameWidth: true
		}
	});

	const { form, errors, message, enhance, delayed } = superForm(formData, {
		onResult({ result }) {
			if (result.type === 'redirect') {
				dispatch('view', {
					open: false
				});
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
			$message = result.error.message;
		}
	});
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

<form action="?/create" method="POST" use:enhance>
	<div class="mt-2 grid w-full max-w-sm items-center gap-6">
		<div class="grid gap-2">
			<Label for="subject">Subject</Label>
			<Input
				id="subject"
				name="subject"
				type="text"
				class="rounded-2xl
        {$errors.subject ? 'border-destructive focus-visible:ring-destructive' : ''}"
				aria-invalid={$errors.subject ? 'true' : undefined}
				bind:value={$form.subject}
				on:focus={() => {
					if ($errors.subject) $errors.subject = undefined;
				}}
				on:input={() => {
					if ($errors.subject) $errors.subject = undefined;
				}} />

			{#if $errors.subject}
				<p transition:slide class="text-sm font-medium text-destructive">
					{$errors.subject}
				</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<input type="hidden" name="label_id" value={$selected?.value} />

			<label for="dept" use:melt={$label} class="text-sm font-medium leading-none">
				Department
			</label>
			<button
				use:melt={$trigger}
				on:focus={() => {
					if ($errors.label_id) $errors.label_id = undefined;
				}}
				class="flex h-9 w-full items-center justify-between rounded-2xl border
          {$errors.label_id ? 'border-destructive' : 'border-input'}
          bg-transparent px-3 py-2 text-sm shadow-sm ring-offset-background placeholder:text-muted-foreground focus:outline-none focus:ring-1
          {$errors.label_id
					? 'focus:ring-destructive focus-visible:ring-destructive'
					: 'focus:ring-ring'}
          disabled:cursor-not-allowed disabled:opacity-50">
				{$selectedLabel || 'Select a department'}
				<CaretSort class="h-4 w-4 opacity-50" />
			</button>

			{#if $open}
				<div
					use:melt={$menu}
					in:flyAndScale
					out:scale={{ start: 0.95, opacity: 0, duration: 50 }}
					class="relative z-50 min-w-[8rem] overflow-hidden rounded-2xl border bg-popover text-popover-foreground shadow-md focus:outline-none">
					<div class="w-full p-1">
						{#each labels as { id, title }}
							<div
								use:melt={$option({ value: id, label: capitalize(title) })}
								class="relative flex w-full cursor-pointer select-none items-center rounded-xl py-1.5 pl-2 pr-8 text-sm outline-none data-[disabled]:pointer-events-none data-[highlighted]:bg-accent data-[highlighted]:text-accent-foreground data-[disabled]:opacity-50">
								<div class="absolute right-2 flex h-3.5 w-3.5 items-center justify-center">
									{#if $isSelected(id)}
										<Check class="h-4 w-4" />
									{/if}
								</div>
								{capitalize(title)}
							</div>
						{/each}
					</div>
				</div>
			{/if}

			{#if $errors.label_id}
				<p transition:slide class="text-sm font-medium text-destructive">
					{$errors.label_id}
				</p>
			{/if}
		</div>

		<div class="grid gap-2">
			<Label for="message">Your message</Label>
			<Textarea
				rows={5}
				placeholder="Type your message here."
				id="message"
				name="content"
				class="resize-none rounded-2xl
          {$errors.content ? 'border-destructive focus-visible:ring-destructive' : ''}"
				on:focus={() => {
					if ($errors.content) $errors.content = undefined;
				}}
				on:input={() => {
					if ($errors.content) $errors.content = undefined;
				}} />

			{#if $errors.content}
				<p transition:slide class="text-sm font-medium text-destructive">
					{$errors.content}
				</p>
			{/if}
		</div>
	</div>

	<Button {disabled} type="submit" class="mt-6 w-full rounded-2xl">
		{#if $delayed}
			<svg
				transition:slide={{ axis: 'x' }}
				class="mr-4 inline h-4 w-4 animate-spin"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
				stroke-linecap="round"
				stroke-linejoin="round">
				<path d="M21 12a9 9 0 1 1-6.219-8.56" />
			</svg>
		{/if}
		<span>{$delayed ? 'Creating Ticket...' : 'Create Ticket'}</span>
	</Button>
</form>
