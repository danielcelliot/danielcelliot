<script lang="ts">
	import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';
	import {
		ProductStatus,
		type Product,
		type ProductPrice,
		type ProductVariant,
		VariantType
	} from '$lib/types/medusa';
	import type { ProductVariantFormData } from '$lib/types/shop';
	import {
		convertToDecimal,
		filterOption,
		formatPrice,
		getProductCondition
	} from '$lib/client/shop';
	import { superForm } from 'sveltekit-superforms/client';
	import { ArrowLeft, CopyPlus, Image, ImagePlus, Loader2, PenSquare } from 'lucide-svelte';
	import { Badge } from '$lib/components/ui/badge';
	import { Separator } from '$lib/components/ui/separator';
	import { Button } from '$lib/components/ui/button';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import * as Card from '$lib/components/ui/card';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as AlertDialog from '$lib/components/ui/alert-dialog';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import * as Accordion from '$lib/components/ui/accordion';
	import ProductThumbnailForm from '$lib/components/admin/product/ProductThumbnailForm.svelte';
	import ProductImagesForm from '$lib/components/admin/product/ProductImagesForm.svelte';
	import UpdateVariantForm from '$lib/components/admin/product/UpdateVariantForm.svelte';
	import CreateVariantForm from '$lib/components/admin/product/CreateVariantForm.svelte';
	import type { FloatingConfig } from '@melt-ui/svelte/internal/actions';
	import EditGeneralForm from '$lib/components/admin/product/EditGeneralForm.svelte';
	import { mode } from 'mode-watcher';

	export let data;

	let product: Product | null;

	$: ({ products } = data);
	$: product = products && products.length > 0 ? products[0] : null;
	// $: console.log('Product', product);

	let variantId: string;
	let variantFormData: ProductVariantFormData;

	let productStatus: 'draft' | 'published';

	let openCreateVariantModal = false;
	let openUpdateVariantModal = false;
	let openDeleteVariantModal = false;
	let openThumbnailModal = false;
	let openMediaModal = false;
	let openDeleteProductModal = false;
	let openGeneralModal = false;

	let disabled = false;
	const { enhance, delayed } = superForm(data.deleteVariantForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') openDeleteVariantModal = false;
			disabled = false;
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) disabled = false;
		},
		onError() {
			disabled = false;
		}
	});

	let delDisabled = false;
	const { enhance: delEnhance, delayed: delDelayed } = superForm(data.deleteProductForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') openDeleteProductModal = false;
			delDisabled = false;
		},
		onSubmit() {
			delDisabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) delDisabled = false;
		},
		onError() {
			delDisabled = false;
		}
	});

	let statusDisabled = false;
	const { enhance: statusEnhance, delayed: statusDelayed } = superForm(data.changeStatusForm, {
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onResult() {
			statusDisabled = false;
		},
		onSubmit() {
			statusDisabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) statusDisabled = false;
		},
		onError() {
			statusDisabled = false;
		}
	});

	const tooltipPosLeft: FloatingConfig = {
		placement: 'left'
	};

	function getPriceByCurrency(currency_code: string, priceList: ProductPrice[]) {
		return priceList.find((price) => price.currency_code === currency_code)?.amount;
	}

	function populateForm(product: Product, variant: ProductVariant) {
		const amount = getPriceByCurrency(PUBLIC_STORE_CURRENCY_CODE, variant.prices ?? []);

		variantFormData = {
			product_id: product.id,
			variant_id: variant.id,
			title: variant.title,
			price: amount ? convertToDecimal(amount) : 0.0,
			inventory_quantity: variant.inventory_quantity,
			options: product.options?.map((option) => {
				return {
					option_id: option.id,
					title: option.title,
					value: variant.options.find((o) => o.option_id == option.id)?.value ?? ''
				};
			}),
			thumbnail: variant.thumbnail,
			images: variant.images.map((i) => i.url)
		};
	}
</script>

