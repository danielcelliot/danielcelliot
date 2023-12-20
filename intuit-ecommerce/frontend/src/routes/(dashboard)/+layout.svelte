<script lang="ts">
	import { page } from '$app/stores';
	import * as Avatar from '$lib/components/ui/avatar';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Sheet from '$lib/components/ui/sheet';
	import * as Tooltip from '$lib/components/ui/tooltip';
	import { setMode, resetMode, mode } from 'mode-watcher';
	import {
		LayoutDashboard,
		LogOut,
		MessageSquare,
		Moon,
		Shirt,
		ShoppingCart,
		Store,
		Sun,
		User
	} from 'lucide-svelte';
	import { afterUpdate } from 'svelte';
	import { superForm } from 'sveltekit-superforms/client';

	export let data;

	let navbar: HTMLDivElement;
	let signoutForm: HTMLFormElement;
	let navbarHeight: number;
	let showComingSoonMessage = false;

	$: ({ user } = data);
	$: ({ store } = data);

	afterUpdate(() => {
		if (navbar) navbarHeight = navbar.clientHeight;
	});

	const isActive = (path: string, exact: boolean) => {
		if (exact) return path === $page.url.pathname;
		return $page.url.pathname.includes(path);
	};

	const { enhance, message } = superForm(data.logoutForm, {
		taintedMessage: false,
		delayMs: 500,
		timeoutMs: 8000,
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});
</script>

