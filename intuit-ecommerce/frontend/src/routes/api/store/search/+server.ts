import { getSearchClient } from '$lib/server/meilisearch';
import { json } from '@sveltejs/kit';
import type { RequestHandler } from './$types';

const HITS_PER_PAGE = 20;

export const POST: RequestHandler = async ({ fetch, request }) => {
	// TODO: body validation
	const { q, limit, page } = await request.json();

	const searchClient = await getSearchClient(fetch);
	const results = await searchClient.index('products').search(q, {
		hitsPerPage: limit ? parseInt(limit) : HITS_PER_PAGE,
		page: page ? parseInt(page) : undefined,
		filter: ['status = published']
	});

	return json(results);
};
