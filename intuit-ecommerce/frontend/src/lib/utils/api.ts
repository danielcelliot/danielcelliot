async function returnResponse(response: Response) {
	const contentType = response.headers.get('content-type');
	return contentType && contentType.indexOf('application/json') !== -1
		? { status: response.status, body: await response.json() }
		: { status: response.status, body: await response.text() };
}

export async function get(
	fetch: typeof globalThis.fetch,
	base: string,
	endpoint: string,
	params?: Record<string, string>
) {
	const q = new URLSearchParams(params);
	const response = await fetch(`${base}${endpoint}?${q}`);
	return await returnResponse(response);
}

// TODO: Prevent stingifying null values
export async function post(
	fetch: typeof globalThis.fetch,
	base: string,
	endpoint: string,
	body?: Record<string, unknown>
) {
	const response = await fetch(`${base}${endpoint}`, {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	});
	return await returnResponse(response);
}

export async function postBlob(
	fetch: typeof globalThis.fetch,
	base: string,
	endpoint: string,
	body: FormData
) {
	const response = await fetch(`${base}${endpoint}`, {
		method: 'POST',
		body
	});
	return await returnResponse(response);
}

export async function del(
	fetch: typeof globalThis.fetch,
	base: string,
	endpoint: string,
	body?: Record<string, unknown>
) {
	const response = await fetch(`${base}${endpoint}`, {
		method: 'DELETE',
		headers: {
			'Content-Type': 'application/json'
		},
		body: JSON.stringify(body)
	});
	return await returnResponse(response);
}
