<script lang="ts">
	import Adidas from '$lib/assets/brands/Adidas.svelte';
	import Apple from '$lib/assets/brands/Apple.svelte';
	import Fujifilm from '$lib/assets/brands/Fujifilm.svelte';
	import Lg from '$lib/assets/brands/Lg.svelte';
	import Mastercard from '$lib/assets/brands/Mastercard.svelte';
	import Nike from '$lib/assets/brands/Nike.svelte';
	import Nikon from '$lib/assets/brands/Nikon.svelte';
	import Paypal from '$lib/assets/brands/Paypal.svelte';
	import Playstation from '$lib/assets/brands/Playstation.svelte';
	import Reebok from '$lib/assets/brands/Reebok.svelte';
	import Samsung from '$lib/assets/brands/Samsung.svelte';
	import Sony from '$lib/assets/brands/Sony.svelte';
	import Visa from '$lib/assets/brands/Visa.svelte';
	import Xbox from '$lib/assets/brands/Xbox.svelte';
	import Facebook from '$lib/assets/icons/Facebook.svelte';
	import Instagram from '$lib/assets/icons/Instagram.svelte';
	import Whatsapp from '$lib/assets/icons/Whatsapp.svelte';
	import { AspectRatio } from '$lib/components/ui/aspect-ratio';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { CircleDollarSign, CreditCard, HeartHandshake, Image, ShieldCheck } from 'lucide-svelte';
	import img_auto_car from '$lib/assets/images/cat-auto-1.webp?enhanced';
	import img_girl_dress from '$lib/assets/images/cat-clothing-1.webp?enhanced';
	import img_phone from '$lib/assets/images/cat-electronics-1.jpg?enhanced';
	import img_fruit from '$lib/assets/images/cat-grocery-2.jpg?enhanced';
	import img_gamepad from '$lib/assets/images/cat-video-games-2.jpg?enhanced';
	import img_sneaker from '$lib/assets/images/cat-sneakers-1.webp?enhanced';
	import img_pet from '$lib/assets/images/cat-pets-1.webp?enhanced';
	import img_beauty from '$lib/assets/images/cat-cosmetics-1.webp?enhanced';
	import img_chair from '$lib/assets/images/cat-furniture-1.webp?enhanced';
	import img_toys from '$lib/assets/images/cat-toys-1.webp?enhanced';
	import img_books from '$lib/assets/images/cat-books-1.webp?enhanced';
	import img_watch from '$lib/assets/images/cat-watches-1.webp?enhanced';
	import img_mugs from '$lib/assets/images/cat-kitchen-1.webp?enhanced';
	import img_ring from '$lib/assets/images/cat-jewelry-1.webp?enhanced';
	import img_football from '$lib/assets/images/cat-sports-1.webp?enhanced';
	import img_cosmetics from '$lib/assets/images/sale-cosmetics.png?enhanced';
	import img_game_console from '$lib/assets/images/sale-game-console.png?enhanced';
	import img_hero from '$lib/assets/images/hero-gift-couple.png?enhanced';
	import img_hero__cropped from '$lib/assets/images/hero-gift-couple--cropped.png?enhanced';
	import img_gamer from '$lib/assets/images/section-gifts-level-up-game--cropped.jpg?enhanced';
	import img_tech_bro from '$lib/assets/images/section-gadgets-for-teens--cropped.jpg?enhanced';
	import img_tech_laptop from '$lib/assets/images/section-tech-gifts-for-dad.jpg?enhanced';
	import { writable } from 'svelte/store';
	import { createProgress, melt } from '@melt-ui/svelte';
	import Countdown from '$lib/components/shop/countdown';
	import dayjs from 'dayjs';
	import duration from 'dayjs/plugin/duration';
	import tz from 'dayjs/plugin/timezone';
	import { onMount } from 'svelte';
	import type { PageServerData } from './$types';
	import {
		convertToDecimal,
		formatPrice,
		getProductVariantPricing,
		isPricingVariable
	} from '$lib/client/shop';
	import { PUBLIC_STORE_CURRENCY_CODE } from '$env/static/public';

	dayjs.extend(duration);
	dayjs.extend(tz);

	export let data: PageServerData;

	const { flash_deal, carousel_1, carousel_2 } = data;

	let flash_price_int: number;
	let flash_price_dec: string;
	let flash_savings: string;
	let cost_price: string;

	$: if (flash_deal) {
		let value = getProductVariantPricing(
			flash_deal.variants?.flatMap((v) => v.prices ?? []) ?? [],
			PUBLIC_STORE_CURRENCY_CODE
		).low;

		const price = convertToDecimal(value);
		const discount = price * 0.9;
		const savings = price - discount;

		cost_price = formatPrice(value);

		flash_price_int = Math.trunc(discount);
		flash_price_dec = new Intl.NumberFormat('en-US', {
			maximumFractionDigits: 2,
			minimumFractionDigits: 2
		})
			.format(discount)
			.split('.')[1];

		flash_savings = new Intl.NumberFormat('en-US', {
			style: 'currency',
			currency: PUBLIC_STORE_CURRENCY_CODE,
			maximumFractionDigits: 2,
			minimumFractionDigits: 2
		}).format(savings);
	}

	const countdown_end_date = `${dayjs().add(1, 'day').toISOString().split('T')[0]} 00:00:00`;

	let now = dayjs();
	let sale_end_date = now.endOf('day');
	let diff = sale_end_date.valueOf() - now.valueOf();
	let remaining_hours = dayjs.duration(diff).asHours();

	const value = writable(remaining_hours);
	const {
		elements: { root },
		options: { max }
	} = createProgress({
		value,
		max: 24
	});

	let colour = ['#EA2027', '#EE5A24', '#F79F1F', '#A3CB38'];
	let current_colour = colour.at(-1);

	let popular_categories: { name: String; thumbnail?: string }[] = [
		{ name: 'Clothing', thumbnail: img_girl_dress },
		{ name: 'Beauty', thumbnail: img_beauty },
		{ name: 'Jewelry', thumbnail: img_ring },
		{ name: 'Watches', thumbnail: img_watch },
		{ name: 'Sneakers', thumbnail: img_sneaker },
		{ name: 'Electronics', thumbnail: img_phone },
		{ name: 'Video Games', thumbnail: img_gamepad },
		{ name: 'Toys', thumbnail: img_toys },
		{ name: 'Pets', thumbnail: img_pet },
		{ name: 'Books', thumbnail: img_books },
		{ name: 'Furniture', thumbnail: img_chair },
		{ name: 'Sports', thumbnail: img_football },
		{ name: 'Groceries', thumbnail: img_fruit },
		{ name: 'Kitchen', thumbnail: img_mugs },
		{ name: 'Automotive', thumbnail: img_auto_car }
	];

	let brandLogos = [
		Adidas,
		Apple,
		Playstation,
		Nike,
		Samsung,
		Reebok,
		Sony,
		Lg,
		Nikon,
		Fujifilm,
		Xbox
	];

	onMount(() => {
		current_colour = getRemainingHoursColour();
	});

	function getRemainingHoursColour() {
		if (remaining_hours <= 6) {
			return colour[0];
		} else if (remaining_hours <= 12) {
			return colour[1];
		} else if (remaining_hours <= 18) {
			return colour[2];
		} else if (remaining_hours <= 24) {
			return colour.at(-1);
		}
	}
