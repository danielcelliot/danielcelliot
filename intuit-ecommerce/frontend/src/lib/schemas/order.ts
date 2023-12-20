import { z } from 'zod';

export const fulfillItemsSchema = z.object({
	order_id: z.string().min(1),
	items: z
		.array(
			z.object({
				id: z.string().min(1),
				quantity: z.coerce.number().int().nonnegative(),

				max_quantity: z.number().positive().optional(),
				thumbnail: z.string().optional(),
				title: z.string().optional(),
				variant_title: z.string().optional()
			})
		)
		.min(1)
});

export const shipItemsSchema = z.object({
	order_id: z.string().min(1),
	fulfillment_id: z.string().min(1),
	tracking_number: z.string().min(1).optional()
});

export const cancelFulfillmentSchema = z.object({
	order_id: z.string().min(1),
	fulfillment_id: z.string().min(1)
});

export const orderIdSchema = z.object({
	order_id: z.string().min(1, {
		message: 'Please enter your order ID'
	}),
	token: z.string({ required_error: 'Token is required' })
});

export type OrderIdSchema = typeof orderIdSchema;
export type FulfillItemsSchema = typeof fulfillItemsSchema;
export type ShipItemsSchema = typeof shipItemsSchema;
export type CancelFulfillmentSchema = typeof cancelFulfillmentSchema;
