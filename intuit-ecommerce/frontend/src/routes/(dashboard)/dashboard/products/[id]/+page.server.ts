import type { Action, Actions, PageServerLoad } from './$types';
import { message, setError, superValidate } from 'sveltekit-superforms/server';
import { error, fail } from '@sveltejs/kit';
import { redirect } from 'sveltekit-flash-message/server';
import { ProductStatus, type Product, type ProductVariantDto } from '$lib/types/medusa';
import {
	createVariantSchema,
	deleteImagesSchema,
	deleteProductSchema,
	deleteVariantSchema,
	imageUploadSchema,
	productStatusSchema,
	saveImagesSchema,
	saveThumbnailSchema,
	updateGeneralInfoSchema,
	updateVariantSchema
} from '$lib/schemas/product';
import { handleAdminLoginRedirect, handleFailedStatus, sign } from '$lib/server/shop';
import { minioClient } from '$lib/server/minio';
import { IMGPROXY_BACKEND_URL, MINIO_BUCKET_NAME } from '$env/static/private';
import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';

const createVariant: Action = async (event) => {
	const form = await superValidate(event.request, createVariantSchema);
	if (!form.valid) return fail(400, { form });

	const variant: ProductVariantDto = {
		title: form.data.title,
		prices: [
			{
				amount: Math.round(form.data.price * 100),
				currency_code: 'usd'
			}
		],
		inventory_quantity: form.data.inventory_quantity,
		options:
			form.data.options?.map((option) => {
				return {
					option_id: option.option_id,
					value: option.value
				};
			}) ?? [],
		manage_inventory: true
	};

	const response = await event.fetch(`/api/admin/products/${form.data.product_id}/variants`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ ...variant })
	});

	if (response.ok)
		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Your new product variant has been created.'
			},
			event
		);

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to create variant.' }, { status: 400 });
};

const updateGeneral: Action = async (event) => {
	const form = await superValidate(event.request, updateGeneralInfoSchema);
	if (!form.valid) return fail(400, { form });

	const { product_id, ...generalInfo } = form.data;
	const response = await event.fetch(`/api/admin/products/${product_id}`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ ...generalInfo })
	});

	if (response.ok)
		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Product details have been updated.'
			},
			event
		);

	await handleFailedStatus(response, event);

	return message(
		form,
		{ type: 'error', text: 'Unable to update product details.' },
		{ status: 400 }
	);
};

const updateVariant: Action = async (event) => {
	const form = await superValidate(event.request, updateVariantSchema);
	if (!form.valid) return fail(400, { form });

	const variant: ProductVariantDto = {
		title: form.data.title,
		prices: [
			{
				amount: Math.round(form.data.price * 100),
				currency_code: PUBLIC_STORE_CURRENCY_CODE
			}
		],
		inventory_quantity: form.data.inventory_quantity,
		options:
			form.data.options?.map((option) => {
				return {
					option_id: option.option_id,
					value: option.value
				};
			}) ?? [],
		manage_inventory: true
	};

	const response = await event.fetch(
		`/api/admin/products/${form.data.product_id}/variants/${form.data.variant_id}`,
		{
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({ ...variant })
		}
	);

	const promises: Promise<Response>[] = [];

	// We need to update the thumbnail with a separate POST request.
	if (form.data.thumbnail) {
		promises.push(
			event.fetch(`/api/admin/products/${form.data.product_id}/variants/${form.data.variant_id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({ thumbnail: form.data.thumbnail })
			})
		);
	}

	// We need to update the images with a separate POST request.
	if (form.data.images?.length) {
		promises.push(
			event.fetch(`/api/admin/products/${form.data.product_id}/variants/${form.data.variant_id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({ images: form.data.images })
			})
		);
	}

	// TODO: check promise status
	await Promise.allSettled(promises);

	if (response.ok)
		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Your product variant has been updated.'
			},
			event
		);

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to save variant.' }, { status: 400 });
};

