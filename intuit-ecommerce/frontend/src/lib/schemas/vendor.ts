import isMobilePhone from 'validator/lib/isMobilePhone';
import { z } from 'zod';

export const vendorInfoSchema = z.object({
	first_name: z.string().min(2, {
		message: 'First name must be at least 2 characters'
	}),
	last_name: z.string().min(2, {
		message: 'Last name must be at least 2 characters'
	}),
	phone: z
		.string()
		.refine((number) => isMobilePhone(number, 'any', { strictMode: true }), {
			message: 'Please enter a valid phone number'
		})
		.optional()
});

export const businessDetailsSchema = z.object({
	business_name: z
		.string()
		.min(5, {
			message: 'Your business/company name must be at least 5 characters'
		})
		.optional(),
	phone: z.string().refine((number) => isMobilePhone(number, 'any', { strictMode: true }), {
		message: 'Please enter a valid phone number'
	}),
	email: z.string().email({
		message: 'Please enter a valid email address'
	})
});

export type VendorInfoSchema = typeof vendorInfoSchema;
export type BusinessDetailsSchema = typeof businessDetailsSchema;