<main class="container px-2 min-[380px]:px-4">
	<a
		href="/dashboard/products{product?.id ? `#${product.id}` : ''}"
		class="group my-4 flex w-fit items-center text-foreground">
		<ArrowLeft size={16} class="mr-2" />
		<span class="text-sm font-medium underline-offset-4 group-hover:underline">
			Back to Products
		</span>
	</a>

	{#if product}
		<Dialog.Root bind:open={openCreateVariantModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Create new product variant</Dialog.Title>
					<Dialog.Description class="text-left">
						Make changes to your product variant. Click save when you're done.
					</Dialog.Description>
				</Dialog.Header>
				<CreateVariantForm
					href="?/createVariant"
					variantForm={data.createVariantForm}
					options={product.options}
					productId={product.id}
					on:view={(event) => (openCreateVariantModal = event.detail.show)} />
			</Dialog.Content>
		</Dialog.Root>

		<Dialog.Root bind:open={openGeneralModal} openFocus={null}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Edit General Information</Dialog.Title>
					<Dialog.Description class="text-left">
						Edit general information about your product. Click save when you're done.
					</Dialog.Description>
				</Dialog.Header>
				<EditGeneralForm
					href="?/updateGeneral"
					form={data.generalForm}
					formData={{
						product_id: product.id,
						condition: product.condition,
						title: product.title,
						description: product.description ?? undefined,
						subtitle: product.subtitle ?? undefined,
						tags: product.tags?.map((t) => {
							return {
								id: t.id,
								value: t.value
							};
						})
					}}
					on:view={(event) => (openGeneralModal = event.detail.show)} />
			</Dialog.Content>
		</Dialog.Root>

		<Dialog.Root bind:open={openUpdateVariantModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Update product variant</Dialog.Title>
					<Dialog.Description class="text-left">
						Make changes to your product variant. Click save when you're done.
					</Dialog.Description>
				</Dialog.Header>
				<UpdateVariantForm
					href="?/updateVariant"
					variantForm={data.updateVariantForm}
					variantData={variantFormData}
					{product}
					on:view={(event) => (openUpdateVariantModal = event.detail.show)} />
			</Dialog.Content>
		</Dialog.Root>

		<AlertDialog.Root bind:open={openDeleteVariantModal} closeOnOutsideClick={true}>
			<AlertDialog.Content class="rounded-xl">
				<AlertDialog.Header>
					<AlertDialog.Title>Delete variant?</AlertDialog.Title>
					<AlertDialog.Description>
						This action cannot be undone. This will permanently delete your product variant.
					</AlertDialog.Description>
				</AlertDialog.Header>
				<AlertDialog.Footer>
					<AlertDialog.Cancel class="rounded-2xl font-semibold">Cancel</AlertDialog.Cancel>
					<form action="?/deleteVariant" method="post" use:enhance>
						<input type="hidden" name="product_id" value={product.id} />
						<input type="hidden" name="variant_id" value={variantId} />

						<div class={disabled ? 'cursor-not-allowed' : ''}>
							<Button
								{disabled}
								variant="destructive"
								type="submit"
								class="w-full rounded-2xl font-semibold">
								{#if $delayed}
									<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
								{/if}
								<span>{$delayed ? 'Deleting...' : 'Delete'}</span>
							</Button>
						</div>
					</form>
				</AlertDialog.Footer>
			</AlertDialog.Content>
		</AlertDialog.Root>

		<AlertDialog.Root bind:open={openDeleteProductModal} closeOnOutsideClick={true}>
			<AlertDialog.Content class="rounded-xl">
				<AlertDialog.Header>
					<AlertDialog.Title>Delete product?</AlertDialog.Title>
					<AlertDialog.Description>
						This action cannot be undone. This will permanently delete your product.
					</AlertDialog.Description>
				</AlertDialog.Header>
				<AlertDialog.Footer>
					<AlertDialog.Cancel class="rounded-2xl font-semibold">Cancel</AlertDialog.Cancel>
					<form action="?/delProduct" method="post" use:delEnhance>
						<input type="hidden" name="product_id" value={product.id} />

						<div class={delDisabled ? 'cursor-not-allowed' : ''}>
							<Button
								disabled={delDisabled}
								variant="destructive"
								type="submit"
								class="w-full rounded-2xl font-semibold">
								{#if $delDelayed}
									<Loader2 strokeWidth={2.75} class="mr-4 h-4 w-4 animate-spin" />
								{/if}
								<span>{$delDelayed ? 'Deleting...' : 'Delete'}</span>
							</Button>
						</div>
					</form>
				</AlertDialog.Footer>
			</AlertDialog.Content>
		</AlertDialog.Root>

		<Dialog.Root bind:open={openThumbnailModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Change Thumbnail</Dialog.Title>
					<Dialog.Description class="text-left">
						Select a new image as your product thumbnail. Click save when you're done.
					</Dialog.Description>
				</Dialog.Header>
				<ProductThumbnailForm
					href="?/selectThumbnail"
					thumbnailForm={data.thumbnailForm}
					productId={product.id}
					images={product.images}
					on:view={(event) => (openThumbnailModal = event.detail.open)} />
			</Dialog.Content>
		</Dialog.Root>

		<Dialog.Root bind:open={openMediaModal}>
			<Dialog.Content class="max-h-[100dvh] max-w-[350px] overflow-y-scroll rounded-xl">
				<Dialog.Header>
					<Dialog.Title class="text-left text-base">Edit media</Dialog.Title>
					<Dialog.Description class="text-left">
						Upload your product images. Click save when you're done.
					</Dialog.Description>
				</Dialog.Header>
				<ProductImagesForm
					href="?/saveImages"
					saveForm={data.saveImgForm}
					deleteForm={data.deleteImgForm}
					productId={product.id}
					images={product.images}
					on:view={(event) => (openMediaModal = event.detail.open)} />
			</Dialog.Content>
		</Dialog.Root>

		<div class="space-y-2 pb-2">
			<!-- General Information -->
			<Card.Root class="px-3 py-4 shadow-none">
				<div class="space-y-2">
					<div class="flex items-center justify-between">
						<h3 class="truncate text-lg font-semibold">{product.title}</h3>

						<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
							<Tooltip.Trigger asChild let:builder>
								<Button
									builders={[builder]}
									size="icon"
									variant={$mode === 'light' ? 'ghost' : 'outline'}
									class="ml-2 h-8 w-[60px] rounded-2xl shadow hover:text-green-500"
									on:click={() => (openGeneralModal = true)}>
									<PenSquare strokeWidth={2.75} class="h-4 w-4" />
								</Button>
							</Tooltip.Trigger>
							<Tooltip.Content
								class="bg-background font-medium text-foreground shadow-md
                  dark:bg-foreground dark:text-background">
								<span>Edit details</span>
							</Tooltip.Content>
						</Tooltip.Root>
					</div>

					<p class="text-sm font-normal text-muted-foreground">
						{product.description ?? ''}
					</p>
				</div>

				<Separator class="my-4" />

				<div class="flex flex-col space-y-1.5">
					<div class="flex items-baseline justify-between">
						<p class="mr-2 truncate text-xs font-semibold">Condition</p>

						<p class="truncate text-xs font-normal text-muted-foreground">
							{getProductCondition(product.condition)}
						</p>
					</div>

					<div class="flex items-baseline justify-between">
						<p class="mr-2 truncate text-xs font-semibold">Subtitle</p>

						<p class="truncate text-xs font-normal text-muted-foreground">
							{product.subtitle ?? '-'}
						</p>
					</div>

					<div class="flex items-baseline justify-between">
						<p class="mr-2 text-xs font-semibold">Categories</p>

						<p class="truncate text-xs font-normal text-muted-foreground">
							{product.categories && product.categories.length
								? product.categories?.map((c) => c.name).join(', ')
								: '-'}
						</p>
					</div>

					<div class="flex items-baseline justify-between">
						<p class="mr-3 text-xs font-semibold">Tags</p>
						{#if product.tags && product.tags.length}
							<div class="flex flex-wrap gap-2">
								{#each product.tags as tag}
									<Badge variant="outline">{tag.value}</Badge>
								{/each}
							</div>
						{:else}
							<p class="text-xs font-normal text-muted-foreground">-</p>
						{/if}
					</div>

					{#if product.variants?.length}
						<div class="pt-4">
							<form action="?/changeStatus" method="post" use:statusEnhance>
								<input type="hidden" name="product_id" value={product.id} />
								<input type="hidden" name="status" value={productStatus} />

								{#if product.status === ProductStatus.DRAFT}
									<Button
										disabled={statusDisabled}
										on:click={() => (productStatus = ProductStatus.PUBLISHED)}
										type="submit"
										size="sm"
										class="w-full rounded-2xl font-semibold">
										{#if $statusDelayed}
											<Loader2 strokeWidth={2.75} class="mr-2 h-4 w-4 animate-spin" />
										{/if}
										<span>{$statusDelayed ? 'Publishing...' : 'Publish Product'}</span>
									</Button>
								{:else if product.status === ProductStatus.PUBLISHED}
									<Button
										disabled={statusDisabled}
										on:click={() => (productStatus = ProductStatus.DRAFT)}
										type="submit"
										size="sm"
										variant="outline"
										class="w-full rounded-2xl font-semibold">
										{#if $statusDelayed}
											<Loader2 strokeWidth={2.75} class="mr-2 h-4 w-4 animate-spin" />
										{/if}
										<span>{$statusDelayed ? 'Saving...' : 'Save as Draft'}</span>
									</Button>
								{/if}
							</form>
						</div>
					{/if}
				</div>
			</Card.Root>

			<!-- Product Options -->
			{#if product.variant_type === VariantType.MULTI}
				<Card.Root class="px-3 py-4 shadow-none">
					<div class="flex flex-col">
						<h4 class="mb-6 mt-2 text-sm font-semibold leading-none">Options</h4>

						{#if product.options}
							<div class="space-y-2">
								{#each product.options as productOption}
									<div class="space-y-1">
										<p class="text-xs font-semibold">{productOption.title}</p>

										<div class="flex flex-wrap justify-start gap-1">
											{#each filterOption(productOption) as option}
												<Badge variant="secondary">
													{option.value === 'Default Value' ? 'Default' : option.value}
												</Badge>
											{/each}
										</div>
									</div>
								{/each}
							</div>
						{/if}
					</div>
				</Card.Root>
			{/if}

			<!-- Product Variants -->
			<Card.Root class="px-3 py-4 shadow-none">
				{#if product.variant_type === VariantType.MULTI}
					<div class="mb-6 flex items-center justify-between">
						<h4 class="text-sm font-semibold leading-none">
							Variants ({product.variants?.length})
						</h4>

						<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
							<Tooltip.Trigger asChild let:builder>
								<Button
									builders={[builder]}
									size="icon"
									variant={$mode === 'light' ? 'ghost' : 'outline'}
									class="h-8 w-[60px] rounded-2xl font-semibold shadow hover:text-green-500"
									on:click={() => {
										openCreateVariantModal = true;
									}}>
									<CopyPlus strokeWidth={2.75} class="h-4 w-4" />
								</Button>
							</Tooltip.Trigger>
							<Tooltip.Content
								class="bg-background font-medium text-foreground shadow-md
                  dark:bg-foreground dark:text-background">
								<span>Add variant</span>
							</Tooltip.Content>
						</Tooltip.Root>
					</div>
				{:else}
					<h4 class="mb-6 mt-2 text-sm font-semibold leading-none">Variant</h4>
				{/if}

				{#if product.variants && product.variants.length > 0}
					<Accordion.Root class="w-full sm:max-w-[70%]">
						{#each product.variants as variant, i}
							<Accordion.Item value="item-{i}" class="hover:bg-foreground/5">
								<Accordion.Trigger class="py-2 font-normal hover:no-underline">
									<div class="grid w-full grid-cols-6 items-center px-2">
										<div class="col-span-3 flex items-center">
											<div class="mr-2 w-[40px] overflow-hidden rounded-md">
												<AspectRatio ratio={3 / 4} class="flex items-center">
													{#if variant.thumbnail || product.thumbnail}
														<img
															class="rounded-md object-cover"
															src={variant.thumbnail ?? product.thumbnail}
															alt="" />
													{:else}
														<Image strokeWidth={1} class="h-full w-full" />
													{/if}
												</AspectRatio>
											</div>

											<p class="truncate text-xs">
												{variant.title.length > 0 ? variant.title : '-'}
											</p>
										</div>

										<p class="justify-self-end text-xs">{variant.inventory_quantity}</p>

										<p class="col-span-2 justify-self-end text-xs">
											{formatPrice(
												getPriceByCurrency(PUBLIC_STORE_CURRENCY_CODE, variant.prices ?? []) ?? 0
											)}
										</p>
									</div>
								</Accordion.Trigger>
								<Accordion.Content>
									<div class="flex flex-col">
										<div class="flex gap-1 px-2 py-1">
											{#each variant.images as { url }}
												<div class="w-[40px] overflow-hidden rounded-md">
													<AspectRatio ratio={3 / 4} class="flex items-center">
														<img class="rounded-md object-cover" src={url} alt="" />
													</AspectRatio>
												</div>
											{/each}
										</div>
										<div class="flex items-center justify-end space-x-2">
											<Button
												size="sm"
												variant="secondary"
												class="w-24 rounded-2xl font-semibold shadow"
												on:click={() => {
													if (product) populateForm(product, variant);
													openUpdateVariantModal = true;
												}}>
												<PenSquare size={12} strokeWidth={2.75} class="mr-2" />
												<span>Edit</span>
											</Button>

											{#if product.variant_type === VariantType.MULTI}
												<Button
													size="sm"
													variant="link"
													class="font-semibold text-foreground"
													on:click={() => {
														variantId = variant.id;
														openDeleteVariantModal = true;
													}}>
													<span>Delete</span>
												</Button>
											{/if}
										</div>
									</div>
								</Accordion.Content>
							</Accordion.Item>
						{/each}
					</Accordion.Root>
				{/if}
			</Card.Root>

			<!-- Product Thumbnail -->
			{#if product.images.length}
				<Card.Root class="px-3 py-4 shadow-none">
					<div class="mb-6 flex items-center justify-between">
						<h4 class="text-sm font-semibold leading-none">Thumbnail</h4>

						<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
							<Tooltip.Trigger asChild let:builder>
								<Button
									builders={[builder]}
									size="sm"
									variant={$mode === 'light' ? 'ghost' : 'outline'}
									class="h-8 w-[60px] rounded-2xl shadow hover:text-green-500"
									on:click={() => (openThumbnailModal = true)}>
									<Image strokeWidth={2.75} class="h-4 w-4" />
								</Button>
							</Tooltip.Trigger>
							<Tooltip.Content
								class="bg-background font-medium text-foreground shadow-md
                  dark:bg-foreground dark:text-background">
								<span>Select thumbnail</span>
							</Tooltip.Content>
						</Tooltip.Root>
					</div>

					{#if product.thumbnail}
						<div class="m-auto w-[160px] overflow-hidden rounded-lg">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-lg object-cover" src={product.thumbnail} alt="" />
							</AspectRatio>
						</div>
					{/if}
				</Card.Root>
			{/if}

			<!-- Product Images -->
			<Card.Root class="px-3 py-4 shadow-none">
				<div class="mb-6 flex items-center justify-between">
					<h4 class="text-sm font-semibold leading-none">Media</h4>

					<Tooltip.Root openDelay={100} positioning={tooltipPosLeft}>
						<Tooltip.Trigger asChild let:builder>
							<Button
								builders={[builder]}
								size="sm"
								variant={$mode === 'light' ? 'ghost' : 'outline'}
								class="h-8 w-[60px] rounded-2xl shadow hover:text-green-500"
								on:click={() => (openMediaModal = true)}>
								<ImagePlus strokeWidth={2.75} class="h-4 w-4" />
							</Button>
						</Tooltip.Trigger>
						<Tooltip.Content
							class="bg-background font-medium text-foreground shadow-md
                dark:bg-foreground dark:text-background">
							<span>{product.images.length ? 'Edit media' : 'Add media'}</span>
						</Tooltip.Content>
					</Tooltip.Root>
				</div>

				<div class="grid grid-cols-3 items-center justify-items-center gap-y-1">
					{#each product.images as image}
						<div class="w-[90px] overflow-hidden rounded-lg">
							<AspectRatio ratio={3 / 4} class="flex items-center">
								<img class="rounded-lg object-cover" src={image.url} alt="" />
							</AspectRatio>
						</div>
					{/each}
				</div>
			</Card.Root>

			<div class="flex justify-center">
				<Button
					variant="link"
					size="sm"
					class="font-semibold text-foreground"
					on:click={(e) => {
						e.preventDefault();
						openDeleteProductModal = true;
					}}>
					Delete Product
				</Button>
			</div>
		</div>
	{:else}
		Cannot find product
	{/if}
</main>
