<script>
	import Router from "svelte-spa-router";
	import Customers from "./routes/Customers.svelte";
  import Products from "./routes/Products.svelte";
  import Developer from "./routes/Developer.svelte";
	import Home from "./routes/Home.svelte";
	import NotFound from "./routes/NotFound.svelte";
	import NavBar from "./components/NavBar.svelte";
  import Inventory from "./routes/Inventory.svelte";
  import Suppliers from "./routes/Suppliers.svelte";
    import Orders from "./routes/Orders.svelte";

	let routes = {
		"/": Home,
		"/customers": Customers,
    "/products": Products,
    "/dev": Developer,
    "/stock": Inventory,
    "/suppliers": Suppliers,
    "/orders": Orders,

		"*": NotFound
	}
</script>

<NavBar />
<Router {routes}/>
