<script lang="ts">
	import { superForm } from 'sveltekit-superforms/client';
	import type { PageData } from './$types';
	import { resetPasswordSchema } from '$lib/schemas/login';
	import * as Card from '$lib/components/ui/card';
	import * as Alert from '$lib/components/ui/alert';
	import { fly, slide } from 'svelte/transition';
	import { AlertCircle, Loader2 } from 'lucide-svelte';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import { Button } from '$lib/components/ui/button';
	import { writable } from 'svelte/store';
	import { createProgress, melt } from '@melt-ui/svelte';
	import { zxcvbnOptions, type OptionsType, zxcvbnAsync, debounce } from '@zxcvbn-ts/core';
	import * as zxcvbnCommonPackage from '@zxcvbn-ts/language-common';
	import * as zxcvbnEnPackage from '@zxcvbn-ts/language-en';
	import { matcherPwnedFactory } from '@zxcvbn-ts/matcher-pwned';

	export let data: PageData;

	const { form, enhance, errors, message, delayed, submitting } = superForm(data.form, {
		validators: resetPasswordSchema,
		delayMs: 500,
		timeoutMs: 8000,
		taintedMessage: false,
		onError({ result }) {
			$message = {
				type: result.type,
				text: result.error.message
			};
		}
	});

	const value = writable(0);

	const {
		elements: { root },
		options: { max }
	} = createProgress({
		value,
		max: 5
	});

	let msg = ['Weak', 'Average', 'Good', 'Strong', 'Very strong'];
	let color = ['#EA2027', '#EE5A24', '#F79F1F', '#A3CB38', '#009432'];
	let isStrong: string;
	let isStrongColor: string;

	const matcherPwned = matcherPwnedFactory(fetch, zxcvbnOptions);
	zxcvbnOptions.addMatcher('pwned', matcherPwned);

	const options: OptionsType = {
		dictionary: {
			...zxcvbnCommonPackage.dictionary,
			...zxcvbnEnPackage.dictionary
		},
		graphs: zxcvbnCommonPackage.adjacencyGraphs,
		translations: zxcvbnEnPackage.translations,
		useLevenshteinDistance: true
	};

	zxcvbnOptions.setOptions(options);

	const getPasswordStrength = () => {
		zxcvbnAsync($form.password).then((response) => {
			$value = response.score.valueOf() + 1;
			isStrong = msg[response.score];
			isStrongColor = color[response.score];
		});
	};

	const debouncedZxcvbn = debounce(getPasswordStrength, 300);
</script>

<section class="w-full">
	<Card.Root class="rounded-xl">
		<Card.Header class="space-y-0">
			<div class="grid gap-1">
				<Card.Title class="text-2xl">Change Password</Card.Title>
			</div>

			{#if $message}
				<div transition:slide class="pt-4">
					<Alert.Root variant="destructive" class="bg-destructive text-destructive-foreground">
						<Alert.Description class="flex items-center">
							<AlertCircle class="mr-2 h-4 w-4" />
							{$message.text}
						</Alert.Description>
					</Alert.Root>
				</div>
			{/if}
		</Card.Header>

		<form method="POST" use:enhance>
			<div class="grid gap-6">
				<Card.Content class="grid gap-4 px-6 py-0">
					<div class="grid gap-2">
						<Label for="email">
							Email
							<sup class="text-destructive">*</sup>
						</Label>
						<Input
							id="email"
							name="email"
							type="email"
							aria-invalid={$errors.email ? 'true' : undefined}
							bind:value={$form.email}
							class="rounded-2xl
                {$errors.email ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.email}
							<p transition:slide class="text-xs font-medium text-destructive">{$errors.email}</p>
						{/if}
					</div>

					<div class="text-sm">
						<p>
							In order to <span class="font-bold">protect your account</span>
							, make sure your password:
						</p>
						<ul class="mb-2 ml-6 mt-4 list-disc [&>li]:mt-2">
							<li>Is longer than 6 characters</li>
							<li>
								Does not match or significantly contain your username, e.g. do not use 'username123'
							</li>
							<li>
								Is not a member of this <a
									href="https://github.com/danielmiessler/SecLists/blob/master/Passwords/Common-Credentials/10-million-password-list-top-100000.txt"
									target="_blank"
									class="underline underline-offset-4 hover:no-underline">
									list of common passwords
								</a>
							</li>
							<li>
								Is not a member of the <a
									href="https://haveibeenpwned.com/Passwords"
									target="_blank"
									class="underline underline-offset-4 hover:no-underline">
									Have I Been Pwned
								</a>
								breach database
							</li>
						</ul>
					</div>

					<div class="grid gap-2">
						<div class="flex items-baseline justify-between">
							<Label for="password">
								New password
								<sup class="text-destructive">*</sup>
							</Label>

							{#if $form.password.length && $value}
								<div class="flex items-baseline" transition:fly>
									<p
										class="mr-1.5 text-xs font-medium leading-none"
										style="color: {isStrongColor};">
										{isStrong}
									</p>

									<div
										use:melt={$root}
										class="relative h-1.5 w-[80px] overflow-hidden rounded-2xl bg-muted">
										<div
											class="h-full w-full transition-transform duration-[660ms]
                      ease-[cubic-bezier(0.65,0,0.35,1)]"
											style={`background: ${isStrongColor}; transform: translateX(-${
												100 - (100 * ($value ?? 0)) / ($max ?? 1)
											}%)`} />
									</div>
								</div>
							{/if}
						</div>

						<Input
							id="password"
							name="password"
							type="password"
							placeholder="At least 6 characters"
							autocomplete="new-password"
							aria-invalid={$errors.password ? 'true' : undefined}
							on:input={debouncedZxcvbn}
							bind:value={$form.password}
							class="rounded-2xl
                {$errors.password ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.password}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.password}
							</p>
						{/if}
					</div>

					<div class="grid gap-2">
						<Label for="confirm">
							Re-enter your new password
							<sup class="text-destructive">*</sup>
						</Label>
						<Input
							id="confirm"
							name="confirm"
							type="password"
							autocomplete="new-password"
							aria-invalid={$errors.confirm ? 'true' : undefined}
							bind:value={$form.confirm}
							class="rounded-2xl
                {$errors.confirm ? 'border-destructive focus-visible:ring-destructive' : ''}" />

						{#if $errors.confirm}
							<p transition:slide class="text-xs font-medium text-destructive">
								{$errors.confirm}
							</p>
						{/if}
					</div>
				</Card.Content>

				<Card.Footer class="grid gap-2">
					<div class={$submitting ? 'cursor-not-allowed' : ''}>
						<Button
							variant="secondary"
							disabled={$submitting}
							class="w-full rounded-2xl font-semibold"
							type="submit">
							{#if $delayed}
								<Loader2 size={16} strokeWidth={2.75} class="mr-4 animate-spin" />
							{/if}
							<span>{$delayed ? 'Saving...' : 'Change password'}</span>
						</Button>
					</div>
				</Card.Footer>
			</div>
		</form>
	</Card.Root>
</section>
