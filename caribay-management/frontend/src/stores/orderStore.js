import { writable } from "svelte/store";

export const orderUrl = "http://localhost:8080/orders";
export const fetchedData = writable([]);
