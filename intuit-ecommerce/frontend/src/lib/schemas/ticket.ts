import { ConversationStatus } from '$lib/types/chatwoot';
import { z } from 'zod';

export const ticketSchema = z.object({
	label_id: z.coerce
		.number({
			invalid_type_error: 'Please select a department.',
			required_error: 'Please select a department.'
		})
		.positive(),
	subject: z.string().min(5, {
		message: 'The length of your subject title is too short.'
	}),
	content: z.string().min(20, {
		message: 'The length of your message is too short.'
	})
});

export const statusSchema = z.object({
	conversation_id: z.number().positive(),
	status: z.nativeEnum(ConversationStatus)
});

export const messageSchema = z.object({
	conversation_id: z.number().positive(),
	content: z.string().min(1, {
		message: 'Please enter a message.'
	})
});

export type TicketSchema = typeof ticketSchema;
export type StatusSchema = typeof statusSchema;
export type MessageSchema = typeof messageSchema;
