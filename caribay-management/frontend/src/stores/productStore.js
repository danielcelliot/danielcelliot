import { writable } from "svelte/store";

export const productsUrl = "http://localhost:8080/products";
export const catalogUrl = "http://localhost:8080/catalog";
export const categoriesUrl = "http://localhost:8080/products/categories";
export const subcategoriesUrl = "http://localhost:8080/products/subcategories";
export const fetchedData = writable([]);
