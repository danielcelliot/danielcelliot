import type { Store, User } from '$lib/types/medusa';
import { error, redirect } from '@sveltejs/kit';
import type { LayoutServerLoad } from './$types';
import { handleAdminLoginRedirect } from '$lib/server/shop';
import { superValidate } from 'sveltekit-superforms/server';
import { z } from 'zod';

export const load: LayoutServerLoad = async (event) => {
	const fetchUser = async () => {
		const response = await event.fetch('/api/admin/auth');

		if (response.ok) return (await response.json()) as User;
		if (response.status === 401) handleAdminLoginRedirect(event);

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const fetchStoreDetails = async () => {
		const response = await event.fetch('/api/admin/store');

		if (response.ok) return (await response.json()) as Store;
		if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));

		console.error('Load error:', await response.json());
		throw error(response.status);
	};

	const [user, store, logoutForm] = await Promise.all([
		fetchUser(),
		fetchStoreDetails(),
		superValidate(z.object({}))
	]);

	return {
		user,
		store,
		logoutForm
	};
};
