import { writable } from "svelte/store";

export const stockUrl = "http://localhost:8080/stock";
export const brandUrl = "http://localhost:8080/stock/brand";
export const modelUrl = "http://localhost:8080/stock/model";
export const fetchedData = writable([]);