const delProduct: Action = async (event) => {
	const form = await superValidate(event.request, deleteProductSchema);
	if (!form.valid) return fail(400, { form });

	let response = await event.fetch(`/api/admin/products/${form.data.product_id}`);

	if (response.ok) {
		const products = (await response.json()) as Product[];

		const { images } = products[0];

		if (images.length) {
			// Delete all product images
			const filenames = images
				.map((image) => {
					const encoded_path = new URL(image.url).pathname.split('/').pop();
					if (encoded_path)
						return Buffer.from(encoded_path, 'base64url').toString('utf-8').split('/').pop();
				})
				.filter(
					(filename): filename is Exclude<typeof filename, undefined> => filename !== undefined
				);

			minioClient.removeObjects(MINIO_BUCKET_NAME, filenames, function (e) {
				if (e) {
					console.error(e);
					throw error(500, { message: 'Internal Error' });
				}
			});
		}

		response = await event.fetch(`/api/admin/products/${form.data.product_id}`, {
			method: 'DELETE'
		});

		if (response.ok)
			throw redirect(
				303,
				'/dashboard/products',
				{
					type: 'success',
					message: 'Product has been deleted.'
				},
				event
			);
	}

	await handleFailedStatus(response, event);

	throw redirect(
		event.url.pathname,
		{
			type: 'error',
			message: 'Unable to delete product.'
		},
		event
	);
};

const deleteVariant: Action = async (event) => {
	const form = await superValidate(event.request, deleteVariantSchema);
	if (!form.valid) return fail(400, { form });

	let response = await event.fetch(
		`/api/admin/products/${form.data.product_id}/variants/${form.data.variant_id}`,
		{
			method: 'DELETE'
		}
	);

	if (response.ok) {
		const product = (await response.json()) as Product;

		// Unpublish product if there aren't any variants left
		if (
			product.status === ProductStatus.PUBLISHED &&
			(!product.variants || (product.variants && product.variants.length === 0))
		) {
			response = await event.fetch(`/api/admin/products/${product.id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					status: 'draft'
				})
			});
		}

		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: 'Product variant has been deleted.'
			},
			event
		);
	}

	await handleFailedStatus(response, event);

	throw redirect(
		event.url.pathname,
		{
			type: 'error',
			message: 'Unable to delete product variant.'
		},
		event
	);
};

const selectThumbnail: Action = async (event) => {
	const form = await superValidate(event.request, saveThumbnailSchema);
	if (!form.valid) return fail(400, { form });

	let response = await event.fetch(`/api/admin/products/${form.data.product_id}`);

	if (response.ok) {
		const products = (await response.json()) as Product[];
		const foundImage = products[0].images.find((i) => i.id === form.data.image_id);

		if (foundImage) {
			response = await event.fetch(`/api/admin/products/${products[0].id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					thumbnail: foundImage.url
				})
			});

			if (response.ok)
				throw redirect(
					event.url.pathname,
					{
						type: 'success',
						message: 'Product thumbnail has been updated.'
					},
					event
				);
		}
	}

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to update thumbnail' }, { status: 400 });
};

// TODO: Check image resolution and downscale if res is too high
const saveImages: Action = async (event) => {
	const formData = await event.request.formData();
	const form = await superValidate(formData, saveImagesSchema);
	if (!form.valid) return fail(400, { form });

	const files = formData.getAll('files') as File[];

	// File uploads are not handled by Superforms, so the image needs to be validated by Zod directly
	// https://superforms.rocks/faq#how-to-handle-file-uploads
	const validated = imageUploadSchema.safeParse({ files });

	if (!validated.success) {
		const formatted = validated.error.format();
		const errors: string[] = formatted.files?._errors ?? [];

		return setError(form, 'files', errors);
	}

	let response = await event.fetch(`/api/admin/products/${form.data.product_id}`);

	if (response.ok) {
		const product = (await response.json()) as Product[];

		// 1. get existing product image URLs
		const existingImageUrls = product[0].images.map((i) => i.url);

		// 2. upload new images to S3 bucket
		const newImageUrls: string[] = [];
		for (const file of files) {
			const buffer = Buffer.from(await file.arrayBuffer());
			const file_key = `${crypto.randomUUID()}.${file.name.split('.').pop()}`;

			minioClient.putObject(
				MINIO_BUCKET_NAME,
				file_key,
				buffer,
				file.size,
				{ 'Content-Type': file.type },
				function (e) {
					if (e) {
						console.error(e);
						throw error(500, { message: 'Internal Error' });
					}
				}
			);

			// 3. create signed imgproxy URL
			const path = `s3://${MINIO_BUCKET_NAME}/${file_key}`;
			const encoded_path = Buffer.from(path).toString('base64url');

			const signature = sign(`/${encoded_path}`);
			const result = `/${signature}/${encoded_path}`;

			newImageUrls.push(`${IMGPROXY_BACKEND_URL}${result}`);
		}

		// 4. add existing and signed improxy URLs to product
		const imageUrls = [...existingImageUrls, ...newImageUrls];

		response = await event.fetch(`/api/admin/products/${form.data.product_id}`, {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				images: imageUrls
			})
		});

		if (response.ok)
			throw redirect(
				event.url.pathname,
				{
					type: 'success',
					message: 'Product images have been updated.'
				},
				event
			);
	}

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to update images' }, { status: 400 });
};

