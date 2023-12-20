import { error, fail, redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';
import { message, superValidate } from 'sveltekit-superforms/server';
import { resetPasswordSchema } from '$lib/schemas/login';

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, resetPasswordSchema);
		if (!form.valid) return fail(400, { form });

		const response = await event.fetch('/api/store/customers/password-reset', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				email: form.data.email,
				password: form.data.password,
				token: form.data.token
			})
		});

		if (response.ok) throw redirect(303, '/accounts/customer/signin?reset_successful=true');

		return message(form, { type: 'error', text: 'Unable to reset your password' });
	}
};

export const load = (async ({ url }) => {
	const getToken = async () => {
		const token = url.searchParams.get('token');

		if (token) return token;

		throw error(400, 'Invalid request');
	};

	return {
		token: getToken(),
		form: superValidate(resetPasswordSchema)
	};
}) satisfies PageServerLoad;
