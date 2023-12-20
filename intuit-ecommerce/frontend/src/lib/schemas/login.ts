import isMobilePhone from 'validator/lib/isMobilePhone';
import { z } from 'zod';

export const loginSchema = z.object({
	email: z.string().email({
		message: 'Please enter a valid email address'
	}),
	password: z.string().min(1, {
		message: 'Please enter your password'
	}),
	token: z.string({ required_error: 'Token is required' })
});

export const newCustomerSchema = z
	.object({
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
		email: z.string().email({
			message: 'Please enter a valid email address'
		}),
		phone: z
			.string()
			.refine((number) => isMobilePhone(number, 'any', { strictMode: true }), {
				message: 'Please enter a valid phone number'
			})
			.optional(),
		token: z.string({ required_error: 'Token is required' }),
		password: z.string().min(6, {
			message: 'Password length must be at least 6 characters'
		}),
		confirm: z.string()
	})
	.refine((data) => data.password === data.confirm, {
		message: "Passwords don't match",
		path: ['confirm']
	});

export const resetPasswordSchema = z
	.object({
		email: z.string().email({
			message: 'Please enter a valid email address'
		}),
		token: z.string(),
		password: z.string().min(6, {
			message: 'Password length must be at least 6 characters'
		}),
		confirm: z.string()
	})
	.refine((data) => data.password === data.confirm, {
		message: "Passwords don't match",
		path: ['confirm']
	});

export type LoginSchema = typeof loginSchema;
export type NewCustomerSchema = typeof newCustomerSchema;
export type ResetPasswordSchema = typeof resetPasswordSchema;
