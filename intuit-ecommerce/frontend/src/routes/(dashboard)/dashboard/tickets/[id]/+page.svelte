<script lang="ts">
	import type { PageData } from './$types';
	import type { FloatingConfig } from '@melt-ui/svelte/internal/actions';
	import { ConversationStatus } from '$lib/types/chatwoot';
	import { timeAgo } from '$lib/client/shop';
	import { superForm } from 'sveltekit-superforms/client';
	import { ArrowLeft, CheckCircle, Loader2, MoreVertical, Send } from 'lucide-svelte';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Avatar from '$lib/components/ui/avatar';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import Button from '$lib/components/ui/button/button.svelte';

	export let data: PageData;

	$: ({ ticket } = data);
	// $: console.log(ticket);

	let textarea: HTMLTextAreaElement;
	let changeStatusForm: HTMLFormElement;
	let defaultHeight: number;
	let disabled = false;

	const tooltipPos: FloatingConfig = {
		placement: 'top-start'
	};

	const { form, enhance, delayed } = superForm(data.messageForm, {
		delayMs: 500,
		timeoutMs: 10000,
		taintedMessage: false,
		onResult({ result }) {
			if (result.type === 'redirect') {
				// Reset textarea height
				textarea.style.height = defaultHeight + 'px';
			}
		},
		onSubmit() {
			disabled = true;
		},
		onUpdated({ form }) {
			if (!form.valid) disabled = false;
		},
		onError() {
			disabled = false;
		}
	});

	const { enhance: statusEnhance } = superForm(data.statusForm);

	function autoGrow() {
		const MAX_HEIGHT = 334;

		if (
			textarea.scrollHeight > textarea.clientHeight &&
			textarea.clientHeight <= MAX_HEIGHT &&
			textarea.scrollHeight <= MAX_HEIGHT
		) {
			textarea.style.height = textarea.scrollHeight + 'px';
		} else if (textarea.scrollHeight <= textarea.clientHeight) {
			textarea.style.height = 0 + 'px';
			textarea.style.height = textarea.scrollHeight + 'px';
		}
	}

	$: !$form.content ? (disabled = true) : (disabled = false);
</script>

<main>
	{#if ticket}
		<div class="flex h-[calc(100vh-140px)] flex-col">
			<div
				class="flex w-full border border-l-0 border-r-0 border-t-0 border-border bg-background px-0 py-3">
				<div class="mr-4 flex items-center">
					<a href="/dashboard/tickets">
						<ArrowLeft size={20} class="mr-2" />
					</a>
				</div>

				<div class="flex w-full items-center justify-between">
					<p class="truncate font-semibold">{ticket.subject ?? 'Unknown title'}</p>

					{#if ticket.status === ConversationStatus.OPEN}
						<DropdownMenu.Root>
							<DropdownMenu.Trigger asChild let:builder>
								<Button builders={[builder]} variant="ghost" size="sm" class="rounded-full">
									<MoreVertical size={20} />
								</Button>
							</DropdownMenu.Trigger>
							<DropdownMenu.Content class="w-56 rounded-xl">
								<DropdownMenu.Item
									class="cursor-pointer rounded-lg"
									on:click={() => changeStatusForm.submit()}>
									<CheckCircle class="mr-2 h-4 w-4" />
									<span class="text-medium">Mark issue as resolved</span>
								</DropdownMenu.Item>
							</DropdownMenu.Content>
						</DropdownMenu.Root>
					{/if}
				</div>
			</div>

			<form action="?/changeStatus" method="POST" bind:this={changeStatusForm} use:statusEnhance>
				<input type="hidden" name="conversation_id" value={ticket.id} />
				<input type="hidden" name="status" value="resolved" />
			</form>

			<ul class="flex-1 overflow-y-auto overscroll-contain">
				<div class="mt-6 flex flex-col space-y-8 pb-36">
					{#each ticket.messages as message}
						<li>
							{#if message.sender.type === 'contact'}
								<div class="flex px-1.5">
									<div class="flex w-full flex-col items-end">
										<div class="mb-2 flex items-baseline">
											<p class="mr-4 text-sm font-semibold">You</p>

											<p class="text-xs font-medium text-muted-foreground">
												{timeAgo(new Date(message.created_at * 1000)) ?? 'just now'}
											</p>
										</div>

										<div class="w-11/12 rounded-3xl rounded-tr-none bg-primary/40 px-6 py-1.5">
											<p class="text-sm font-normal text-primary-foreground">{message.content}</p>
										</div>
									</div>

									<div class="ml-4 flex flex-col justify-start">
										<Avatar.Root class="h-8 w-8">
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
										</Avatar.Root>
									</div>
								</div>
							{:else}
								<div class="flex px-1.5">
									<div class="mr-4 flex flex-col justify-start">
										<Avatar.Root class="h-8 w-8">
											<Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" />
											<Avatar.Fallback class="text-sm">C</Avatar.Fallback>
										</Avatar.Root>
									</div>

									<div class="flex w-full flex-col">
										<div class="mb-2 flex items-baseline">
											<p class="mr-4 text-sm font-semibold">{message.sender.available_name}</p>

											<p class="text-xs font-medium text-muted-foreground">
												{timeAgo(new Date(message.created_at * 1000))}
											</p>
										</div>

										<div class="w-11/12 rounded-3xl rounded-tl-none bg-muted/80 px-6 py-1.5">
											<p class="text-sm font-normal">{message.content}</p>
										</div>
									</div>
								</div>
							{/if}
						</li>
					{/each}
				</div>
			</ul>

			{#if ticket.status === ConversationStatus.OPEN}
				<div class="w-full bg-background px-4 py-3">
					<form action="?/reply" method="POST" use:enhance>
						<input type="hidden" name="conversation_id" value={ticket.id} />

						<label for="chat" class="sr-only">Your message</label>
						<div class="flex items-center justify-between">
							<textarea
								on:keyup={autoGrow}
								bind:this={textarea}
								bind:value={$form.content}
								class="mr-2 flex min-h-[36px] w-full resize-none rounded-2xl border border-input bg-transparent px-3 py-2 text-sm shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50"
								id="chat"
								name="content"
								rows="1"
								placeholder="Type a message" />

							<Tooltip.Root openDelay={100} positioning={tooltipPos}>
								<Tooltip.Trigger asChild let:builder>
									<div class={disabled ? 'cursor-not-allowed' : ''}>
										<Button
											{disabled}
											builders={[builder]}
											type="submit"
											size="icon"
											class="h-[37.6px] rounded-lg">
											{#if $delayed}
												<Loader2 size={20} class="animate-spin" />
											{:else}
												<Send size={20} />
											{/if}
										</Button>
									</div>
								</Tooltip.Trigger>
								<Tooltip.Content>
									<span>Send message</span>
								</Tooltip.Content>
							</Tooltip.Root>
						</div>
					</form>
				</div>
			{/if}
		</div>
	{:else}
		<p>Ticket details not found</p>
	{/if}
</main>
