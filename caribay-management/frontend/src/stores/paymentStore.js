import { writable } from "svelte/store";

export const paymentOptionsUrl = "http://localhost:8080/payments/options";
export const fetchedData = writable([]);