<script lang="ts">
	import type { ProductImage } from '$lib/types/medusa';
	import type { SaveThumbnailSchema } from '$lib/schemas/product';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { createEventDispatcher } from 'svelte';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import { createRadioGroup, melt } from '@melt-ui/svelte';
	import Button from '$lib/components/ui/button/button.svelte';
	import AspectRatio from '$lib/components/ui/aspect-ratio/aspect-ratio.svelte';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Loader2 } from 'lucide-svelte';

	export let thumbnailForm: SuperValidated<SaveThumbnailSchema>;
	export let productId: string;
	export let images: ProductImage[];
	export let href: string;

	let disabled = true;

	const dispatch = createEventDispatcher();

	const {
		elements: { root, item, hiddenInput },
		helpers: { isChecked }
	} = createRadioGroup({
		loop: true,
		orientation: 'horizontal'
	});

	const { enhance, delayed, message } = superForm(thumbnailForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
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
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	$: if ($hiddenInput.value) disabled = false;
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
	<input type="hidden" name="product_id" value={productId} />
	<input type="hidden" name="image_id" value={$hiddenInput.value} />

	<div class="mt-2 grid gap-2">
		<p class="text-xs font-medium text-muted-foreground">Saved Images</p>

		{#if images.length > 0}
			<div use:melt={$root} class="grid grid-cols-3 gap-2">
				{#each images as image}
					<button
						use:melt={$item(image.id)}
						class="flex justify-center rounded-xl border-2 bg-transparent {$isChecked(image.id)
							? 'border-ring hover:border-ring'
							: 'border-transparent hover:border-border'}">
						<div class="w-[80px] overflow-hidden rounded-lg">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-lg object-cover" src={image.url} alt="" />
							</AspectRatio>
						</div>
					</button>
				{/each}
			</div>
		{:else}
			<p>Please upload images first</p>
		{/if}
	</div>

	<div class={disabled ? 'cursor-not-allowed' : ''}>
		<Button {disabled} class="mt-6 w-full rounded-2xl font-semibold" type="submit">
			{#if $delayed}
				<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
			{/if}
			<span>{$delayed ? 'Saving...' : 'Save changes'}</span>
		</Button>
	</div>
</form>