</script>

<main class="max-w-7xl xl:mx-auto">
	<div class="grid gap-8 pb-10 pt-2">
		<div class="mt-2 px-2 min-[380px]:px-4">
			<div
				class="grid grid-cols-2 gap-2
        sm:grid-cols-4
        xl:gap-4">
				<div
					class="col-start-1 col-end-3
          sm:row-span-2
          xl:col-start-2 xl:col-end-4 xl:row-span-full">
					<a href="/" class="h-full w-full">
						<Card.Root
							class="group relative aspect-[3/4] overflow-clip bg-white
              sm:aspect-auto sm:h-full sm:w-full">
							<div
								class="absolute left-4 top-4 grid gap-2
                xl:top-2 xl:flex xl:items-center xl:gap-8">
								<h3
									class="text-3xl font-bold tracking-tight text-black
                  xl:text-4xl">
									Top Holiday Gifts
								</h3>

								<Button
									variant="secondary"
									class="h-8 w-fit rounded-2xl bg-black text-white group-hover:bg-black/80">
									See all
								</Button>
							</div>

							<div
								class="absolute bottom-0
                xl:-bottom-28">
								<enhanced:img src={img_hero__cropped} loading="eager" fetchpriority="high" />
							</div>
						</Card.Root>
					</a>
				</div>

				<div
					class="col-start-1 col-end-2
          sm:col-start-3 sm:col-end-4
          xl:col-start-1 xl:col-end-2">
					<a href="/" class="h-full w-full">
						<Card.Root
							class="group relative aspect-[3/5] overflow-clip
              sm:aspect-[3/6]">
							<div class="absolute top-2 z-10 flex w-full items-center justify-between px-2">
								<span
									class="text-xl font-semibold tracking-tighter text-white
                  xl:text-3xl">
									Level up!
								</span>
							</div>

							<div class="absolute bottom-2 right-2 z-10">
								<Button
									variant="secondary"
									class="h-7 rounded-2xl bg-white/50 font-normal text-black backdrop-blur group-hover:bg-white/60
                    xl:h-8 xl:text-base">
									Shop now
								</Button>
							</div>

							<div class="absolute top-0 h-full w-full">
								<enhanced:img src={img_gamer} class="h-full w-full object-cover" loading="eager" />
							</div>
						</Card.Root>
					</a>
				</div>

				<div
					class="col-start-2 col-end-3
          sm:col-start-4 sm:col-end-5">
					<a href="/" class="h-full w-full">
						<Card.Root
							class="group relative aspect-[3/5] overflow-clip
              sm:aspect-[3/6]">
							<div class="absolute left-2 top-2 z-10 w-8">
								<span
									class="text-xl font-semibold tracking-tighter text-cyan-950
                  xl:text-3xl">
									Ready, set, GO!
								</span>

								<Button
									variant="link"
									class="h-8 px-0 font-normal text-cyan-950 underline underline-offset-4
                    xl:text-base">
									Shop now
								</Button>
							</div>

							<div class="absolute top-0 h-full w-full">
								<enhanced:img
									src={img_tech_bro}
									class="h-full w-full object-cover"
									loading="eager" />
							</div>
						</Card.Root>
					</a>
				</div>

				<div
					class="col-start-1 col-end-3
          sm:col-start-3 sm:col-end-5
          xl:col-start-2 xl:col-end-4">
					<a href="/" class="h-full w-full">
						<Card.Root class="group relative aspect-[5/3] overflow-clip">
							<div
								class="absolute bottom-0 z-10 flex w-full items-center justify-between px-4 pb-2
                  xl:pb-4">
								<span
									class="text-xl font-semibold tracking-tighter text-black
                  xl:text-3xl">
									Tech for dad
								</span>

								<Button
									variant="link"
									class="h-8 font-normal text-black underline underline-offset-4
                    xl:text-base">
									Shop now
								</Button>
							</div>

							<div class="absolute top-0 h-full w-full">
								<enhanced:img
									src={img_tech_laptop}
									class="h-full w-full object-cover"
									loading="lazy" />
							</div>
						</Card.Root>
					</a>
				</div>
			</div>
		</div>

		<!-- Flash Deal -->
		{#if flash_deal}
			<div class="grid gap-3 px-2 pb-4 pt-2 min-[380px]:px-4">
				<h3 class="text-center text-4xl font-semibold tracking-tight text-rose-600">
					<span class="text-amber-500">Flash</span>
					Deal
				</h3>

				<a href="/products/{flash_deal.handle}" class="h-fit w-fit justify-self-center">
					<Card.Root class="group max-h-[230px] max-w-[440px] overflow-clip hover:bg-muted">
						<div class="grid grid-flow-col grid-cols-5 gap-2">
							<div class="col-span-2">
								{#if flash_deal.thumbnail}
									<img class="h-full w-full object-cover" src={flash_deal.thumbnail} alt="" />
								{:else}
									<Image strokeWidth={1} class="h-full w-full" />
								{/if}
							</div>

							<div class="col-span-3 flex flex-col justify-evenly py-2 pr-2">
								<p
									class="line-clamp-3 text-base font-medium text-foreground group-hover:underline group-hover:underline-offset-4">
									{flash_deal.title}
								</p>

								<div class="grid">
									<div class="flex">
										<span class="text-5xl font-semibold">${flash_price_int}</span>
										<span class="text-base font-bold leading-6">{flash_price_dec}</span>
									</div>

									<div class="flex gap-2">
										<span class="text-sm font-medium text-muted-foreground">
											<strike>{cost_price}</strike>
										</span>
										<span class="text-sm font-medium text-green-600">
											Save {flash_savings}
										</span>
									</div>
								</div>

								<div class="grid w-fit gap-1">
									<p class="text-sm font-medium">
										<Countdown
											from={countdown_end_date}
											dateFormat="YYYY-MM-DD HH:mm:ss"
											zone="America/Port_of_Spain"
											let:remaining>
											<div class="inline font-bold">
												{#if remaining.done === false}
													Deal ends in <span style="color: {current_colour};">
														{remaining.hours.toLocaleString('en-US', {
															minimumIntegerDigits: 2,
															useGrouping: false
														})}:{remaining.minutes.toLocaleString('en-US', {
															minimumIntegerDigits: 2,
															useGrouping: false
														})}:{remaining.seconds.toLocaleString('en-US', {
															minimumIntegerDigits: 2,
															useGrouping: false
														})}
													</span>
												{:else}
													<span>The sale has ended!</span>
												{/if}
											</div>
										</Countdown>
									</p>

									<div
										use:melt={$root}
										class="relative h-1.5 w-full overflow-hidden rounded-2xl bg-muted">
										<div
											class="h-full w-full transition-transform duration-[660ms]
                        ease-[cubic-bezier(0.65,0,0.35,1)]"
											style={`background: ${current_colour}; transform: translateX(-${
												100 - (100 * ($value ?? 0)) / ($max ?? 1)
											}%)`} />
									</div>
								</div>
							</div>
						</div>
					</Card.Root>
				</a>
			</div>
		{/if}

		<!-- Featured Brands -->
		<div class="container mx-auto grid gap-3 px-2 py-2 min-[380px]:px-4">
			<h3 class="text-center text-2xl font-semibold tracking-normal">Featured brands</h3>
			<div
				class="no-scrollbar no-scrollbar::-webkit-scrollbar grid grid-flow-col gap-3 overflow-auto pb-3">
				{#each brandLogos as logo}
					<a href="/">
						<div
							class="h-fit w-[100px] rounded-lg border border-muted p-2 hover:bg-muted
                md:w-[120px]
                xl:w-[160px]">
							<AspectRatio ratio={3.5 / 2.5}>
								<svelte:component this={logo} class="h-full w-full" />
							</AspectRatio>
						</div>
					</a>
				{/each}
			</div>
		</div>

		<!-- Category Sales -->
		<div class="grid gap-3 px-2 py-4 min-[380px]:px-4">
			<h3 class="text-center text-2xl font-semibold tracking-normal">Save big on top gifts</h3>

			<div class="flex justify-center gap-2 md:gap-4">
				<Card.Root
					class="relative aspect-[3/6] h-full max-h-[560px] w-full max-w-[280px] overflow-clip">
					<a href="/" class="h-full w-full">
						<div class="absolute left-3 top-3 grid text-[#3DA259]">
							<div class="grid">
								<span class="text-[18px] font-bold leading-none">Up to</span>
								<div class="flex items-end">
									<p class="text-[60px] font-bold leading-none">15</p>
									<div class="grid">
										<p class="text-[34px] font-bold leading-[17px]">%</p>
										<p class="text-[18px] font-bold leading-[31px] tracking-wide">off</p>
									</div>
								</div>
							</div>

							<div class="flex">
								<p class="text-sm font-normal leading-tight">Cosmetics & beauty products</p>
							</div>
						</div>

						<div class="absolute bottom-0 left-4 grid h-full w-full">
							<span class="h-1/3 w-full self-end rounded-xl bg-[#3DA259]" />
						</div>

						<div class="absolute bottom-10">
							<enhanced:img src={img_cosmetics} loading="lazy" />
						</div>
					</a>
				</Card.Root>

				<Card.Root
					class="relative aspect-[3/6] h-full max-h-[560px] w-full max-w-[280px] overflow-clip">
					<a href="/" class="h-full w-full">
						<div class="absolute left-3 top-3 grid text-white">
							<div class="z-10 grid">
								<span class="text-[18px] font-bold leading-none">Up to</span>
								<div class="flex items-end">
									<p class="text-[60px] font-bold leading-none">30</p>
									<div class="grid">
										<p class="text-[34px] font-bold leading-[17px]">%</p>
										<p class="text-[18px] font-bold leading-[31px] tracking-wide">off</p>
									</div>
								</div>
							</div>

							<div class="z-10 flex">
								<p class="text-sm font-normal leading-tight">Video games</p>
							</div>
						</div>

						<div class="absolute bottom-0 right-4 grid h-full w-full">
							<span class="h-2/3 w-full rounded-xl bg-[#CC0103]" />
						</div>

						<div class="absolute bottom-11">
							<enhanced:img src={img_game_console} loading="lazy" />
						</div>
					</a>
				</Card.Root>
			</div>
		</div>

		<!-- Product Carousel: Sneakers -->
		{#if carousel_1}
			<div
				class="grid gap-3 px-2 py-2
        md:container min-[380px]:px-4 sm:py-0
        sm:pb-0 sm:pt-2 md:mx-auto">
				<h3 class="text-center text-2xl font-semibold tracking-normal">
					Score these trending kicks
				</h3>

				<div
					class="no-scrollbar no-scrollbar::-webkit-scrollbar grid grid-flow-col gap-3 overflow-auto pb-3">
					{#each carousel_1 as { thumbnail, title, variants, handle }, i}
						<a href="/products/{handle}" class="w-fit">
							<Card.Root class="group h-full w-[135px] overflow-clip hover:bg-muted">
								<div class="flex h-full flex-col">
									{#if thumbnail}
										<AspectRatio ratio={3 / 4}>
											<img
												class="h-full w-full object-cover"
												src={thumbnail}
												alt=""
												loading={i === 0 || i === 1 ? 'eager' : 'lazy'} />
										</AspectRatio>
									{:else}
										<Image strokeWidth={1} class="h-full w-full" />
									{/if}

									<div class="grid gap-1 px-2 pb-4 pt-2">
										<p
											class="text-sm leading-none text-muted-foreground group-hover:underline group-hover:underline-offset-4">
											{#if isPricingVariable(getProductVariantPricing(variants?.flatMap((v) => v.prices ?? []) ?? [], PUBLIC_STORE_CURRENCY_CODE))}
												From
											{/if}
											<span class="font-semibold text-foreground">
												{formatPrice(
													getProductVariantPricing(
														variants?.flatMap((v) => v.prices ?? []) ?? [],
														PUBLIC_STORE_CURRENCY_CODE
													).low
												)}
											</span>
										</p>

										<p
											class="line-clamp-3 w-fit text-sm text-foreground group-hover:underline group-hover:underline-offset-4">
											{title}
										</p>
									</div>
								</div>
							</Card.Root>
						</a>
					{/each}
				</div>
			</div>
		{/if}

		<!-- Product Carousel: Clothing -->
		{#if carousel_2}
			<div
				class="grid gap-3 px-2 py-2
        md:container min-[380px]:px-4 sm:py-0
        sm:pb-2 sm:pt-0 md:mx-auto
        ">
				<h3 class="text-center text-2xl font-semibold tracking-normal">Arrive in style</h3>

				<div
					class="no-scrollbar no-scrollbar::-webkit-scrollbar grid grid-flow-col gap-3 overflow-auto pb-3">
					{#each carousel_2 as { thumbnail, title, variants, handle }, i}
						<a href="/products/{handle}" class="w-fit">
							<Card.Root class="group h-full w-[135px] overflow-clip hover:bg-muted">
								<div class="flex h-full flex-col">
									{#if thumbnail}
										<AspectRatio ratio={3 / 4}>
											<img
												class="h-full w-full object-cover"
												src={thumbnail}
												alt=""
												loading={i === 0 || i === 1 ? 'eager' : 'lazy'} />
										</AspectRatio>
									{:else}
										<Image strokeWidth={1} class="h-full w-full" />
									{/if}

									<div class="grid gap-1 px-2 pb-4 pt-2">
										<p
											class="text-sm leading-none text-muted-foreground group-hover:underline group-hover:underline-offset-4">
											{#if isPricingVariable(getProductVariantPricing(variants?.flatMap((v) => v.prices ?? []) ?? [], PUBLIC_STORE_CURRENCY_CODE))}
												From
											{/if}
											<span class="font-semibold text-foreground">
												{formatPrice(
													getProductVariantPricing(
														variants?.flatMap((v) => v.prices ?? []) ?? [],
														PUBLIC_STORE_CURRENCY_CODE
													).low
												)}
											</span>
										</p>

										<p
											class="line-clamp-3 w-fit text-sm text-foreground group-hover:underline group-hover:underline-offset-4">
											{title}
										</p>
									</div>
								</div>
							</Card.Root>
						</a>
					{/each}
				</div>
			</div>
		{/if}

		<!-- Popular Categories -->
		<div class="grid gap-3 px-2 pb-6 pt-4 min-[380px]:px-6">
			<h3 class="text-center text-2xl font-semibold tracking-normal">Popular categories</h3>

			<div
				class="flex flex-wrap justify-center gap-6 px-2
        sm:gap-9">
				{#each popular_categories as { name, thumbnail }}
					<a href="/">
						<div class="group grid place-items-center gap-1">
							<div
								class="h-[90px] w-[90px] overflow-hidden rounded-full border border-input
                sm:h-[120px] sm:w-[120px]
                xl:h-[175px] xl:w-[175px]">
								{#if thumbnail}
									<enhanced:img src={thumbnail} alt="" loading="lazy" />
								{:else}
									<Image strokeWidth={1} class="h-full w-full" />
								{/if}
							</div>
							<p class="truncate text-sm font-medium group-hover:underline">{name}</p>
						</div>
					</a>
				{/each}
			</div>
		</div>

		<!-- Highlights -->
		<div
			class="grid grid-cols-2 gap-6 bg-muted px-2 py-6 min-[380px]:px-4 md:grid-cols-4 md:gap-10 md:py-10">
			<div class="flex flex-col items-center gap-2 text-center">
				<CircleDollarSign size={32} strokeWidth={1.5} />
				<h4 class="mt-2 font-semibold leading-tight">Great value</h4>
				<p class="text-sm text-muted-foreground">We offer competitive prices on many products.</p>
			</div>

			<div class="flex flex-col items-center gap-2 text-center">
				<CreditCard size={32} strokeWidth={1.5} />
				<h4 class="mt-2 font-semibold leading-tight">Safe payment</h4>
				<p class="text-sm text-muted-foreground">
					Pay with the region's most popular and secure payment methods.
				</p>
			</div>

			<div class="flex flex-col items-center gap-2 text-center">
				<ShieldCheck size={32} strokeWidth={1.5} />
				<h4 class="mt-2 font-semibold leading-tight">Shop with confidence</h4>
				<p class="text-sm text-muted-foreground">
					Our Buyer Protectin policy covers your entire purchase journey.
				</p>
			</div>

			<div class="flex flex-col items-center gap-2 text-center">
				<HeartHandshake size={32} strokeWidth={1.5} />
				<h4 class="mt-2 font-semibold leading-tight">Help centre</h4>
				<p class="text-sm text-muted-foreground">
					Around-the-clock assistance for a smooth shopping experience.
				</p>
			</div>
		</div>

		<!-- Payment Methods -->
		<div
			class="grid place-items-center gap-3 px-2 py-4 min-[380px]:px-4
      xl:flex xl:items-center xl:justify-center xl:gap-6">
			<h3 class="text-2xl font-semibold tracking-normal">Ways to pay</h3>

			<div class="flex gap-6">
				<div class="h-fit w-[80px] rounded-lg border border-muted p-2">
					<AspectRatio ratio={3.37 / 2.125}>
						<Visa class="h-full w-full" />
					</AspectRatio>
				</div>

				<div class="h-fit w-[80px] rounded-lg border border-muted p-2">
					<AspectRatio ratio={3.37 / 2.125}>
						<Mastercard class="h-full w-full" />
					</AspectRatio>
				</div>

				<div class="h-fit w-[80px] rounded-lg border border-muted p-2">
					<AspectRatio ratio={3.37 / 2.125}>
						<Paypal class="h-full w-full" />
					</AspectRatio>
				</div>
			</div>
		</div>

		<!-- Social Media -->
		<div class="flex items-center justify-center gap-6 px-2 pb-4 pt-10 min-[380px]:px-4">
			<h3 class="text-2xl font-semibold tracking-normal">Connect with us</h3>

			<div class="flex gap-3">
				<a href="/" class="hover:text-[#E1306C]">
					<Instagram class="h-8 w-8" />
				</a>
				<a href="/" class="hover:text-[#4267B2]">
					<Facebook class="h-8 w-8" />
				</a>
				<a href="/" class="hover:text-[#25D366]">
					<Whatsapp class="h-8 w-8" />
				</a>
			</div>
		</div>

		<!-- Newsletter -->
		<div
			class="grid gap-3 px-2 pb-10 pt-4 min-[380px]:px-4
        xl:flex xl:items-center xl:justify-center xl:gap-4">
			<h3
				class="w-full text-center text-xl font-semibold tracking-normal
        xl:w-fit">
				Get top deals, latest trends, and more.
			</h3>

			<div class="flex justify-center gap-2">
				<Input placeholder="E-mail address" type="email" class="max-w-[233px] rounded-2xl" />
				<Button variant="secondary" class="w-[90px] rounded-2xl font-semibold">Sign Up</Button>
			</div>
		</div>
	</div>
</main>
