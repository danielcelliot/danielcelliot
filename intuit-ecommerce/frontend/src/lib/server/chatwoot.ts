import {
	CHAT_API_ACCESS_TOKEN,
	CHAT_API_ACCOUNT_ID,
	CHAT_API_INBOX_ID,
	CHAT_BACKEND_URL
} from '$env/static/private';
import {
	ConversationStatus,
	type Contact,
	type ContactInbox,
	type Conversation,
	type ConversationMessage,
	type CreateMessageResponse,
	type Label,
	type ChangeStatusResponse
} from '$lib/types/chatwoot';

export async function fetchTicketLabels(fetch: typeof globalThis.fetch) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/labels`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const { payload }: { payload: Label[] } = await response.json();
		return payload;
	}

	console.error(`Fetch Ticket Labels (Status code: ${response.status})`);
	return null;
}

export async function fetchTicketLabelById(label_id: number, fetch: typeof globalThis.fetch) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/labels/${label_id}`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const label: Label = await response.json();
		return label;
	}

	console.error(`Fetch Ticket Label by ID (Status code: ${response.status})`);
	return null;
}

export async function fetchContactConversations(
	contact_id: number,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/contacts/${contact_id}/conversations`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const { payload }: { payload: Conversation[] } = await response.json();
		return payload;
	}

	console.error(`Fetch Customer Conversations (Status code: ${response.status})`);
	return null;
}

export async function fetchConversationById(
	conversation_id: number,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations/${conversation_id}/`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const conversation: Conversation = await response.json();
		return conversation;
	}

	console.error(`Fetch Conversation by ID (Status code: ${response.status})`);
	return null;
}

export async function fetchConversationMessages(
	conversation_id: number,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations/${conversation_id}/messages`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const { payload }: { payload: ConversationMessage[] } = await response.json();
		return payload;
	}

	console.error(`Fetch Conversation Messages (Status code: ${response.status})`);
	return null;
}

export async function fetchContact(contact_id: number, fetch: typeof globalThis.fetch) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/contacts/${contact_id}`;
	const response = await fetch(url, {
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN
		}
	});

	if (response.ok) {
		const { payload }: { payload: Contact } = await response.json();
		return payload;
	}

	console.error(`Fetch Contact (Status code: ${response.status})`);
	return null;
}

export async function createContact(
	contact: {
		name: string;
		phone_number?: string;
		email: string;
		identifier: string;
		custom_attributes?: Record<string, string>;
	},
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/contacts`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			name: contact.name,
			inbox_id: CHAT_API_INBOX_ID,
			phone_number: contact.phone_number,
			email: contact.email,
			identifier: contact.identifier,
			custom_attributes: contact.custom_attributes
		})
	});

	if (response.ok) {
		const { payload }: { payload: { contact: Contact } } = await response.json();
		return payload;
	}

	console.error(`Create New Contact (Status code: ${response.status})`, await response.json());
	return null;
}

export async function createConversation(
	contact_id: number,
	contactInbox: ContactInbox,
	subject: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations`;
	const response = await fetch(url, {
		method: 'POST',
		headers: {
			api_access_token: CHAT_API_ACCESS_TOKEN,
			'Content-Type': 'application/json'
		},
		body: JSON.stringify({
			account_id: CHAT_API_ACCOUNT_ID,
			source_id: contactInbox.source_id,
			inbox_id: contactInbox.inbox.id,
			contact_id,
			status: ConversationStatus.OPEN,
			custom_attributes: {
				last_accessed: Math.round(Date.now() / 1000),
				subject
			}
		})
	});

	if (response.ok) {
		const result: { id: number; account_id: number; inbox_id: number } = await response.json();
		return result;
	}

	console.error(`Create New Conversation (Status code: ${response.status})`);
	return null;
}

export async function addLabelsToConversation(
	conversation_id: number,
	labels: string[],
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations/${conversation_id}/labels`;
	const response = await fetch(url, {
		headers: {
			'Content-Type': 'application/json',
			api_access_token: CHAT_API_ACCESS_TOKEN
		},
		method: 'POST',
		body: JSON.stringify({ labels })
	});

	if (response.ok) {
		const { payload }: { payload: string[] } = await response.json();
		return payload;
	}

	console.error(`Add Conversation Labels (Status code: ${response.status})`);
	return null;
}

export async function createMessage(
	conversation_id: number,
	message: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations/${conversation_id}/messages`;
	const response = await fetch(url, {
		headers: {
			'Content-Type': 'application/json',
			api_access_token: CHAT_API_ACCESS_TOKEN
		},
		method: 'POST',
		body: JSON.stringify({
			account_id: CHAT_API_ACCOUNT_ID,
			conversation_id,
			message_type: 'incoming',
			content: message
		})
	});

	if (response.ok) {
		const messageResponse: CreateMessageResponse = await response.json();
		return messageResponse;
	}

	console.error(`Create Conversation Message (Status code: ${response.status})`);
	return null;
}

export async function changeConversationStatus(
	conversation_id: number,
	status: string,
	fetch: typeof globalThis.fetch
) {
	const url = `${CHAT_BACKEND_URL}/api/v1/accounts/${CHAT_API_ACCOUNT_ID}/conversations/${conversation_id}/toggle_status`;
	const response = await fetch(url, {
		headers: {
			'Content-Type': 'application/json',
			api_access_token: CHAT_API_ACCESS_TOKEN
		},
		method: 'POST',
		body: JSON.stringify({
			status
		})
	});

	if (response.ok) {
		const { payload }: { payload: ChangeStatusResponse } = await response.json();
		return payload;
	}

	console.error(`Change Conversation Status (Status code: ${response.status})`);
	return null;
}
