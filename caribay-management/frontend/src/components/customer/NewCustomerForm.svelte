<script>
	import { createEventDispatcher } from "svelte";
  import { postData } from "../../fetcher";
  import { customersUrl as url } from "../../stores/customerStore";

	let customer = {
		firstName: "",
		lastName: "",
		emailAddress: "",
		password: ""
	}

	const dispatch = createEventDispatcher();

	const createCustomer = async () => {
    const response = await postData(url, customer);

    if (response.status == 201) {
      dispatch("close");
      alert("Customer created successfully!");
      dispatch("fetch");
    }
	}

	const cancelNew = () => {
		dispatch("close");
	}
</script>

<label for="first-name">First name:</label>
<input type="text" name="first-name" bind:value={customer.firstName}>
<label for="last-name">Last name:</label>
<input type="text" name="last-name" bind:value={customer.lastName}>
<label for="email">Email address:</label>
<input type="text" name="email" bind:value={customer.emailAddress}>
<label for="password">Password:</label>
<input type="text" name="password" bind:value={customer.password}>
<button on:click={createCustomer}>Save</button>
<button on:click={cancelNew}>Cancel</button>