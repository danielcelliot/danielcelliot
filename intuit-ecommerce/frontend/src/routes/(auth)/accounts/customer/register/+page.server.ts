import { fail, type Actions } from '@sveltejs/kit';
import { message, superValidate } from 'sveltekit-superforms/server';
import { redirect } from 'sveltekit-flash-message/server';
import { newCustomerSchema } from '$lib/schemas/login';
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
		const form = await superValidate(event.request, newCustomerSchema);
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

		const response = await event.fetch('/api/store/customers', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				first_name: form.data.first_name,
				last_name: form.data.last_name,
				email: form.data.email,
				password: form.data.password,
				phone: form.data.phone
			})
		});

		if (response.ok)
			throw redirect(
				303,
				'/',
				{
					type: 'success',
					message: 'Your account was created successfully!'
				},
				event
			);

		if (response.status === 422)
			return message(
				form,
				{
					type: 'error',
					text: `An account with ${form.data.email} already exists`
				},
				{ status: response.status }
			);

		return message(form, { type: 'error', text: 'Unable to create your account' });
	}
};

export async function load() {
	return {
		form: await superValidate(newCustomerSchema)
	};
}
