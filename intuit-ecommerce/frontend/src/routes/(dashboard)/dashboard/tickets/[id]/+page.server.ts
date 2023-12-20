import type { Ticket } from '$lib/types/chatwoot.js';
import { type Action, type Actions, fail, redirect } from '@sveltejs/kit';
import { superValidate } from 'sveltekit-superforms/server';
import {
	changeConversationStatus,
	createMessage,
	fetchContactConversations
} from '$lib/server/chatwoot.js';
import { fetchUser } from '$lib/server/medusa-admin.js';
import { setFlash, redirect as flashRedirect } from 'sveltekit-flash-message/server';
import { messageSchema, statusSchema } from '$lib/schemas/ticket.js';

const changeStatus: Action = async (event) => {
	const form = await superValidate(event.request, statusSchema);
	if (!form.valid) return fail(400, { form });

	const user = await fetchUser(event.fetch);
	const contactId = user?.metadata?.chat_contact_id;

	if (contactId) {
		const conversations = await fetchContactConversations(contactId, event.fetch);
		if (conversations) {
			const found = conversations.find(
				(conversation) => conversation.id === form.data.conversation_id
			);
			if (found) {
				if (await changeConversationStatus(found.id, form.data.status, fetch))
					throw flashRedirect(
						event.url.pathname,
						{
							type: 'success',
							message: 'Your ticket status has been changed.'
						},
						event
					);
			}
		}
	}

	setFlash(
		{
			type: 'error',
			message: 'Failed to change ticket status.'
		},
		event
	);

	return fail(400);
};

const reply: Action = async (event) => {
	const form = await superValidate(event.request, messageSchema);
	if (!form.valid) return fail(400, { form });

	const user = await fetchUser(event.fetch);
	const contactId = user?.metadata?.chat_contact_id;

	if (contactId) {
		const conversations = await fetchContactConversations(contactId, event.fetch);
		if (conversations) {
			const found = conversations.find(
				(conversation) => conversation.id === form.data.conversation_id
			);
			if (found) {
				if (await createMessage(found.id, form.data.content, event.fetch))
					throw redirect(303, event.url.pathname);
			}
		}
	}

	setFlash(
		{
			type: 'error',
			message: 'Failed to submit your message.'
		},
		event
	);

	return fail(400, { form });
};

export const actions: Actions = { reply, changeStatus };

export async function load({ fetch, params }) {
	const fetchTicket = async (): Promise<Ticket | null> => {
		const response = await fetch(`/api/auth/vendor/tickets/${params.id}`);
		if (response.ok) return await response.json();

		return null;
	};

	const [ticket, statusForm, messageForm] = await Promise.all([
		fetchTicket(),
		superValidate(statusSchema),
		superValidate(messageSchema)
	]);

	return {
		ticket,
		statusForm,
		messageForm
	};
}
