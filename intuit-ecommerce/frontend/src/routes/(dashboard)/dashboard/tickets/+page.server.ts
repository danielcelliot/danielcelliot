import type { Contact, Tickets } from '$lib/types/chatwoot';
import { type Action, type Actions, fail } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import {
	addLabelsToConversation,
	createContact,
	createConversation,
	createMessage,
	fetchContact,
	fetchTicketLabelById,
	fetchTicketLabels
} from '$lib/server/chatwoot';
import { message, superValidate } from 'sveltekit-superforms/server';
import { filterInboxByType } from '$lib/server/shop';
import { addContactToUser, fetchStoreDetails, fetchUser } from '$lib/server/medusa-admin';
import { ticketSchema } from '$lib/schemas/ticket';
import { redirect } from 'sveltekit-flash-message/server';

const create: Action = async (event) => {
	const createTicket = async (contact: Contact) => {
		const inbox = filterInboxByType('Channel::Api', contact);
		if (inbox) {
			const conversation = await createConversation(
				contact.id,
				inbox,
				form.data.subject,
				event.fetch
			);
			if (conversation) {
				// eslint-disable-next-line @typescript-eslint/no-unused-vars
				const [labels, created] = await Promise.all([
					(async () => {
						const label = await fetchTicketLabelById(form.data.label_id, event.fetch);
						return label
							? addLabelsToConversation(conversation.id, [label.title], event.fetch)
							: null;
					})(),
					createMessage(conversation.id, form.data.content, event.fetch)
				]);

				return created ? true : false;
			}

			console.error('Unable to create conversation');
			return false;
		}

		console.error('Channel API inbox not found');
		return false;
	};

	const form = await superValidate(event.request, ticketSchema);
	// console.log(form);
	if (!form.valid) return fail(400, { form });

	// eslint-disable-next-line prefer-const
	let [vendor, store] = await Promise.all([fetchUser(event.fetch), fetchStoreDetails(event.fetch)]);

	const contactId = vendor?.metadata?.chat_contact_id;

	const successMsg = {
		type: 'success',
		message: 'Your new ticket has been created'
	} as const;

	if (contactId) {
		const contact = await fetchContact(contactId, event.fetch);
		if (contact && (await createTicket(contact))) {
			throw redirect(event.url.pathname, successMsg, event);
		}

		console.error(`Cannot fetch contact with given ID ${contactId}`);
	} else if (vendor && store) {
		const payload = await createContact(
			{
				email: vendor.email,
				identifier: vendor.id,
				name: `${vendor.first_name ?? ''} ${vendor.last_name ?? ''}`,
				phone_number: vendor.metadata?.phone_number ?? '',
				custom_attributes: {
					store_name: store.name,
					company_name: store.metadata?.company_name ?? '',
					company_phone: store.metadata?.phone ?? '',
					company_email: store.metadata?.email ?? ''
				}
			},
			event.fetch
		);

		console.log('Create contact:', payload);
		if (payload) {
			vendor = await addContactToUser(payload.contact.id, vendor.id, event.fetch);
			console.log('Update user:', vendor);
			if (vendor && (await createTicket(payload.contact))) {
				throw redirect(event.url.pathname, successMsg, event);
			}

			console.error(`Unable to add chat_contact_id=${payload.contact.id} to vendor`);
		} else {
			console.error(`Unable to create contact`);
		}
	}

	return message(form, 'Unable to create new ticket', { status: 400 });
};

export const actions: Actions = { create };

export const load: PageServerLoad = async ({ fetch }) => {
	const fetchTickets = async (): Promise<Tickets[] | null> => {
		const response = await fetch('/api/auth/vendor/tickets');
		if (response.ok) return await response.json();

		return null;
	};

	const [tickets, labels, form] = await Promise.all([
		fetchTickets(),
		fetchTicketLabels(fetch),
		superValidate(ticketSchema)
	]);

	return {
		tickets,
		labels,
		form
	};
};
