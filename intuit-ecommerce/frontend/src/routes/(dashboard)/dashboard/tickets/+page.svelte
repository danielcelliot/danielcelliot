<script lang="ts">
	import type { PageData } from './$types';
	import { timeAgo } from '$lib/client/shop';
	import { ConversationStatus, type Tickets } from '$lib/types/chatwoot';
	import * as Tabs from '$lib/components/ui/tabs';
	import * as Card from '$lib/components/ui/card';
	import * as Avatar from '$lib/components/ui/avatar';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import Button from '$lib/components/ui/button/button.svelte';
	import { MessageSquarePlus, Ticket } from 'lucide-svelte';
	import NewTicketForm from '$lib/components/admin/ticket/NewTicketForm.svelte';

	export let data: PageData;

	let filteredTickets: Tickets[] | null | undefined;
	let openTicketModal = false;

	$: ({ tickets } = data);
	$: ({ labels } = data);
	$: filteredTickets = tickets;
</script>

<Dialog.Root bind:open={openTicketModal}>
	<Dialog.Content class="max-h-screen max-w-[350px] overflow-y-scroll rounded-xl">
		<Dialog.Header>
			<Dialog.Title class="text-left text-base">Create new ticket</Dialog.Title>
			<Dialog.Description class="text-left">
				Please describe the issue or question that you have with as much detail as you think is
				relevant and we will do our best to get back to you as soon as possible.
			</Dialog.Description>
		</Dialog.Header>
		<NewTicketForm
			labels={labels ?? []}
			formData={data.form}
			on:view={(event) => (openTicketModal = event.detail.open)} />
	</Dialog.Content>
</Dialog.Root>

<main>
	{#if tickets && tickets.length > 0}
		<div class="flex justify-center py-4">
			<Tabs.Root value="all" class="w-full max-w-[400px]">
				<Tabs.List class="grid grid-cols-3 rounded-2xl">
					<Tabs.Trigger class="rounded-xl" value="all" on:click={() => (filteredTickets = tickets)}>
						All
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="open"
						on:click={() =>
							(filteredTickets = tickets?.filter((t) => t.status === ConversationStatus.OPEN))}>
						Open
					</Tabs.Trigger>

					<Tabs.Trigger
						class="rounded-xl"
						value="resolved"
						on:click={() =>
							(filteredTickets = tickets?.filter((t) => t.status === ConversationStatus.RESOLVED))}>
						Resolved
					</Tabs.Trigger>
				</Tabs.List>
			</Tabs.Root>
		</div>

		{#if filteredTickets && filteredTickets.length > 0}
			<div class="grid gap-2 pb-20">
				{#each filteredTickets as { id, message, subject }}
					<a id={id.toString()} href="/dashboard/tickets/{id}">
						<Card.Root class="hover:bg-muted">
							<div class="flex items-center p-2">
								<Avatar.Root class="mr-2">
									{#if message.sender.type === 'contact'}
										<Avatar.Image src="https://i.pravatar.cc/40" alt="@shadcn" />
										<Avatar.Fallback class="text-sm">
											{message.sender.name
												.split(' ')[0]
												.charAt(0)
												.toUpperCase()}{message.sender.name
												.split(' ')[1]
												?.charAt(0)
												.toUpperCase() ?? ''}
										</Avatar.Fallback>
									{:else}
										<Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
										<Avatar.Fallback class="text-sm">C</Avatar.Fallback>
									{/if}
								</Avatar.Root>

								<div class="flex w-10/12 flex-col">
									<div class="mb-0.5 grid">
										<p class="truncate text-sm font-medium">{subject}</p>
									</div>

									<div class="mb-0.5 grid">
										<p class="truncate pr-1 text-xs font-normal">
											{message.content}
										</p>
									</div>

									<div class="flex justify-end">
										<p class="text-xs font-medium">
											{timeAgo(new Date(message.created_at * 1000)) ?? 'Unknown'}
										</p>
									</div>
								</div>
							</div>
						</Card.Root>
					</a>
				{/each}
			</div>

			<div class="fixed bottom-24 right-4">
				<Tooltip.Root openDelay={100}>
					<Tooltip.Trigger asChild let:builder>
						<Button
							builders={[builder]}
							class="h-16 w-16 rounded-2xl shadow-md"
							on:click={() => (openTicketModal = true)}>
							<MessageSquarePlus size={28} />
						</Button>
					</Tooltip.Trigger>
					<Tooltip.Content class="rounded-xl">
						<p>Create new ticket</p>
					</Tooltip.Content>
				</Tooltip.Root>
			</div>
		{/if}
	{:else}
		<div
			class="mx-auto flex h-[450px] max-w-[420px] flex-col items-center justify-center text-center">
			<Ticket size={36} />
			<h3 class="mt-4 text-lg font-semibold">No tickets created</h3>
			<p class="mb-4 mt-2 text-sm text-muted-foreground">
				You have not created any tickets. Create one below.
			</p>
			<Button size="sm" class="w-32 rounded-2xl" on:click={() => (openTicketModal = true)}>
				Create Ticket
			</Button>
		</div>
	{/if}
</main>
