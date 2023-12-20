import { json, type Cookies, type RequestEvent, redirect, error } from '@sveltejs/kit';
import cookie from 'cookie';
import {
	MessageType,
	type Conversation,
	type ConversationMessage,
	type Contact
} from '$lib/types/chatwoot';
import { dev } from '$app/environment';
import { createHmac } from 'crypto';
import { IMGPROXY_KEY, IMGPROXY_SALT } from '$env/static/private';

export function setSessionCookie(name: string, resCookies: string[], reqCookies: Cookies) {
	let parsedCookie: Record<string, string> | undefined;
	for (const rawCookie of resCookies) {
		parsedCookie = cookie.parse(rawCookie);
	}

	if (parsedCookie) {
		const sessionCookie = parsedCookie[name];
		const expires = new Date(parsedCookie['Expires']);
		const maxAge = Math.round((expires.getTime() - Date.now()) / 1000);

		reqCookies.set(name, sessionCookie, {
			secure: dev ? false : true,
			path: '/',
			maxAge: maxAge,
			sameSite: 'lax'
		});
	}
}

export function getMostRecentMessage(
	conversationMessages: ConversationMessage[][],
	conversation_id: number
): ConversationMessage {
	const filtered = conversationMessages.filter((messages) =>
		messages.every((m) => m.conversation_id === conversation_id)
	);

	const lastMsg = filtered.map((messages) =>
		messages.reduce((prev, current) => (prev.id > current.id ? prev : current))
	);

	return lastMsg[0];
}

export function filterConversationsByChannel(channel: string, conversations: Conversation[]) {
	return conversations.filter((conversation) => conversation.meta.channel === channel);
}

export function filterInboxByType(type: string, contact: Contact) {
	return contact.contact_inboxes.find((i) => i.inbox.channel_type === type);
}

export function getPublicMessages(messages: ConversationMessage[]) {
	return messages.filter(
		(message) =>
			!message.private &&
			!message.content_attributes.deleted &&
			(message.message_type === MessageType.INCOMING ||
				message.message_type === MessageType.OUTGOING)
	);
}

export async function formatErrorResponse(response: Response) {
	const contentType = response.headers.get('content-type');
	const body =
		contentType && contentType.indexOf('application/json') !== -1
			? await response.json()
			: await response.text();

	return json({ message: body }, { status: response.status });
}

export function handleAdminLoginRedirect(
	event: RequestEvent,
	message: string = 'You must be signed in to access this page'
) {
	const redirectTo = event.url.pathname + event.url.search;
	return `/accounts/vendor/signin?redirectTo=${redirectTo}&message=${message}`;
}

export async function handleFailedStatus(response: Response, event: RequestEvent) {
	if (response.status === 401) throw redirect(302, handleAdminLoginRedirect(event));
	if (response.status === 500) {
		console.error('Error status 500:', await response.json());
		throw error(500, { message: 'Internal Error' });
	}
}

const hexDecode = (hex: string) => Buffer.from(hex, 'hex');
export const sign = (target: string) => {
	const hmac = createHmac('sha256', hexDecode(IMGPROXY_KEY));
	hmac.update(hexDecode(IMGPROXY_SALT));
	hmac.update(target);

	return hmac.digest('base64url');
};
