// See https://kit.svelte.dev/docs/types#app
// for information about these interfaces
declare global {
	namespace App {
		// interface Error {}
		// interface Locals {}
		// interface Platform {}
		interface PageData {
			flash?: { type: 'success' | 'error' | 'warn'; message: string };
		}
		namespace Superforms {
			type Message = {
				type: 'error' | 'success';
				text: string;
				data?: Record<string, unknown>;
			};
		}
	}
}

export {};
