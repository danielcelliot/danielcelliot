import { message, superValidate } from 'sveltekit-superforms/server';
import type { PageServerLoad } from './$types';
import { vendorInfoSchema } from '$lib/schemas/vendor';
import { fail, type Actions, redirect, error } from '@sveltejs/kit';
import type { User } from '$lib/types/medusa';
import { handleAdminLoginRedirect, handleFailedStatus } from '$lib/server/shop';

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, vendorInfoSchema);
		if (!form.valid) return fail(400, { form });

		let response = await event.fetch('/api/admin/auth');

		if (response.ok) {
			const user = (await response.json()) as User;

			response = await event.fetch(`/api/admin/users/${user.id}`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify({
					first_name: form.data.first_name,
					last_name: form.data.last_name,
					metadata: {
						phone_number: form.data.phone
					}
				})
			});

			if (response.ok)
				return message(form, { type: 'success', text: 'Your profile info has been updated' });
		}

		handleFailedStatus(response, event);

		return message(form, { type: 'error', text: 'Unable to update your profile info' });
	}
};

export const load: PageServerLoad = async (event) => {
	const fetchUser = async () => {
		const response = await event.fetch('/api/admin/auth');

		if (response.ok) return (await response.json()) as User;
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [form, user] = await Promise.all([superValidate(vendorInfoSchema), fetchUser()]);

	return {
		form,
		user
	};
};
