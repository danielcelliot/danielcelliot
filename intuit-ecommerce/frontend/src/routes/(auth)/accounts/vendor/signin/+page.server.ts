import type { Actions, PageServerLoad } from './$types';
import { fail } from '@sveltejs/kit';
import { message, superValidate } from 'sveltekit-superforms/server';
import { redirect } from 'sveltekit-flash-message/server';
import { loginSchema } from '$lib/schemas/login';
import { validateToken } from 'sveltekit-turnstile';
import { SECRET_TURNSTILE_KEY } from '$env/static/private';

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, loginSchema);
		if (!form.valid) return fail(400, { form });

		// const success = await validateToken(form.data.token, SECRET_TURNSTILE_KEY);
		// console.log(success);
		// if (!success) return message(form, { type: 'error', text: 'Invalid token' }, { status: 400 });

		const response = await event.fetch('/api/admin/auth', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				email: form.data.email,
				password: form.data.password
			})
		});

		if (response.ok) {
			const redirectTo = event.url.searchParams.get('redirectTo');

			throw redirect(
				302,
				redirectTo ? `/${redirectTo.slice(1)}` : '/dashboard/products',
				{ type: 'success', message: 'You have signed in to your account' },
				event
			);
		}

		if (response.status === 401) {
			return message(
				form,
				{ type: 'error', text: 'Invalid email and/or password' },
				{ status: response.status }
			);
		}

		return message(form, { type: 'error', text: 'Unable to sign in to your account' });
	}
};

export const load: PageServerLoad = async () => {
	return {
		form: superValidate(loginSchema)
	};
};
