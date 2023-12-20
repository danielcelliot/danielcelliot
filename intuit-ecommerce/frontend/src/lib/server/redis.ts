import { Redis } from 'ioredis';
import { createHash } from 'crypto';
import { REDIS_CACHE_URL } from '$env/static/private';

export const redisClient = new Redis(REDIS_CACHE_URL);

export function fetchFromCache(prefix = '', key: string) {
	return redisClient.get(`${prefix}${key}`);
}

export function saveToCache(prefix = '', key: string, value: string, ttl = 0) {
	return redisClient.set(`${prefix}${key}`, value, 'EX', ttl);
}

export function deleteFromCache(prefix = '', key: string) {
	return redisClient.del(`${prefix}${key}`);
}

export function fetchSessionFromCache(cookie: string) {
	const hashedKey = createHash('sha256').update(cookie).digest('hex');
	return fetchFromCache('session:', hashedKey);
}

export function deleteSessionFromCache(cookie: string) {
	const hashedKey = createHash('sha256').update(cookie).digest('hex');
	return deleteFromCache('session:', hashedKey);
}

// export function saveSessionToCache(cookie: string, session: KratosSession) {
// 	const hashedKey = createHash('sha256').update(cookie).digest('hex');
// 	const sessionExp = new Date(session.expires_at);
// 	const ttl = Math.round((sessionExp.getTime() - Date.now()) / 1000);

// 	return saveToCache('session:', hashedKey, JSON.stringify(session), ttl);
// }
