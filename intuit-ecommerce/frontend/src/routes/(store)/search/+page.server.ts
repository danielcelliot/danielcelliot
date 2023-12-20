import type { SearchResponse } from 'meilisearch';
import type { PageServerLoad } from './$types';
import { searchSchema } from '$lib/schemas/search';
import { redirect } from '@sveltejs/kit';

export const load: PageServerLoad = async ({ url, fetch }) => {
	const fetchSearchResults = async () => {
		// TODO: params validation

		const body = Object.fromEntries(url.searchParams);

		const validated = searchSchema.safeParse(body);

		if (validated.success) {
			const response = await fetch(`/api/store/search`, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				},
				body: JSON.stringify(validated.data)
			});

			if (response.ok) return (await response.json()) as SearchResponse;
			console.log(`Error: search (${response.status}):`, await response.json());
		}

		throw redirect(303, '/');
	};

	return {
		results: fetchSearchResults()
	};
};

// const query: Action = async ({ request }) => {
// 	const form = await request.formData();
// 	const formData = Object.fromEntries(form);
// 	const query = String(formData.search);

// 	throw redirect(302, `/search?q=${encodeURIComponent(query)}`);
// };

// export const actions: Actions = { query };

// function addSingleValueAttribute(attr: string, value: string, op: string | null): string {
// 	return op ? ` ${op} '${attr}' = '${value}'` : `'${attr}' = '${value}'`;
// }

// function addMultiValueAttribute(attr: string, values: string[], op: string | null): string {
// 	let str = '';
// 	op ? (str += ` ${op} (`) : (str += '(');

// 	let i = 0;
// 	do {
// 		i < 1
// 			? (str += addSingleValueAttribute(attr, values[i], null))
// 			: (str += addSingleValueAttribute(attr, values[i], 'OR'));
// 		i++;
// 	} while (i < values.length);

// 	str += ')';
// 	return str;
// }

// function createFilterExpression(attributes: { [key: string]: string[] }[]): string {
// 	let str = '';
// 	if (attributes.length === 1) {
// 		const attrValues = Object.values(attributes[0])[0];
// 		attrValues.length === 1
// 			? (str += addSingleValueAttribute(Object.keys(attributes[0])[0], attrValues[0], null))
// 			: (str += addMultiValueAttribute(Object.keys(attributes[0])[0], attrValues, null));
// 	} else {
// 		let i = 0;
// 		do {
// 			if (i < 1) {
// 				const attrValues = Object.values(attributes[i])[0];
// 				attrValues.length === 1
// 					? (str += addSingleValueAttribute(Object.keys(attributes[i])[0], attrValues[0], null))
// 					: (str += addMultiValueAttribute(Object.keys(attributes[i])[0], attrValues, null));
// 			} else {
// 				const attrValues = Object.values(attributes[i])[0];
// 				attrValues.length === 1
// 					? (str += addSingleValueAttribute(Object.keys(attributes[i])[0], attrValues[0], 'AND'))
// 					: (str += addMultiValueAttribute(Object.keys(attributes[i])[0], attrValues, 'AND'));
// 			}

// 			i++;
// 		} while (i < attributes.length);
// 	}

// 	return str;
// }
