<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { page } from '$app/stores';

	let email = $page.url.searchParams.get('to');
</script>

<section class="w-full">
	<Card.Root class="rounded-xl">
		<Card.Header class="space-y-0">
			<div class="grid gap-1">
				<Card.Title class="text-2xl">Request Received!</Card.Title>
				<Card.Description class="text-foreground">
					If an account exists, an email will be sent to <span class="font-bold">{email}</span>
					with further instructions. Please click the link when you get it.
				</Card.Description>
			</div>
		</Card.Header>
	</Card.Root>
</section>
