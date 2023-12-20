<script>
	import { createEventDispatcher } from "svelte";
  import { putData } from "../../fetcher";
  import { customersUrl as url } from "../../stores/customerStore";
  
  const dispatch = createEventDispatcher();

	export let customer = {
		customer_id: -1,
		first_name: "",
		last_name: "",
		email_address: ""
	}

	const updateCustomer = async () => {
    const customerDto = {
      customerId: customer.customer_id,
      firstName: customer.first_name,
      lastName: customer.last_name,
      emailAddress: customer.email_address
    }
  
    const customerUrl = `${url}/${customer.customer_id}`;
    const response = await putData(customerUrl, customerDto);

    if (response.status == 204) {
      dispatch("close");   // Hide form
      alert("Customer updated successfully!");
      dispatch("fetch");
		}
  }

	const cancelUpdate = () => {
		dispatch("close");
	}
</script>

<label for="first-name">First name:</label>
<input type="text" name="first-name" bind:value={customer.first_name}>
<label for="last-name">Last name:</label>
<input type="text" name="last-name" bind:value={customer.last_name}>
<label for="email">Email address:</label>
<input type="text" name="email" bind:value={customer.email_address}>
<button on:click={updateCustomer}>Save</button>
<button on:click={cancelUpdate}>Cancel</button>