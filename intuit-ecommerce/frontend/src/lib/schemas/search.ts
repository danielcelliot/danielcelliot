import { z } from 'zod';

export const searchSchema = z.object({
	q: z.string().trim().min(1, {
		message: 'Query must be 1 character or more'
	})
});

export type SearchSchema = typeof searchSchema;
