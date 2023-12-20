import isMobilePhone from 'validator/lib/isMobilePhone';
import { z } from 'zod';

export const checkoutSchema = z.object({
	cart_id: z.string().min(1),
	email: z.string().email({
		message: 'Please enter a valid email address'
	}),
	first_name: z
		.string()
		.min(2, {
			message: 'First name length must be at least 2 characters'
		})
		.max(50, {
			message: 'First name length cannot be more than 50 characters'
		}),
	last_name: z
		.string()
		.min(2, {
			message: 'Last name length must be at least 2 characters'
		})
		.max(50, {
			message: 'Last name length cannot be more than 50 characters'
		}),
	address_1: z.string().min(3, {
		message: 'Address must contain at least 3 characters'
	}),
	address_2: z
		.string()
		.min(3, {
			message: 'Address must contain at least 3 characters'
		})
		.optional(),
	city: z.string().min(4, {
		message: 'City/Town must contain at least 4 characters'
	}),
	phone: z.string().refine((number) => isMobilePhone(number, 'any', { strictMode: true }), {
		message: 'Please enter a valid phone number'
	}),
	shipping_option_id: z.string().min(1),
	payment_provider_id: z.string().min(1)
});

export type CheckoutSchema = typeof checkoutSchema;
