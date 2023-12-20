<script lang="ts">
	import { Loader2, Menu, Search, ShoppingBag, User } from 'lucide-svelte';
	import type { PageData } from './$types';
	import { Button } from '$lib/components/ui/button';
	import * as Sheet from '$lib/components/ui/sheet';
	import * as Avatar from '$lib/components/ui/avatar';
	import * as Alert from '$lib/components/ui/alert';
	import * as Accordion from '$lib/components/ui/accordion';
	import { Separator } from '$lib/components/ui/separator';
	import { Input } from '$lib/components/ui/input';
	import { superForm } from 'sveltekit-superforms/client';
	import { slide } from 'svelte/transition';
	import { PUBLIC_STORE_NAME } from '$env/static/public';
	import { DEFAULT_PAGE_LIMIT } from '$lib/client/shop';
	import { Label } from '$lib/components/ui/label';
	import ThemeSelect from '$lib/components/shop/custom-select/ThemeSelect.svelte';

	export let data: PageData;

	$: ({ categories } = data);
	$: ({ customer } = data.customerData);
	$: ({ cart } = data.customerData);

	const { enhance, delayed, submitting, message } = superForm(data.logoutForm, {
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

	let categoriesOpen = false;
	let accountOpen = false;
	let count = 0;

	function getItemCount() {
		if (cart) {
			const quantities = cart.items.map((i) => i.quantity);
			if (quantities.length) return quantities.reduce((acc, curr) => acc + curr);
		}

		return 0;
	}

	$: if (cart) count = getItemCount();

	const footerLinks: {
		title: string;
		links: {
			name: string;
			url: string;
		}[];
	}[] = [
		{
			title: 'Buy',
			links: [
				{ name: 'Registration', url: '/' },
				{ name: `${PUBLIC_STORE_NAME} Money Back Guarantee`, url: '/' },
				{ name: 'Stores', url: '/' }
			]
		},
		{
			title: 'Sell',
			links: [
				{ name: 'Start Selling', url: '/' },
				{ name: 'Learn to Sell', url: '/' },
				{ name: 'Affiliates & Partners', url: '/' }
			]
		},
		{
			title: 'About Us',
			links: [
				{ name: 'News & Blog', url: '/' },
				{ name: 'Mission Statement & Core Values', url: '/' },
				{ name: 'Sustainability & Governance', url: '/' },
				{ name: 'Advertise with Us', url: '/' }
			]
		},
		{
			title: 'Help & Contact',
			links: [
				{ name: 'Returns', url: '/' },
				{ name: 'Payments', url: '/' },
				{ name: 'Orders', url: '/' },
				{ name: 'Feedback', url: '/' },
				{ name: 'Security & Fraud', url: '/' },
				{ name: 'Seller Information Centre', url: '/' },
				{ name: 'Contact Us', url: '/' }
			]
		},
		{
			title: 'Community & Social Media',
			links: [
				{ name: 'Discussion Boards', url: '/' },
				{ name: 'Announcements', url: '/' },
				{ name: 'Instagram', url: '/' },
				{ name: 'Facebook', url: '/' },
				{ name: 'WhatsApp', url: '/' }
			]
		}
	];
	// $: console.log(customer);
</script>

<div class="min-h-[100lvh]">
	<header
		class="sticky top-0 z-20 mx-auto border-b bg-background px-2 py-4 shadow-sm min-[380px]:px-4">
		<div class="grid gap-3">
			<nav
				class="mx-auto flex w-full max-w-7xl items-center justify-between
        sm:gap-6
        md:gap-10">
				<div class="flex items-center gap-4">
					<Sheet.Root bind:open={categoriesOpen}>
						<Sheet.Trigger>
							<Button variant="ghost" size="icon">
								<Menu size={24} strokeWidth={1.5} />
							</Button>
						</Sheet.Trigger>
						<Sheet.Content side="left" class="overflow-y-scroll">
							<Sheet.Header class="border-b pb-4">
								<Sheet.Title class="text-left text-2xl font-extrabold tracking-tight">
									Menu
								</Sheet.Title>
							</Sheet.Header>

							<div class="grid gap-4 py-4">
								<h3 class="text-left text-xl font-bold leading-none tracking-tight">Categories</h3>
								{#if categories}
									<Accordion.Root class="w-full">
										{#each categories as { category_children, name, handle }}
											<Accordion.Item value="cat-{handle}">
												<Accordion.Trigger class="text-base font-normal underline-offset-4">
													{name}
												</Accordion.Trigger>
												<Accordion.Content>
													{#if category_children}
														<div class="grid gap-4">
															{#each category_children as child}
																<Button
																	on:click={() => (categoriesOpen = false)}
																	href="/categories/{child.handle}?limit={DEFAULT_PAGE_LIMIT}&offset=0"
																	variant="link"
																	class="h-fit justify-start whitespace-normal p-0 pl-4 font-medium text-foreground">
																	{child.name}
																</Button>
															{/each}
														</div>
													{/if}
												</Accordion.Content>
											</Accordion.Item>
										{/each}
									</Accordion.Root>
								{/if}
							</div>
						</Sheet.Content>
					</Sheet.Root>

					<a href="/" class="text-2xl font-normal leading-none tracking-widest">
						{PUBLIC_STORE_NAME.toUpperCase()}
					</a>
				</div>

				<div
					class="hidden w-full
          sm:flex">
					<form action="/search" class="w-full">
						<div class="flex">
							<Input
								id="search"
								name="q"
								type="search"
								placeholder="Search for anything"
								class="h-10 w-full rounded-none rounded-bl-md rounded-tl-md border-none bg-muted shadow-none focus-visible:ring-0" />

							<Button
								size="icon"
								type="submit"
								class="h-10 w-10 rounded-none rounded-br-md rounded-tr-md border-none bg-muted text-muted-foreground shadow-none hover:bg-muted">
								<Search size={16} strokeWidth={1.5} />
							</Button>
						</div>
					</form>
				</div>

				<div class="flex items-center gap-4">
					<Button variant="ghost" size="icon" href="/cart" class="relative">
						<ShoppingBag size={24} strokeWidth={1.5} />
						{#if count > 0}
							<div
								class="absolute -top-1 left-4 flex h-5 w-5 items-center justify-center rounded-full border-2 border-background bg-primary">
								<span class="text-xs font-bold text-black">{count > 99 ? '99' : count}</span>
							</div>
						{/if}
					</Button>

					<Sheet.Root bind:open={accountOpen}>
						<Sheet.Trigger>
							<Button variant="ghost" size="icon" class="relative">
								<User size={24} strokeWidth={1.5} />
								{#if customer}
									<span
										class="absolute left-6 top-0 h-3.5 w-3.5 rounded-full border-2 border-background bg-green-400">
									</span>
								{/if}
							</Button>
						</Sheet.Trigger>
						<Sheet.Content side="right">
							<Sheet.Header class="border-b pb-4">
								<Sheet.Title class="text-left text-2xl font-extrabold tracking-tight">
									Account
								</Sheet.Title>
							</Sheet.Header>

							<div class="grid gap-4 py-4">
								{#if customer}
									<div class="flex w-full flex-col items-center gap-4 font-normal">
										<Avatar.Root class="h-16 w-16">
											<Avatar.Image src="https://i.pravatar.cc/300" alt="" />
											<Avatar.Fallback class="text-2xl">
												{customer.first_name?.at(0)?.toUpperCase()}{customer.last_name
													?.at(0)
													?.toUpperCase()}
											</Avatar.Fallback>
										</Avatar.Root>

										<div class="grid place-items-center gap-2 text-sm font-medium leading-none">
											<p>{customer.first_name} {customer.last_name}</p>
											<p class="text-muted-foreground">{customer.email}</p>
										</div>

										<form
											class="w-full"
											action="/accounts/customer/signout"
											method="POST"
											use:enhance>
											<Button
												on:click={() => (accountOpen = false)}
												disabled={$submitting}
												type="submit"
												variant="secondary"
												class="h-8 w-full rounded-2xl font-semibold">
												{#if $delayed}
													<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
												{/if}
												<span>{$delayed ? 'Signing out...' : 'Sign out'}</span>
											</Button>
										</form>
									</div>

									{#if $message}
										<div transition:slide>
											<Alert.Root
												variant="destructive"
												class="bg-destructive text-destructive-foreground">
												<Alert.Description class="flex items-center">
													{$message.text}
												</Alert.Description>
											</Alert.Root>
										</div>
									{/if}

									<Separator />

									<Button
										on:click={() => (accountOpen = false)}
										href="/account/orders"
										variant="link"
										class="h-fit justify-start gap-3 whitespace-normal p-0 text-base font-normal text-foreground">
										Purchase History
									</Button>
								{:else}
									<Button
										on:click={() => (accountOpen = false)}
										href="/accounts/customer/signin"
										variant="link"
										class="h-fit justify-start gap-3 whitespace-normal p-0 text-base font-normal text-foreground">
										Sign in
									</Button>

									<Button
										on:click={() => (accountOpen = false)}
										href="/accounts/customer/register"
										variant="link"
										class="h-fit justify-start gap-3 whitespace-normal p-0 text-base font-normal text-foreground">
										Create Account
									</Button>

									<Separator />

									<Button
										on:click={() => (accountOpen = false)}
										href="/orders"
										variant="link"
										class="group h-fit justify-between gap-3 whitespace-normal p-0 text-base font-normal text-foreground">
										<span>Orders</span>
										<span
											class="text-muted-foreground group-hover:underline group-hover:decoration-muted-foreground">
											View + manage
										</span>
									</Button>
								{/if}

								<Separator />

								<Button
									on:click={() => (accountOpen = false)}
									href="/accounts/vendor/signin"
									variant="link"
									class="h-fit justify-start gap-3 whitespace-normal p-0 text-base font-normal text-foreground">
									Become a Seller
								</Button>
							</div>
						</Sheet.Content>
					</Sheet.Root>
				</div>
			</nav>

			<div
				class="flex
        sm:hidden">
				<form action="/search" class="w-full">
					<div class="flex">
						<Input
							id="search"
							name="q"
							type="search"
							placeholder="Search for anything"
							class="h-10 w-full rounded-none rounded-bl-md rounded-tl-md border-none bg-muted shadow-none focus-visible:ring-0" />

						<Button
							size="icon"
							type="submit"
							class="h-10 w-10 rounded-none rounded-br-md rounded-tr-md border-none bg-muted text-muted-foreground shadow-none hover:bg-muted">
							<Search size={16} strokeWidth={1.5} />
						</Button>
					</div>
				</form>
			</div>
		</div>
	</header>

	<slot />
</div>

<footer class="mx-auto space-y-6 bg-muted px-4 py-4 xl:px-10">
	<Accordion.Root class="w-full md:hidden">
		{#each footerLinks as { title, links }}
			<Accordion.Item value="item-{title.toLocaleLowerCase()}" class="border-foreground/60">
				<Accordion.Trigger class="text-lg font-semibold underline-offset-4">
					{title}
				</Accordion.Trigger>
				<Accordion.Content>
					<div class="grid gap-4 text-base">
						{#each links as { name, url }}
							<a href={url} class="hover:underline hover:underline-offset-4">{name}</a>
						{/each}
					</div>
				</Accordion.Content>
			</Accordion.Item>
		{/each}
	</Accordion.Root>

	<div class="hidden justify-between gap-4 md:flex">
		{#each footerLinks as { title, links }}
			<div class="grid h-fit gap-4">
				<h4 class="text-base font-semibold tracking-tight">{title}</h4>
				{#each links as { name, url }}
					<a href={url} class="h-fit text-sm hover:underline hover:underline-offset-4">
						{name}
					</a>
				{/each}
			</div>
		{/each}
	</div>

	<div class="flex">
		<div class="grid gap-1.5">
			<Label for="theme">Theme</Label>
			<ThemeSelect label="theme" />
		</div>
	</div>

	<!-- prettier-ignore -->
	<p class="text-sm">&copy; {PUBLIC_STORE_NAME} 2023. <a href="/" class="underline underline-offset-4 text-muted-foreground">Accessibility</a>, <a href="/" class="underline underline-offset-4 text-muted-foreground">User Agreement</a>, <a href="/" class="underline underline-offset-4 text-muted-foreground">Privacy</a>, <a href="/" class="underline underline-offset-4 text-muted-foreground">Accepted Payments</a>, <a href="/" class="underline underline-offset-4 text-muted-foreground">Terms of Use</a>.</p>
</footer>
