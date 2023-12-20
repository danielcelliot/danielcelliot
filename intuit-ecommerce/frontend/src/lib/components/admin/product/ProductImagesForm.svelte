<script lang="ts">
	import type { ProductImage } from '$lib/types/medusa';
	import {
		type SaveImagesSchema,
		type DeleteImagesSchema,
		imageUploadSchema,
		MAX_FILE_LIMIT
	} from '$lib/schemas/product';
	import { addFiles, deleteFile, dropFiles, getFileSize, inputFiles } from '$lib/client/shop';
	import { createEventDispatcher } from 'svelte';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { superForm } from 'sveltekit-superforms/client';
	import { fly, slide } from 'svelte/transition';
	import { createToggleGroup, melt } from '@melt-ui/svelte';
	import * as Alert from '$lib/components/ui/alert';
	import { AlertCircle, Loader2, XCircle } from 'lucide-svelte';
	import Button from '$lib/components/ui/button/button.svelte';
	import AspectRatio from '$lib/components/ui/aspect-ratio/aspect-ratio.svelte';

	export let productId: string;
	export let images: ProductImage[];
	export let saveForm: SuperValidated<SaveImagesSchema>;
	export let deleteForm: SuperValidated<DeleteImagesSchema>;
	export let href: string;

	let input: HTMLInputElement;
	let uploads: File[] = [];
	let uploadDisabled = true;
	let deleteDisabled = false;
	let showDeletePrompt = false;

	const dispatch = createEventDispatcher();

	const {
		elements: { root, item },
		helpers: { isPressed },
		states: { value: selectedImages }
	} = createToggleGroup({
		type: 'multiple',
		loop: true
	});

	const { errors, message, enhance, delayed } = superForm(saveForm, {
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
			uploadDisabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) uploadDisabled = false;
		},
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const { enhance: delEnhance, delayed: delDelayed } = superForm(deleteForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onResult() {
			showDeletePrompt = false;
			deleteDisabled = false;
		},
		onSubmit() {
			deleteDisabled = true;
			$selectedImages = [];
		},
		onUpdated({ form }) {
			showDeletePrompt = false;
			if (!form.valid) deleteDisabled = false;
		},
		onError({ result }) {
			showDeletePrompt = false;
			deleteDisabled = false;
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	function updateFileInput() {
		const data = new DataTransfer();
		for (const u of uploads) {
			data.items.add(u);
		}

		input.files = data.files;
	}

	function handleDrop(e: DragEvent) {
		e.preventDefault();
		const filesInput = dropFiles(e);
		const files = addFiles(filesInput, uploads);

		if (images.length + files.length > MAX_FILE_LIMIT) {
			$errors.files = [`No more than ${MAX_FILE_LIMIT} images are allowed for each product`];
			return;
		}

		const validated = imageUploadSchema.safeParse({ files });
		if (validated.success) {
			uploads = files;
			updateFileInput();
		} else {
			const formatted = validated.error.format();
			const err = formatted.files?.[0]?._errors ?? formatted.files?._errors;
			$errors.files = err;
		}
	}

	function handleChange(e: Event) {
		const filesInput = inputFiles(e);

		if (filesInput) {
			const files = addFiles(filesInput, uploads);

			if (images.length + files.length > MAX_FILE_LIMIT) {
				$errors.files = [`No more than ${MAX_FILE_LIMIT} images are allowed for each product`];
				return;
			}

			const validated = imageUploadSchema.safeParse({ files });
			if (validated.success) {
				uploads = files;
				updateFileInput();
			} else {
				const formatted = validated.error.format();
				const err = formatted.files?.[0]?._errors ?? formatted.files?._errors;
				$errors.files = err;
			}
		}
	}

	function handleDelete(name: string) {
		const remaining = deleteFile(name, uploads);
		uploads = remaining;

		updateFileInput();
	}

	$: uploads.length ? (uploadDisabled = false) : (uploadDisabled = true);
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

<form action={href} method="post" enctype="multipart/form-data" use:enhance>
	<input type="hidden" name="product_id" value={productId} />

	<div class="mt-2 grid gap-4">
		<!-- Dropzone -->
		<div class="grid gap-2">
			<label
				on:drop={handleDrop}
				on:dragover={(event) => {
					if ($errors.files) $errors.files = undefined;
					event.preventDefault();
				}}
				class="flex h-36 w-full cursor-pointer flex-col items-center justify-center rounded-2xl border-2 border-dashed border-gray-300 bg-gray-50 hover:bg-gray-100 dark:border-gray-600 dark:bg-gray-700 dark:hover:border-gray-500 dark:hover:bg-gray-600">
				<svg
					aria-hidden="true"
					class="mb-3 h-10 w-10 text-gray-400"
					fill="none"
					stroke="currentColor"
					viewBox="0 0 24 24"
					xmlns="http://www.w3.org/2000/svg">
					<path
						stroke-linecap="round"
						stroke-linejoin="round"
						stroke-width="2"
						d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
				</svg>
				<p class="mb-2 text-sm text-gray-500 dark:text-gray-400">
					<span class="font-semibold">Tap to upload</span>
					or drag and drop
				</p>
				<p class="text-xs text-gray-500 dark:text-gray-400">PNG, JPG or WebP (up to 5MB)</p>
				<input
					multiple
					type="file"
					class="hidden"
					accept="image/png, image/jpeg, image/webp"
					name="files"
					bind:this={input}
					on:click={() => {
						if ($errors.files) $errors.files = undefined;
					}}
					on:change={handleChange} />
			</label>

			{#if $errors.files}
				<div transition:slide>
					{#each $errors.files as error}
						<p class="text-xs font-medium text-destructive">{error}</p>
					{/each}
				</div>
			{/if}
		</div>

		{#if uploads.length > 0}
			<div class="grid gap-2" transition:slide>
				<p class="text-xs font-medium text-muted-foreground">New Images ({uploads.length})</p>

				{#each uploads as upload (upload.name)}
					<div class="flex gap-2" in:fly={{ y: 20 }} out:slide>
						<div class="w-[70px] overflow-hidden rounded-lg">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-lg object-cover" src={URL.createObjectURL(upload)} alt="" />
							</AspectRatio>
						</div>

						<div class="flex flex-col justify-around">
							<div class="grid gap-0.5">
								<p class="truncate text-xs font-medium">{upload.name}</p>
								<p class="text-xs font-medium text-muted-foreground">{getFileSize(upload.size)}</p>
							</div>

							<div>
								<Button
									size="sm"
									variant="outline"
									class="h-7 rounded-2xl font-semibold hover:text-destructive"
									on:click={(e) => {
										e.preventDefault();
										handleDelete(upload.name);
									}}>
									<XCircle size={16} strokeWidth={2.75} class="mr-2" />
									Remove
								</Button>
							</div>
						</div>
					</div>
				{/each}
			</div>
		{/if}
	</div>

	<div class={uploadDisabled ? 'cursor-not-allowed' : ''}>
		<Button disabled={uploadDisabled} class="mt-6 w-full rounded-2xl font-semibold" type="submit">
			{#if $delayed}
				<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
			{/if}
			<span>{$delayed ? 'Saving...' : 'Save images'}</span>
		</Button>
	</div>

	{#if images.length}
		<form action="?/deleteImages" method="post" use:delEnhance>
			<input type="hidden" name="product_id" value={productId} />
			<input type="hidden" name="image_ids" value={$selectedImages} />

			<div class="mt-6 grid gap-2">
				<p class="text-xs font-medium text-muted-foreground">Saved Images ({images.length})</p>

				<div class="relative">
					{#if showDeletePrompt}
						<div
							class="absolute z-10 flex w-full items-center justify-between"
							transition:fly={{ x: 10, duration: 100 }}>
							<p class="text-xs font-normal">Are you sure?</p>

							<div class="flex gap-1">
								<div class={deleteDisabled ? 'cursor-not-allowed' : ''}>
									<Button
										disabled={deleteDisabled}
										size="sm"
										variant="destructive"
										class="w-20 rounded-2xl font-semibold"
										type="submit">
										{#if $delDelayed}
											<Loader2 size={16} strokeWidth={2.75} class="animate-spin" />
										{:else}
											<span>Yes</span>
										{/if}
									</Button>
								</div>

								<div class={deleteDisabled ? 'cursor-not-allowed' : ''}>
									<Button
										disabled={deleteDisabled}
										size="sm"
										variant="outline"
										class="w-20 rounded-2xl font-semibold"
										on:click={(e) => {
											e.preventDefault();
											showDeletePrompt = false;
										}}>
										<span>No</span>
									</Button>
								</div>
							</div>
						</div>
					{/if}

					<div
						class="flex items-center justify-between
              {showDeletePrompt ? 'opacity-0' : 'opacity-100'}">
						<p
							class="text-xs font-normal
                {$selectedImages?.length ? 'text-foreground' : 'text-muted-foreground'}">
							{$selectedImages?.length} selected
						</p>

						<div>
							<Button
								disabled={$selectedImages?.length === 0}
								size="sm"
								variant="ghost"
								class="rounded-2xl"
								on:click={(e) => {
									e.preventDefault();
									$selectedImages = [];
								}}>
								Deselect all
							</Button>

							<Button
								disabled={$selectedImages?.length === 0}
								size="sm"
								variant="link"
								class="text-foreground"
								on:click={(e) => {
									e.preventDefault();
									showDeletePrompt = true;
								}}>
								Delete
							</Button>
						</div>
					</div>
				</div>

				<div use:melt={$root} class="grid grid-cols-3 gap-2">
					{#each images as image}
						<button
							transition:fly={{ x: -10, duration: 100 }}
							use:melt={$item(image.id)}
							value={image.id}
							class="flex justify-center rounded-xl border-2 bg-transparent {$isPressed(image.id)
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
			</div>
		</form>
	{/if}
</form>
