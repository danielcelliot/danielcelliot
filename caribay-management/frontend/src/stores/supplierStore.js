import { writable } from "svelte/store";

export const supplierUrl = "http://localhost:8080/suppliers";
export const fetchedData = writable([]);