<!-- Top Menu Bar -->
<div class="container z-10 flex items-center justify-between px-2 py-2 min-[380px]:px-4">
	<h4 class="scroll-m-20 text-xl font-semibold tracking-tight">
		{store?.name} Store
	</h4>

	<DropdownMenu.Root>
		<DropdownMenu.Trigger>
			<Avatar.Root class="cursor-pointer">
				<Avatar.Image src="https://i.pravatar.cc/300" alt="" />
				<Avatar.Fallback>
					{user?.first_name && user.last_name
						? `${user.first_name.charAt(0).toUpperCase()}${user.last_name.charAt(0).toUpperCase()}`
						: `${user?.email.charAt(0).toUpperCase()}`}
				</Avatar.Fallback>
			</Avatar.Root>
		</DropdownMenu.Trigger>
		<DropdownMenu.Content class="rounded-xl">
			<DropdownMenu.Group>
				<DropdownMenu.Label>
					{#if user?.first_name && user.last_name}
						<span class="block text-sm">{user.first_name} {user.last_name}</span>
					{/if}
					<span class="block truncate text-sm font-normal">
						{user?.email ?? ''}
					</span>
				</DropdownMenu.Label>
				<DropdownMenu.Separator />
				<DropdownMenu.Item class="cursor-pointer rounded-lg" href="/dashboard/profile">
					<User class="mr-2 h-4 w-4" />
					<span>Profile</span>
				</DropdownMenu.Item>
				<DropdownMenu.Item class="cursor-pointer rounded-lg" href="/dashboard/settings">
					<Store class="mr-2 h-4 w-4" />
					<span>My Store</span>
				</DropdownMenu.Item>
				<DropdownMenu.Separator />
				<DropdownMenu.Sub>
					<DropdownMenu.SubTrigger class="cursor-pointer rounded-lg">
						{#if $mode === 'light'}
							<Sun class="mr-2 h-4 w-4" />
						{:else}
							<Moon class="mr-2 h-4 w-4" />
						{/if}
						<span>Theme</span>
					</DropdownMenu.SubTrigger>
					<DropdownMenu.SubContent class="rounded-xl">
						<DropdownMenu.Item class="cursor-pointer rounded-lg" on:click={() => setMode('light')}>
							Light
						</DropdownMenu.Item>
						<DropdownMenu.Item class="cursor-pointer rounded-lg" on:click={() => setMode('dark')}>
							Dark
						</DropdownMenu.Item>
						<DropdownMenu.Item class="cursor-pointer rounded-lg" on:click={() => resetMode()}>
							System
						</DropdownMenu.Item>
					</DropdownMenu.SubContent>
				</DropdownMenu.Sub>
			</DropdownMenu.Group>
			<DropdownMenu.Separator />
			<DropdownMenu.Group>
				<form
					bind:this={signoutForm}
					class="w-full"
					action="/accounts/vendor/signout"
					method="POST"
					use:enhance>
					<DropdownMenu.Item
						class="cursor-pointer rounded-lg"
						on:click={() => signoutForm.requestSubmit()}>
						<LogOut class="mr-2 h-4 w-4" />
						<span>Sign out</span>
					</DropdownMenu.Item>
				</form>
			</DropdownMenu.Group>
		</DropdownMenu.Content>
	</DropdownMenu.Root>
</div>

<div class="container" style="margin-bottom: {navbarHeight}px;">
	<slot />
</div>

<div
	class="fixed bottom-0 z-10 w-full overflow-auto border-t bg-card px-2 min-[380px]:px-4"
	bind:this={navbar}>
	<!-- Bottom navigation -->
	{#key $page.url.pathname}
		<nav class="container flex justify-between py-3">
			<!-- Dashboard -->
			<Tooltip.Root openDelay={100}>
				<Tooltip.Trigger disabled>
					<button
						on:click={() => (showComingSoonMessage = true)}
						class="flex min-w-[52px] grow cursor-not-allowed flex-col items-center justify-center overflow-hidden whitespace-nowrap font-medium text-muted-foreground">
						<div class="mb-1 rounded-3xl px-6 py-1.5">
							<LayoutDashboard class="h-5 w-5" />
						</div>

						<small class="text-sm">Dashboard</small>
					</button>
				</Tooltip.Trigger>
				<Tooltip.Content class="rounded-xl bg-foreground text-background">
					<p>Coming soon!</p>
				</Tooltip.Content>
			</Tooltip.Root>

			<!-- Orders -->
			<a href="/dashboard/orders" class="group">
				<div
					class="flex min-w-[52px] grow flex-col items-center justify-center overflow-hidden whitespace-nowrap
          {isActive('/dashboard/orders', false)
						? 'font-semibold'
						: 'font-medium text-muted-foreground'}">
					<div
						class="mb-1 rounded-3xl px-6 py-1.5
              {isActive('/dashboard/orders', false) ? 'bg-primary/20' : 'group-hover:bg-muted'}">
						<ShoppingCart
							class="h-5 w-5 {isActive('/dashboard/orders', false) ? 'fill-primary' : ''}" />
					</div>

					<small class="text-sm">Orders</small>
				</div>
			</a>

			<!-- Products -->
			<a href="/dashboard/products" class="group">
				<div
					class="flex min-w-[52px] grow flex-col items-center justify-center overflow-hidden whitespace-nowrap
          {isActive('/dashboard/products', false)
						? 'font-semibold'
						: 'font-medium text-muted-foreground'}">
					<div
						class="mb-1 rounded-3xl px-6 py-1.5
              {isActive('/dashboard/products', false) ? 'bg-primary/20' : 'group-hover:bg-muted'}">
						<Shirt class="h-5 w-5 {isActive('/dashboard/products', false) ? 'fill-primary' : ''}" />
					</div>

					<small class="text-sm">Products</small>
				</div>
			</a>

			<!-- Messages -->
			<Tooltip.Root openDelay={100}>
				<Tooltip.Trigger disabled>
					<button
						on:click={() => (showComingSoonMessage = true)}
						class="flex min-w-[52px] grow cursor-not-allowed flex-col items-center justify-center overflow-hidden whitespace-nowrap font-medium text-muted-foreground">
						<div class="mb-1 rounded-3xl px-6 py-1.5">
							<MessageSquare class="h-5 w-5" />
						</div>

						<small class="text-sm">Messages</small>
					</button>
				</Tooltip.Trigger>
				<Tooltip.Content class="rounded-xl bg-foreground text-background">
					<p>Coming soon!</p>
				</Tooltip.Content>
			</Tooltip.Root>
		</nav>
	{/key}
</div>

<Sheet.Root bind:open={showComingSoonMessage}>
	<Sheet.Content side="bottom">
		<Sheet.Header class="pb-4">
			<Sheet.Title>Coming soon!</Sheet.Title>
		</Sheet.Header>
	</Sheet.Content>
</Sheet.Root>
