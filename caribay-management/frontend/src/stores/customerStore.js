import { writable } from "svelte/store";

export const customersUrl = "http://localhost:8080/customers";
export const fetchedData = writable([]);