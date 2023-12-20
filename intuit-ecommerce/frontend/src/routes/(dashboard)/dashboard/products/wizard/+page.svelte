<script lang="ts">
	import { onMount } from 'svelte';
	import { isEqual } from 'lodash';
	import { formatPrice, getProductCondition } from '$lib/client/shop.js';
	import { VariantType, type ProductCategory } from '$lib/types/medusa.js';
	import { superForm } from 'sveltekit-superforms/client';
	import { productWizardSchema } from '$lib/schemas/productWizard.js';
	import { fade, fly, slide } from 'svelte/transition';
	import { Button } from '$lib/components/ui/button';
	import { Badge } from '$lib/components/ui/badge';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import * as Alert from '$lib/components/ui/alert';
	import * as Card from '$lib/components/ui/card';
	import { AlertCircle, ChevronLeft, ChevronRight, Loader2, Save } from 'lucide-svelte';
	import undraw_online_shopping from '$lib/assets/images/undraw_online_shopping.svg';
	import GeneralInfoForm from '$lib/components/admin/product/wizard/GeneralInfoForm.svelte';
	import CategoriesList from '$lib/components/admin/product/wizard/CategoriesList.svelte';
	import FeaturesTable from '$lib/components/admin/product/wizard/FeaturesTable.svelte';
	import OptionsList from '$lib/components/admin/product/wizard/OptionsList.svelte';
	import VariantsList from '$lib/components/admin/product/wizard/VariantsList.svelte';
	import ImagesUpload from '$lib/components/admin/product/wizard/ImagesUpload.svelte';
	import ThumbnailList from '$lib/components/admin/product/wizard/ThumbnailList.svelte';

	export let data;

	const { form, message, enhance, delayed, allErrors } = superForm(data.productForm, {
		delayMs: 500,
		timeoutMs: 8000,
		validators: productWizardSchema,
		dataType: 'json',
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

	function populateFileInput() {
		const data = new DataTransfer();
		for (const u of uploads) {
			data.items.add(u);
		}
		hiddenFileInput.files = data.files;
	}

	let hiddenFileInput: HTMLInputElement;
	let disabled: boolean;

	// Steps
	let showIntro: boolean;
	let showGeneralStep: boolean;
	let showCategoriesStep: boolean;
	let showSpecificationsStep: boolean;
	let showOptionsStep: boolean;
	let showVariantsStep: boolean;
	let showUploadsStep: boolean;
	let showThumbnailStep: boolean;
	let showOutro: boolean;

	// Categories step
	let { categories } = data;
	let currentList: ProductCategory[];
	let completed: boolean;

	// Options step
	let defaultOption = $form.options[0];

	// Variants step
	let defaultVariant = $form.variants[0];

	// Uploads step
	let uploads: File[] = [];

	onMount(() => (showIntro = true));
</script>

<main class="container px-2 min-[380px]:px-4">
	<form action="?/create" method="post" enctype="multipart/form-data" use:enhance>
		<input multiple type="file" name="files" class="hidden" bind:this={hiddenFileInput} />

		<Card.Root class="mt-6 h-[calc(100dvh-180px)] rounded-2xl shadow">
			<!-- Welcome and introduction -->
			{#if showIntro}
				<div class="flex h-full flex-col">
					<div
						in:fade={{ delay: 1250, duration: 1000 }}
						id="header"
						class="flex flex-col items-center justify-center gap-1 pt-6">
						<h1 class="text-2xl font-semibold tracking-tight">New Product Wizard</h1>
						<p class="text-sm text-muted-foreground">Create new product.</p>
					</div>

					<div id="content" class="flex-1 p-6">
						<div class="mt-2 flex flex-col items-center justify-center gap-12">
							<img
								in:fade={{ delay: 500, duration: 1000 }}
								src={undraw_online_shopping}
								alt=""
								class="w-64" />

							<div in:fly={{ delay: 1250, duration: 1000, y: 30 }}>
								<Button
									class="w-40 rounded-2xl font-semibold"
									on:click={(e) => {
										e.preventDefault();
										showIntro = false;
										showGeneralStep = true;
									}}>
									Click to begin
								</Button>
							</div>
						</div>
					</div>

					<div id="footer" class="flex justify-end"></div>
				</div>
			{/if}

			<!-- Step 1: General information -->
			{#if showGeneralStep}
				<div class="flex h-full flex-col" in:fly>
					<GeneralInfoForm
						form={data.generalForm}
						formData={{
							title: $form.title,
							subtitle: $form.subtitle,
							condition: $form.condition,
							variant_type: $form.variant_type,
							description: $form.description,
							tags: $form.tags
						}}
						on:next={(e) => {
							$form.title = e.detail.title;
							$form.subtitle = e.detail.subtitle;
							$form.condition = e.detail.condition;
							$form.description = e.detail.description;
							$form.tags = e.detail.tags;

							if ($form.variant_type !== e.detail.variant_type) {
								$form.variant_type = e.detail.variant_type;
								if ($form.variant_type === VariantType.MULTI) {
									$form.variants = [];
									$form.options = [];
								} else {
									$form.variants = [defaultVariant];
									$form.options = [defaultOption];
								}
							}

							showGeneralStep = false;
							showCategoriesStep = true;
						}} />
				</div>
			{/if}

			<!-- Step 2: Product categories -->
			{#if showCategoriesStep}
				<div class="flex h-full flex-col" in:fly>
					<CategoriesList
						categories={categories ?? []}
						bind:selected={$form.categories}
						bind:completed
						bind:currentList
						on:prev={(e) => {
							if (e.detail) {
								showCategoriesStep = false;
								showGeneralStep = true;
							}
						}}
						on:next={(e) => {
							if (e.detail) {
								showCategoriesStep = false;
								showSpecificationsStep = true;
							}
						}} />
				</div>
			{/if}

			<!-- Step 3: Product specifications -->
			{#if showSpecificationsStep}
				<div class="flex h-full flex-col" in:fly>
					<FeaturesTable
						bind:list={$form.metadata}
						on:prev={(e) => {
							if (e.detail) {
								showSpecificationsStep = false;
								showCategoriesStep = true;
							}
						}}
						on:next={(e) => {
							if (e.detail) {
								showSpecificationsStep = false;
								$form.variant_type === VariantType.MULTI
									? (showOptionsStep = true)
									: (showVariantsStep = true);
							}
						}} />
				</div>
			{/if}

			<!-- Step 4: Product options -->
			{#if showOptionsStep}
				<div class="flex h-full flex-col" in:fly>
					<OptionsList
						form={data.optionsForm}
						formData={$form.options}
						on:prev={(e) => {
							if (!isEqual($form.options, e.detail)) {
								$form.options = e.detail;
								$form.variants = [];
							}

							showOptionsStep = false;
							showSpecificationsStep = true;
						}}
						on:next={(e) => {
							if (!isEqual($form.options, e.detail)) {
								$form.options = e.detail;
								$form.variants = [];
							}

							showOptionsStep = false;
							showVariantsStep = true;
						}} />
				</div>
			{/if}

			<!-- Step 5: Product variants -->
			{#if showVariantsStep}
				<div class="flex h-full flex-col" in:fly>
					<VariantsList
						form={data.variantsForm}
						list={$form.variants}
						options={$form.options}
						variantType={$form.variant_type}
						on:prev={(e) => {
							$form.variants = e.detail;

							showVariantsStep = false;
							$form.variant_type === VariantType.MULTI
								? (showOptionsStep = true)
								: (showSpecificationsStep = true);
						}}
						on:next={(e) => {
							$form.variants = e.detail;

							showVariantsStep = false;
							showUploadsStep = true;
						}} />
				</div>
			{/if}

			<!-- Step 6: Image uploads -->
			{#if showUploadsStep}
				<div class="flex h-full flex-col" in:fly>
					<ImagesUpload
						form={data.filesForm}
						bind:uploads
						on:prev={(e) => {
							if (e.detail) {
								const found = uploads.some((file) => file.name === $form.thumbnail);
								if (!found) $form.thumbnail = undefined;
								populateFileInput();

								showUploadsStep = false;
								showVariantsStep = true;
							}
						}}
						on:next={(e) => {
							if (e.detail) {
								const found = uploads.some((file) => file.name === $form.thumbnail);
								if (!found) $form.thumbnail = undefined;
								populateFileInput();

								showUploadsStep = false;
								uploads.length ? (showThumbnailStep = true) : (showOutro = true);
							}
						}} />
				</div>
			{/if}

			<!-- Step 7: Choose thumbnail -->
			{#if showThumbnailStep}
				<div class="flex h-full flex-col" in:fly>
					<ThumbnailList
						{uploads}
						bind:selected={$form.thumbnail}
						on:prev={(e) => {
							if (e.detail) {
								showThumbnailStep = false;
								showUploadsStep = true;
							}
						}}
						on:next={(e) => {
							if (e.detail) {
								showThumbnailStep = false;
								showOutro = true;
							}
						}} />
				</div>
			{/if}

			<!-- Step 8: Review and Finalize -->
			{#if showOutro}
				<div class="flex h-full flex-col" in:fly>
					<div id="header" class="flex flex-col space-y-1.5 p-6">
						<h3 class="font-semibold leading-none tracking-tight">Review & Save</h3>
						<p class="text-sm text-muted-foreground">
							Review the information that you entered for your product. Click save once you're done.
						</p>
					</div>

					<div id="content" class="flex-1 space-y-9 overflow-y-auto overscroll-contain px-6 py-0.5">
						{#if $message}
							<div transition:slide>
								<Alert.Root variant="destructive">
									<AlertCircle class="h-4 w-4" />
									<Alert.Title>Error</Alert.Title>
									<Alert.Description>
										{$message}
									</Alert.Description>
								</Alert.Root>
							</div>
						{/if}

						{#if $allErrors.length}
							<div transition:slide>
								<Alert.Root variant="destructive">
									<AlertCircle class="h-4 w-4" />
									<Alert.Title>Error</Alert.Title>
									<Alert.Description>
										<ul class="grid gap-2">
											{#each $allErrors as error}
												<li>
													<span class="font-semibold">{error.path}:</span>
													{error.messages.join('. ')}
												</li>
											{/each}
										</ul>
									</Alert.Description>
								</Alert.Root>
							</div>
						{/if}

						<!-- General information -->
						<div class="grid gap-2">
							<p class="text-sm font-medium leading-none">General information</p>

							<div class="space-y-1 text-xs font-medium leading-5">
								<div class="flex justify-between">
									<p class="mr-2 text-muted-foreground">Product name</p>
									<p class="truncate text-right">{$form.title}</p>
								</div>

								<div class="flex justify-between">
									<p class="mr-2 text-muted-foreground">Condition</p>
									<p class="font-normal">{getProductCondition($form.condition)}</p>
								</div>

								<div class="flex justify-between">
									<p class="mr-2 text-muted-foreground">Subtitle</p>
									<p class="truncate text-right font-normal">{$form.subtitle ?? '-'}</p>
								</div>

								<div class="flex justify-between">
									<p class="mr-2 text-muted-foreground">Description</p>
									<p class="flex-wrap text-right font-normal">{$form.description ?? '-'}</p>
								</div>

								{#if $form.variant_type === VariantType.SINGLE}
									<div class="flex justify-between">
										<p class="text-muted-foreground">Price</p>
										<p class="font-normal">{formatPrice($form.variants[0].price * 100)}</p>
									</div>

									<div class="flex justify-between">
										<p class="text-muted-foreground">Quantity</p>
										<p class="font-normal">{$form.variants[0].inventory_quantity}</p>
									</div>
								{/if}

								<div class="flex items-center justify-between">
									<p class="mr-3 text-muted-foreground">Tags</p>
									{#if $form.tags?.length}
										<div class="flex flex-wrap gap-2">
											{#each $form.tags as tag}
												<Badge variant="outline">{tag}</Badge>
											{/each}
										</div>
									{:else}
										<p>-</p>
									{/if}
								</div>
							</div>
						</div>

						<!-- Categories -->
						<div class="grid gap-2">
							<p class="text-sm font-medium leading-none">Categories</p>

							<div class="flex flex-wrap items-center space-x-2">
								{#each $form.categories as { name }, i}
									<p class="text-xs font-normal leading-none">{name}</p>
									{#if i !== $form.categories.length - 1}
										<ChevronRight class="text-muted-foreground" size={16} />
									{/if}
								{/each}
							</div>
						</div>

						<!-- Specifications & Features -->
						{#if Object.entries($form.metadata).length}
							<div class="grid gap-2">
								<p class="text-sm font-medium leading-none">Specifications & Features</p>

								{#each Object.entries($form.metadata) as [key, value]}
									<div class="flex justify-between text-xs font-medium">
										<p class="mr-2 text-muted-foreground">{key}</p>
										<p class="truncate font-normal">{value}</p>
									</div>
								{/each}
							</div>
						{/if}

						<!-- Options -->
						{#if $form.variant_type === VariantType.MULTI}
							<div class="grid gap-2">
								<p class="text-sm font-medium leading-none">Options</p>

								<div class="flex flex-wrap space-x-2">
									{#each $form.options as option}
										<Badge variant="secondary">{option}</Badge>
									{/each}
								</div>
							</div>
						{/if}

						<!-- Variants -->
						{#if $form.variant_type === VariantType.MULTI}
							<div class="grid gap-2">
								<p class="text-sm font-medium leading-none">Variants</p>

								<div class="grid divide-y">
									{#each $form.variants as _, i}
										<div class="flex flex-col gap-1 py-2 text-xs first:pt-0">
											<div class="flex justify-between">
												<p class="col-span-2 truncate font-semibold">{$form.variants[i].title}</p>
												<p class="ml-2">
													{new Intl.NumberFormat('en-US', {
														style: 'currency',
														currency: 'usd',
														minimumFractionDigits: 2
													}).format($form.variants[i].price)}
												</p>
											</div>

											<p class="font-medium">
												<span class="text-muted-foreground">Quantity:</span>
												{$form.variants[i].inventory_quantity}
											</p>
										</div>
									{/each}
								</div>
							</div>
						{/if}

						<!-- Images -->
						{#if uploads.length}
							<div class="grid gap-2">
								<p class="text-sm font-medium leading-none">Images</p>

								<div class="flex flex-wrap gap-2">
									{#each uploads as upload}
										<div class="w-[80px] overflow-hidden rounded-lg">
											<AspectRatio ratio={3 / 4} class="flex items-center">
												<img
													class="rounded-lg object-cover"
													src={URL.createObjectURL(upload)}
													alt="" />
											</AspectRatio>
										</div>
									{/each}
								</div>
							</div>
						{/if}

						<!-- Thumbnail -->
						{#if uploads.length}
							<div class="grid gap-2">
								<p class="text-sm font-medium leading-none">Selected Thumbnail</p>

								{#each uploads as upload}
									{#if upload.name === $form.thumbnail}
										<div class="w-[120px] overflow-hidden rounded-lg">
											<AspectRatio ratio={3 / 4} class="flex items-center">
												<img
													class="rounded-lg object-cover"
													src={URL.createObjectURL(upload)}
													alt="" />
											</AspectRatio>
										</div>
									{/if}
								{/each}
							</div>
						{/if}
					</div>

					<div id="footer" class="flex justify-between p-6">
						<Button
							variant="ghost"
							class="group w-28 rounded-2xl font-semibold"
							on:click={(e) => {
								e.preventDefault();
								showOutro = false;
								uploads.length ? (showThumbnailStep = true) : (showUploadsStep = true);
							}}>
							<ChevronLeft
								size={16}
								strokeWidth={2.75}
								class="mr-2 transition group-hover:-translate-x-1" />
							Back
						</Button>

						<Button {disabled} class="w-28 rounded-2xl font-semibold" type="submit">
							{#if $delayed}
								<Loader2 class="h-4 w-4 animate-spin" />
							{:else}
								<Save size={16} strokeWidth={2.75} class="mr-2" />
								Save
							{/if}
						</Button>
					</div>
				</div>
			{/if}
		</Card.Root>
	</form>
</main>
