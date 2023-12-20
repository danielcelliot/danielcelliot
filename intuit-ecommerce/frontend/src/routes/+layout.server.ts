import { dev } from '$app/environment';
import { loadFlash, flashCookieOptions } from 'sveltekit-flash-message/server';

flashCookieOptions.sameSite = 'lax';
flashCookieOptions.path = '/';
flashCookieOptions.secure = !dev;

export const load = loadFlash(async () => {});
