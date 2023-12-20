<script lang="ts">
	import { PUBLIC_STORE_NAME } from '$env/static/public';
</script>

<main class="container mx-auto my-4 px-2 min-[380px]:px-4">
	<div class="flex flex-col items-center gap-4">
		<a href="/" class="text-2xl font-normal leading-none tracking-widest">
			{PUBLIC_STORE_NAME.toUpperCase()}
		</a>

		<slot />
	</div>
</main>
