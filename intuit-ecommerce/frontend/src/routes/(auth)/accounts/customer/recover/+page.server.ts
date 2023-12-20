import { message, superValidate } from 'sveltekit-superforms/server';
import type { Actions, PageServerLoad } from './$types';
import { loginSchema } from '$lib/schemas/login';
import { fail, redirect } from '@sveltejs/kit';
import { validateToken } from 'sveltekit-turnstile';
import { SECRET_TURNSTILE_KEY } from '$env/static/private';
import { RetryAfterRateLimiter } from 'sveltekit-rate-limiter/server';

const limiter = new RetryAfterRateLimiter({
	rates: {
		IP: [10, 'h'],
		IPUA: [5, 'm']
	}
});

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, loginSchema.pick({ email: true, token: true }));
		if (!form.valid) return fail(400, { form });

		const status = await limiter.check(event);
		if (status.limited) {
			event.setHeaders({
				'Retry-After': status.retryAfter.toString()
			});

			return message(
				form,
				{
					type: 'error',
					text: `Rate limit has been reached. Please retry after ${status.retryAfter} seconds`
				},
				{ status: 429 }
			);
		}

		// const success = await validateToken(form.data.token, SECRET_TURNSTILE_KEY);
		// console.log(success);
		// if (!success) return message(form, { type: 'error', text: 'Invalid token' }, { status: 400 });

		const response = await event.fetch('/api/store/customers/password-token', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				email: form.data.email
			})
		});

		if (response.ok)
			throw redirect(303, `/accounts/customer/recover/email_sent?to=${form.data.email}`);

		return message(form, { type: 'error', text: 'Unable to verify your email address' });
	}
};

export const load = (async () => {
	return {
		form: superValidate(loginSchema.pick({ email: true }))
	};
}) satisfies PageServerLoad;
