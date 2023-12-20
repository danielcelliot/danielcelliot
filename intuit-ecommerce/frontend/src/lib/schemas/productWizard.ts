import { ProductCondition, VariantType } from '$lib/types/medusa';
import { z } from 'zod';

export const productWizardSchema = z.object({
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
	variant_type: z.nativeEnum(VariantType, {
		required_error: 'Product variant type is required'
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
			z
				.string()
				.trim()
				.min(3, {
					message: 'Tag must be between 3 to 16 characters'
				})
				.max(16, {
					message: 'Tag must be between 3 to 16 characters'
				})
		)
		.optional(),

	categories: z
		.array(
			z.object({
				id: z.string().min(1),
				name: z.string().min(1)
			})
		)
		.min(1, {
			message: 'At least one category must be selected'
		}),

	metadata: z.record(
		z.string().max(20, {
			message: 'Name cannot exceed 20 characters'
		}),
		z.string().max(50, {
			message: 'Value cannot exceed 50 characters'
		})
	),

	options: z
		.array(
			z
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
		)
		.default(['Default']),

	variants: z
		.array(
			z.object({
				title: z.string(),
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
					.min(1, {
						message: 'Quantity must be 1 or more'
					}),
				options: z
					.array(
						z.object({
							title: z.string().optional(),
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
					.min(1, {
						message: 'Variant must have at least one option'
					})
			})
		)
		.default([
			{
				title: 'Single',
				options: [
					{
						value: 'Default Value'
					}
				],
				inventory_quantity: 1,
				price: 1
			}
		]),

	files: z.string().optional(),
	thumbnail: z.string().optional()
});

export const generalInfoSchema = productWizardSchema.pick({
	title: true,
	subtitle: true,
	description: true,
	tags: true,
	condition: true,
	variant_type: true
});

export const optionsSchema = productWizardSchema.pick({
	options: true
});

export const variantsSchema = productWizardSchema.pick({
	variants: true
});

export const filesSchema = productWizardSchema.pick({
	files: true
});

export type GeneralInfoSchema = typeof generalInfoSchema;
export type OptionsSchema = typeof optionsSchema;
export type VariantsSchema = typeof variantsSchema;
export type FilesSchema = typeof filesSchema;
export type ProductWizardSchema = typeof productWizardSchema;
