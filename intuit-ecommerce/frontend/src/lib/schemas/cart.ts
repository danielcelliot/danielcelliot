import { z } from 'zod';

export const addLineItemSchema = z.object({
	variant_id: z
		.string({
			invalid_type_error: 'Invalid variant ID'
		})
		.min(1, {
			message: 'Option(s) required'
		}),
	quantity: z
		.number({
			required_error: 'Quantity is required',
			invalid_type_error: 'Quantity must be a number'
		})
		.int()
		.positive()
		.min(1)
});

export const updateLineItemSchema = z.object({
	cart_id: z
		.string({
			required_error: 'Cart ID is required',
			invalid_type_error: 'Given cart ID is not of valid type'
		})
		.min(1, {
			message: 'Cart ID is required'
		}),
	item_id: z
		.string({
			required_error: 'Item ID is required',
			invalid_type_error: 'Given item ID is not of valid type'
		})
		.min(1, {
			message: 'Item ID is required'
		}),
	quantity: z
		.number({
			required_error: 'Quantity is required',
			invalid_type_error: 'Quantity must be a number'
		})
		.int()
		.positive()
		.min(1, {
			message: 'Quantity must be 1 or more'
		})
});

export const deleteLineItemSchema = z.object({
	cart_id: z
		.string({
			required_error: 'Cart ID is required',
			invalid_type_error: 'Given cart ID is not of valid type'
		})
		.min(1, {
			message: 'Cart ID is required'
		}),
	item_id: z
		.string({
			required_error: 'Item ID is required',
			invalid_type_error: 'Given item ID is not of valid type'
		})
		.min(1, {
			message: 'Item ID is required'
		})
});

export const checkoutLineItemsSchema = z.object({
	cart_id: z.string().min(1, {
		message: 'Cart ID is required'
	})
});

export type AddLineItemSchema = typeof addLineItemSchema;
export type UpdateLineItemSchema = typeof updateLineItemSchema;
export type DeleteLineItemSchema = typeof deleteLineItemSchema;
export type CheckoutLineItemsSchema = typeof checkoutLineItemsSchema;
