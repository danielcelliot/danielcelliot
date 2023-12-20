import { ProductCondition } from '$lib/types/medusa';
import { z } from 'zod';

export const MAX_FILE_LIMIT = 20;
const MAX_FILE_SIZE = 5;
const MB_IN_BYTES = 1000000;
const ACCEPTED_MIME_TYPES = ['image/jpeg', 'image/pjpeg', 'image/png', 'image/webp'];

export const deleteVariantSchema = z.object({
	product_id: z.string().min(1),
	variant_id: z.string().min(1)
});

export const deleteProductSchema = z.object({
	product_id: z.string().min(1)
});

export const saveImagesSchema = z.object({
	product_id: z.string().min(1),
	files: z.string().optional()
});

export const deleteImagesSchema = z.object({
	product_id: z.string().min(1),
	image_ids: z.string().min(1)
});

export const saveThumbnailSchema = z.object({
	product_id: z.string().min(1),
	image_id: z.string().min(1)
});

export const productOptionsSchema = z.object({
	product_id: z.string().min(1),
	options: z
		.object({
			option_id: z.string().min(1).optional(),
			title: z.string().min(1, {
				message: 'Option title must contain at least one character.'
			})
		})
		.array()
		.min(1, {
			message: 'Please add at least one product option.'
		})
});

export const createVariantSchema = z.object({
	product_id: z.string().min(1),
	title: z.string().min(1, {
		message: 'Variant title must be at least one character'
	}),
	price: z.coerce
		.number({
			invalid_type_error: 'Price must be a number',
			required_error: 'Price is required'
		})
		.nonnegative({
			message: 'Price must be a postive number'
		})
		.min(1, {
			message: 'Price must be $1.00 or greater'
		}),
	inventory_quantity: z.coerce
		.number({
			invalid_type_error: 'Quantity must be a number',
			required_error: 'Quantity is required'
		})
		.int({
			message: 'Quantity must be an integer (non-decimal)'
		})
		.nonnegative({
			message: 'Quantity must be a postive number'
		})
		.min(0, {
			message: 'Quantity must be 0 or more'
		})
		.max(10000),
	options: z
		.array(
			z.object({
				option_id: z.string().min(1),
				title: z.string().min(1),
				value: z
					.string({
						required_error: 'Option cannot be empty'
					})
					.trim()
					.min(1, {
						message: 'Option must be at least 1 character'
					})
					.max(20, {
						message: 'Option cannot exceed 20 characters'
					})
			})
		)
		.optional()
});

export const updateVariantSchema = z.object({
	product_id: z.string().min(1),
	variant_id: z.string().min(1),
	title: z.string().min(1, {
		message: 'Variant title must be at least one character'
	}),
	price: z.coerce
		.number({
			invalid_type_error: 'Price must be a number',
			required_error: 'Price is required'
		})
		.nonnegative({
			message: 'Price must be a postive number'
		})
		.min(1, {
			message: 'Price must be $1.00 or greater'
		}),
	inventory_quantity: z.coerce
		.number({
			invalid_type_error: 'Quantity must be a number',
			required_error: 'Quantity is required'
		})
		.int({
			message: 'Quantity must be an integer (non-decimal)'
		})
		.nonnegative({
			message: 'Quantity must be a postive number'
		})
		.min(0, {
			message: 'Quantity must be 0 or more'
		})
		.max(10000),
	options: z
		.array(
			z.object({
				option_id: z.string().min(1),
				title: z.string().min(1),
				value: z
					.string({
						required_error: 'Option cannot be empty'
					})
					.trim()
					.min(1, {
						message: 'Option must be at least 1 character'
					})
					.max(20, {
						message: 'Option cannot exceed 20 characters'
					})
			})
		)
		.optional(),
	thumbnail: z.string().optional(),
	images: z.string().array().optional()
});

export const imageUploadSchema = z.object({
	files: z
		.instanceof(File)
		.superRefine((file, ctx) => {
			if (!ACCEPTED_MIME_TYPES.includes(file.type)) {
				ctx.addIssue({
					code: z.ZodIssueCode.custom,
					message: 'Image type must be one of PNG, JPG or WebP.'
				});
			}

			if (file.size > MAX_FILE_SIZE * MB_IN_BYTES) {
				ctx.addIssue({
					code: z.ZodIssueCode.too_big,
					type: 'array',
					message: `Your image(s) cannot exceed ${MAX_FILE_SIZE}MB in size`,
					maximum: MAX_FILE_SIZE * MB_IN_BYTES,
					inclusive: true
				});
			}
		})
		.array()
		.max(MAX_FILE_LIMIT, {
			message: `You cannot upload more than ${MAX_FILE_LIMIT} images`
		})
});

export const productStatusSchema = z.object({
	product_id: z.string(),
	status: z.enum(['draft', 'published'])
});

export const updateGeneralInfoSchema = z.object({
	product_id: z.string().min(1),
	title: z
		.string()
		.min(4, {
			message: 'Product name must be 4 characters or more'
		})
		.max(50, {
			message: 'Product name cannot exceed 50 characters'
		}),
	condition: z.nativeEnum(ProductCondition, {
		required_error: 'Product condition is required'
	}),
	subtitle: z
		.string()
		.max(80, {
			message: 'Subtitle cannot exceed 80 characters'
		})
		.optional(),
	description: z
		.string()
		.max(300, {
			message: 'Description cannot exceed 300 characters'
		})
		.optional(),
	tags: z
		.array(
			z.object({
				id: z.string().optional(),
				value: z
					.string()
					.trim()
					.min(3, {
						message: 'Tag must be between 3 to 16 characters'
					})
					.max(16, {
						message: 'Tag must be between 3 to 16 characters'
					})
			})
		)
		.optional()
});

export type ProductOptionsSchema = typeof productOptionsSchema;
export type SaveImagesSchema = typeof saveImagesSchema;
export type DeleteImagesSchema = typeof deleteImagesSchema;
export type SaveThumbnailSchema = typeof saveThumbnailSchema;
export type DeleteVariantSchema = typeof deleteVariantSchema;
export type DeleteProductSchema = typeof deleteProductSchema;
export type UpdateVariantSchema = typeof updateVariantSchema;
export type CreateVariantSchema = typeof createVariantSchema;
export type ImageUploadSchema = typeof imageUploadSchema;
export type ProductStatusSchema = typeof productStatusSchema;
export type UpdateGeneralInfoSchema = typeof updateGeneralInfoSchema;
