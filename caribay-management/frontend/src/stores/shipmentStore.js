import { writable } from "svelte/store";

export const shipmentOptionsUrl = "http://localhost:8080/shipments/options";
export const fetchedData = writable([]);