const deleteImages: Action = async (event) => {
	const form = await superValidate(event.request, deleteImagesSchema);
	if (!form.valid) return fail(400, { form });

	let response = await event.fetch(`/api/admin/products/${form.data.product_id}`);

	if (response.ok) {
		const products = (await response.json()) as Product[];

		const imageIds = form.data.image_ids.split(',');
		const imagesToDelete = products[0].images.filter((i) => imageIds.includes(i.id));

		if (imagesToDelete.length > 0) {
			const filenames = imagesToDelete
				.map((image) => {
					const encoded_path = new URL(image.url).pathname.split('/').pop();
					if (encoded_path)
						return Buffer.from(encoded_path, 'base64url').toString('utf-8').split('/').pop();
				})
				.filter(
					(filename): filename is Exclude<typeof filename, undefined> => filename !== undefined
				);

			minioClient.removeObjects(MINIO_BUCKET_NAME, filenames, function (e) {
				if (e) {
					console.error(e);
					throw error(500, { message: 'Internal Error' });
				}
			});

			const images = products[0].images.filter((i) => !imageIds.includes(i.id));
			const imageUrls = images.map((i) => i.url);

			response = await event.fetch(`/api/admin/products/${form.data.product_id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					images: imageUrls
				})
			});

			if (response.ok) {
				const product = (await response.json()) as Product;

				if (product.images.length === 0) {
					// Since no product images exist, remove thumbnail url
					response = await event.fetch(`/api/admin/products/${form.data.product_id}`, {
						method: 'POST',
						headers: {
							'Content-Type': 'application/json'
						},
						body: JSON.stringify({
							thumbnail: ''
						})
					});
				}

				throw redirect(
					event.url.pathname,
					{
						type: 'success',
						message: 'Product images have been deleted.'
					},
					event
				);
			}
		}
	}

	await handleFailedStatus(response, event);

	return message(
		form,
		{ type: 'error', text: 'Unable to delete product images.' },
		{ status: 400 }
	);
};

const changeStatus: Action = async (event) => {
	const form = await superValidate(event.request, productStatusSchema);
	if (!form.valid) return fail(400, { form });

	const response = await event.fetch(`/api/admin/products/${form.data.product_id}`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			status: form.data.status
		})
	});

	if (response.ok) {
		const product = (await response.json()) as Product;

		let msg = '';
		if (product.status === ProductStatus.DRAFT) {
			msg = 'Your product has been saved to drafts.';
		} else if (product.status === ProductStatus.PUBLISHED) {
			msg = 'Your product is now live!';
		}

		throw redirect(
			event.url.pathname,
			{
				type: 'success',
				message: msg
			},
			event
		);
	}

	await handleFailedStatus(response, event);

	throw redirect(
		event.url.pathname,
		{
			type: 'error',
			message: 'Unable to change product status.'
		},
		event
	);
};

export const actions: Actions = {
	createVariant,
	updateGeneral,
	updateVariant,
	delProduct,
	deleteVariant,
	selectThumbnail,
	saveImages,
	deleteImages,
	changeStatus
};

export const load: PageServerLoad = async (event) => {
	const getProducts = async () => {
		const response = await event.fetch(`/api/admin/products/${event.params.id}`);

		if (response.ok) return (await response.json()) as Product[];

		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));
		if (response.status === 404) throw error(404, 'Not found');

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [
		products,
		updateVariantForm,
		createVariantForm,
		thumbnailForm,
		saveImgForm,
		deleteImgForm,
		deleteVariantForm,
		deleteProductForm,
		changeStatusForm,
		generalForm
	] = await Promise.all([
		getProducts(),
		superValidate(updateVariantSchema),
		superValidate(createVariantSchema),
		superValidate(saveThumbnailSchema),
		superValidate(saveImagesSchema),
		superValidate(deleteImagesSchema),
		superValidate(deleteVariantSchema),
		superValidate(deleteProductSchema),
		superValidate(productStatusSchema),
		superValidate(updateGeneralInfoSchema)
	]);

	return {
		products,
		updateVariantForm,
		createVariantForm,
		thumbnailForm,
		saveImgForm,
		deleteImgForm,
		deleteVariantForm,
		deleteProductForm,
		changeStatusForm,
		generalForm
	};
};
