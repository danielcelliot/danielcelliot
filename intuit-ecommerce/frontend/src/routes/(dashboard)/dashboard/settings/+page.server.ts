import { message, superValidate } from 'sveltekit-superforms/server';
import type { PageServerLoad } from './$types';
import { businessDetailsSchema } from '$lib/schemas/vendor';
import { fail, type Actions, redirect, error } from '@sveltejs/kit';
import type { Store } from '$lib/types/medusa';
import { handleAdminLoginRedirect, handleFailedStatus } from '$lib/server/shop';

export const actions: Actions = {
	default: async (event) => {
		const form = await superValidate(event.request, businessDetailsSchema);
		if (!form.valid) return fail(400, { form });

		const response = await event.fetch('/api/admin/store', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				metadata: {
					company_name: form.data.business_name,
					phone: form.data.phone,
					email: form.data.email
				}
			})
		});

		if (response.ok)
			return message(form, { type: 'success', text: 'Your store details has been updated' });

		handleFailedStatus(response, event);

		return message(form, { type: 'error', text: 'Unable to update your store details' });
	}
};

export const load: PageServerLoad = async (event) => {
	const fetchStoreDetails = async () => {
		const response = await event.fetch('/api/admin/store');

		if (response.ok) return (await response.json()) as Store;
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [form, store] = await Promise.all([
		superValidate(businessDetailsSchema),
		fetchStoreDetails()
	]);

	return {
		form,
		store
	};
};
