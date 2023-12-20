import { MEILISEARCH_API_KEY, MEILISEARCH_URL } from '$env/static/private';
import type { HttpMethod } from '@sveltejs/kit';
import MeiliSearch from 'meilisearch';

export default new MeiliSearch({
	host: MEILISEARCH_URL,
	apiKey: MEILISEARCH_API_KEY
});

// TODO: create API key with search-only permission
export async function getSearchClient(fetch: typeof globalThis.fetch) {
	return new MeiliSearch({
		host: MEILISEARCH_URL,
		apiKey: MEILISEARCH_API_KEY,
		httpClient: async (url, opts) => {
			const response = await fetch(url, {
				body: opts?.body,
				headers: opts?.headers,
				method: (opts?.method?.toUpperCase() as HttpMethod) ?? 'GET'
			});

			return await response.json();
		}
	});
}
