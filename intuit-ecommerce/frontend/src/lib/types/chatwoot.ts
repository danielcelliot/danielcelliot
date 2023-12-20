export enum ConversationStatus {
	OPEN = 'open',
	RESOLVED = 'resolved',
	PENDING = 'pending'
}

export enum MessageType {
	INCOMING = 0,
	OUTGOING = 1,
	ACTIVITY = 2,
	TEMPLATE = 3
}

export enum SenderType {
	CONTACT = 'contact',
	USER = 'user'
}

export interface Label {
	id: number;
	title: string;
	description: string;
	color: string;
	show_on_sidebar: true;
}

export interface Ticket {
	id: number;
	subject: string | null;
	labels: string[];
	status: string;
	created: Date;
	last_accessed: Date;
	messages: ConversationMessage[];
}

export interface Tickets {
	id: number;
	subject: string | null;
	labels: string[];
	status: string;
	created: Date;
	last_accessed: Date;
	message: ConversationMessage;
}

export interface Conversation {
	meta: {
		sender: {
			id: number;
			name: string;
			email: string;
			phone_number: string;
			identifier: string;
			thumbnail: string;
			custom_attributes: object;
			last_activity_at: number;
			created_at: number;
			availability_status: string;
			additional_attributes: object;
		};
		channel: string;
		assignee: {
			id: number;
			account_id: number;
			availability_status: string;
			auto_offline: boolean;
			confirmed: boolean;
			email: string;
			available_name: string;
			name: string;
			role: string;
			thumbnail: string;
		};
		hmac_verified: boolean;
	};
	id: number;
	messages: ConversationMessage[];
	account_id: number;
	additional_attributes: object;
	agent_last_seen_at: number;
	assignee_last_seen_at: number;
	can_reply: boolean;
	contact_last_seen_at: number;
	custom_attributes: {
		subject?: string;
		last_accessed?: Date;
	};
	inbox_id: number;
	labels: string[];
	muted: boolean;
	snoozed_until: object | null;
	status: string;
	created_at: number;
	timestamp: number;
	first_reply_created_at: number;
	unread_count: number;
	last_non_activity_message: object;
}

export interface ConversationMessage {
	id: number;
	content: string;
	message_type: MessageType;
	content_type: string;
	content_attributes: {
		deleted?: boolean;
	};
	created_at: number;
	sender: {
		additional_attributes?: Record<string, string>;
		custom_attributes?: Record<string, string>;
		email?: string;
		id: number;
		identifier?: string;
		name: string;
		phone_number?: string | null;
		thumbnail: string;
		type: string;
		available_name?: string;
		availability_status?: string;
		avatar_url?: string;
	};
	inbox_id: number;
	conversation_id: number;
	status: string;
	private: boolean;
	source_id: number | null;
}

export interface PublicConversationMessage {
	id: number;
	content: string;
	message_type: MessageType;
	content_type: string;
	content_attributes: {
		deleted?: boolean;
	};
	created_at: number;
	sender: {
		additional_attributes?: Record<string, string>;
		custom_attributes?: {
			store_name: string;
			company_name?: string;
			company_email?: string;
			company_phone?: string;
		};
		email?: string;
		id: number;
		identifier?: string;
		name: string;
		available_name?: string;
		phone_number?: string;
		thumbnail: string;
		avatar_url?: string;
		type: SenderType;
		availability_status?: string | null;
	};
}

export interface Contact {
	id: number;
	email: string;
	name: string;
	phone_number: string | null;
	identifier: string;
	thumbnail: string;
	availability_status: string;
	additional_attributes: object;
	custom_attributes: object;
	created_at: number;
	contact_inboxes: ContactInbox[];
}

export interface ContactInbox {
	source_id: string;
	inbox: {
		id: number;
		avatar_url: string;
		channel_id: number;
		name: string;
		channel_type: string;
		greeting_enabled: boolean;
		greeting_message: string;
		working_hours_enabled: boolean;
		enable_email_collect: boolean;
		csat_survey_enabled: boolean;
		enable_auto_assignment: boolean;
		auto_assignment_config: object;
		out_of_office_message: null;
		working_hours: object[];
		timezone: string;
		callback_webhook_url: null;
		allow_messages_after_resolved: boolean;
		lock_to_single_conversation: boolean;
		widget_color: null;
		website_url: string | null;
		hmac_mandatory: null;
		welcome_title: null;
		welcome_tagline: null;
		reply_time: null;
		messaging_service_sid: null;
		phone_number: null;
		hmac_token: string;
		webhook_url: string;
		inbox_identifier: string;
		additional_attributes: object;
		provider: null;
	};
}

export interface CreateMessageResponse {
	id: number;
	conversation_id: number;
	content: string;
	content_type: string;
	content_attributes: object;
	message_type: string;
	created_at: number;
	private: boolean;
	attachment: object;
	sender: object;
}

export interface CreateContactResponse {
	id: number;
	availability_status: string;
	payload: { contact: Contact };
}

export interface ChangeStatusResponse {
	success: boolean;
	current_status: string;
	conversation_id: number;
}

export interface ResponseError {
	description: string;
	errors: {
		field: string;
		message: string;
		code: string;
	}[];
}
