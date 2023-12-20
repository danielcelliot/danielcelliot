<script lang="ts">
	import type { FilesSchema } from '$lib/schemas/productWizard';
	import type { SuperValidated } from 'sveltekit-superforms';
	import { createEventDispatcher } from 'svelte';
	import { imageUploadSchema } from '$lib/schemas/product';
	import { superForm } from 'sveltekit-superforms/client';
	import { addFiles, deleteFile, dropFiles, getFileSize, inputFiles } from '$lib/client/shop';
	import { fly, slide } from 'svelte/transition';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { ChevronLeft, ChevronRight, XCircle } from 'lucide-svelte';

	export let form: SuperValidated<FilesSchema>;
	export let uploads: File[];

	const dispatch = createEventDispatcher<{ prev: boolean; next: boolean }>();

	const { errors } = superForm(form, {
		dataType: 'json'
	});

	let dropzone: HTMLInputElement;

	function handleDrop(e: DragEvent) {
		e.preventDefault();
		const input = dropFiles(e);
		const files = addFiles(input, uploads);

		const validated = imageUploadSchema.safeParse({ files });
		if (validated.success) {
			uploads = files;
		} else {
			const formatted = validated.error.format();
			const err = formatted.files?.[0]?._errors ?? formatted.files?._errors;
			$errors.files = err;
		}
	}

	function handleChange(e: Event) {
		const input = inputFiles(e);

		if (input) {
			const files = addFiles(input, uploads);

			const validated = imageUploadSchema.safeParse({ files });
			if (validated.success) {
				uploads = files;
			} else {
				const formatted = validated.error.format();
				const err = formatted.files?.[0]?._errors ?? formatted.files?._errors;
				$errors.files = err;
			}
		}
	}

	function handleDelete(name: string) {
		const files = deleteFile(name, uploads);
		uploads = files;
	}
</script>

<Card.Header>
	<Card.Title>Product Images</Card.Title>
	<Card.Description>Upload images for your product.</Card.Description>
</Card.Header>

<Card.Content class="flex-1 space-y-4 overflow-y-auto overscroll-contain">
	<div class="grid gap-4">
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
					bind:this={dropzone}
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

		{#if uploads.length}
			<div class="grid gap-2" transition:slide>
				<p class="text-xs font-medium text-muted-foreground">Images ({uploads.length})</p>

				{#each uploads as upload (upload.name)}
					<div class="flex gap-2" in:fly={{ y: 20 }} out:slide>
						<div class="w-[70px] overflow-hidden rounded-sm">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-md object-cover" src={URL.createObjectURL(upload)} alt="" />
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

	<Button
		variant={uploads.length ? 'default' : 'outline'}
		class="group w-28 rounded-2xl font-semibold"
		on:click={(e) => {
			e.preventDefault();
			dispatch('next', true);
		}}>
		{uploads.length ? 'Next' : 'Skip'}
		<ChevronRight size={16} strokeWidth={2.75} class="ml-2 transition group-hover:translate-x-1" />
	</Button>
</Card.Footer>
