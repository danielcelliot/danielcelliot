import { orderIdSchema } from '$lib/schemas/order';
import { message, superValidate } from 'sveltekit-superforms/server';
import type { Actions, PageServerLoad } from './$types';
import { fail, redirect } from '@sveltejs/kit';
import { RetryAfterRateLimiter } from 'sveltekit-rate-limiter/server';
import { validateToken } from 'sveltekit-turnstile';
import { RATELIMIT_SECRET_KEY, SECRET_TURNSTILE_KEY } from '$env/static/private';

const limiter = new RetryAfterRateLimiter({
	rates: {
		IP: [10, 'h'],
		IPUA: [5, 'm']
	}
});

export const load = (async () => {
	return {
		form: superValidate(orderIdSchema)
	};
}) satisfies PageServerLoad;

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, orderIdSchema);
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

		const response = await event.fetch(`/api/store/orders/${form.data.order_id}`);

		if (response.ok) throw redirect(303, `/orders/${form.data.order_id}`);

		return message(
			form,
			{
				type: 'error',
				text: 'No order found. Please verify that your order ID was entered correctly and try again.'
			},
			{ status: 404 }
		);
	}
};
