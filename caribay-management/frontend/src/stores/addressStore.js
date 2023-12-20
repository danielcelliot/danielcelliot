import { writable } from "svelte/store";

export const customerAddressUrl = "http://localhost:8080/addresses/customers";
export const fetchedData = writable([]);