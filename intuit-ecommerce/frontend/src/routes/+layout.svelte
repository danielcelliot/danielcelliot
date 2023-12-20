<script lang="ts">
	import '../app.postcss';
	import { getFlash } from 'sveltekit-flash-message';
	import { page } from '$app/stores';
	import Toaster, { addToast } from '$lib/components/ui/toast/toaster.svelte';
	import { ModeWatcher } from 'mode-watcher';

	const flash = getFlash(page);

	flash.subscribe(($flash) => {
		if (!$flash) return;

		const data = {
			title: $flash.type == 'success' ? 'Success' : 'Error',
			description: $flash.message,
			color: $flash.type == 'success' ? 'bg-green-500' : 'bg-red-500'
		};

		addToast({ data });

		// Clearing the flash message could sometimes be required here to avoid double-toasting.
		flash.set(undefined);
	});
</script>

<ModeWatcher />
<Toaster />

<slot />
