import { message, setError, superValidate } from 'sveltekit-superforms/server';
import type { Action, Actions, PageServerLoad } from './$types';
import { error, fail } from '@sveltejs/kit';
import { imageUploadSchema } from '$lib/schemas/product';
import type { ProductCategory, ProductDto } from '$lib/types/medusa';
import { redirect } from 'sveltekit-flash-message/server';
import {
	filesSchema,
	generalInfoSchema,
	optionsSchema,
	productWizardSchema,
	variantsSchema
} from '$lib/schemas/productWizard';
import { handleAdminLoginRedirect, handleFailedStatus, sign } from '$lib/server/shop';
import { minioClient } from '$lib/server/minio';
import { IMGPROXY_BACKEND_URL, MINIO_BUCKET_NAME } from '$env/static/private';
import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';

const create: Action = async (event) => {
	const formData = await event.request.formData();

	const form = await superValidate(formData, productWizardSchema);
	if (!form.valid) return fail(400, { form });

	const files = formData.getAll('files') as File[];

	const uploads: { filename: string; image_url: string }[] = [];

	if (files[0]?.size !== 0) {
		// Superforms does not validate binary files, so the images need to be parsed by Zod directly
		// https://superforms.rocks/faq#how-to-handle-file-uploads
		const validated = imageUploadSchema.safeParse({ files });

		if (!validated.success) {
			const formatted = validated.error.format();
			const errors = formatted.files?.[0]?._errors ?? formatted.files?._errors ?? [];

			return setError(form, 'files', errors);
		}

		// upload images to S3 bucket
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

			// create signed imgproxy URL
			const path = `s3://${MINIO_BUCKET_NAME}/${file_key}`;
			const encoded_path = Buffer.from(path).toString('base64url');

			const signature = sign(`/${encoded_path}`);
			const result = `/${signature}/${encoded_path}`;

			uploads.push({
				filename: file.name,
				image_url: `${IMGPROXY_BACKEND_URL}${result}`
			});
		}

		// find the image chosen as product thumbnail from uploads list
		const found_image = uploads.find((upload) => upload.filename === form.data.thumbnail);
		if (found_image) form.data.thumbnail = found_image.image_url;
	}

	const newProduct: ProductDto = {
		title: form.data.title,
		subtitle: form.data.subtitle,
		description: form.data.description,
		condition: form.data.condition,
		variant_type: form.data.variant_type,
		categories: form.data.categories.map((c) => {
			return {
				id: c.id
			};
		}),
		options: form.data.options.map((o) => {
			return {
				title: o
			};
		}),
		variants: form.data.variants.map((v) => {
			return {
				title: v.title,
				prices: [
					{
						amount: Math.round(v.price * 100),
						currency_code: PUBLIC_STORE_CURRENCY_CODE
					}
				],
				inventory_quantity: v.inventory_quantity,
				options: v.options.map((o) => {
					return {
						value: o.value
					};
				}),
				manage_inventory: true
			};
		}),
		status: 'draft',
		thumbnail: form.data.thumbnail,
		images: uploads.map((u) => u.image_url),
		metadata: form.data.metadata,
		tags: form.data.tags?.map((t) => {
			return {
				value: t
			};
		})
	};

	console.log('Product object:', JSON.stringify(newProduct, null, 2));

	const response = await event.fetch('/api/admin/products', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({ ...newProduct })
	});

	if (response.ok)
		throw redirect(
			303,
			'/dashboard/products',
			{ type: 'success', message: 'Your new product has been created.' },
			event
		);

	await handleFailedStatus(response, event);

	return message(form, { type: 'error', text: 'Unable to create new product.' }, { status: 400 });
};

export const actions: Actions = { create };

export const load: PageServerLoad = async (event) => {
	const fetchProductCategories = async () => {
		const response = await event.fetch('/api/admin/product-categories');

		if (response.ok) return (await response.json()) as ProductCategory[];
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [categories, productForm, generalForm, optionsForm, variantsForm, filesForm] =
		await Promise.all([
			fetchProductCategories(),
			superValidate(productWizardSchema),
			superValidate(generalInfoSchema),
			superValidate(optionsSchema),
			superValidate(variantsSchema),
			superValidate(filesSchema)
		]);

	return {
		categories,
		productForm,
		generalForm,
		optionsForm,
		variantsForm,
		filesForm
	};
};
