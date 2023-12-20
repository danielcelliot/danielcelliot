<script>
	import { fade } from "svelte/transition";
</script>

<div class="w-screen h-screen fixed top-0 left-0 flex justify-center items-center bg-gray-100 opacity-90 z-10"
		transition:fade>
	<slot />
</div>