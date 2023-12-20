<script>
  import { onMount, createEventDispatcher } from "svelte";
	import { getData, deleteData } from "../../fetcher";
	import { customersUrl as url, fetchedData } from "../../stores/customerStore";
	
  const dispatch = createEventDispatcher();

	const deleteCustomer = async id => {
    const customerUrl = `${url}/${id}`;
		const response = await deleteData(customerUrl);

		if (response.status == 204) {
      alert("Customer deleted successfully!");
      dispatch("fetch");
		}
	}

	const editCustomer = customer => {
    dispatch("edit", {
      customer_id: customer.customer_id,
      first_name: customer.first_name,
      last_name: customer.last_name,
      email_address: customer.email_address
    });
	}
  
  onMount(() => {
    fetchedData.set(getData(url));
  });
</script>

{#await $fetchedData}
	<p>Loading customer data...</p>
{:then customers}
	{#if !Array.isArray(customers) || !customers.length}
		<p>No customers found</p>
	{:else}
    <table>
      <thead>
        <th>ID</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Email Address</th>
        <th>Password</th>
        <th>Active</th>
        <th>Created On</th>
        <th>Last Updated On</th>
      </thead>
      <tbody>
        {#each customers as customer (customer.customer_id)}
          <tr>
            <td>{customer.customer_id}</td>
            <td>{customer.first_name}</td>
            <td>{customer.last_name}</td>
            <td>{customer.email_address}</td>
            <td>{customer.password}</td>
            {#if customer.is_active === true}
              <td>Yes</td>
            {:else}
              <td>No</td>
            {/if}
            <td>{customer.created_on}</td>
            <td>{customer.last_updated_on}</td>
            <button on:click={() => editCustomer(customer)}>Edit</button>
					  <button on:click={() => deleteCustomer(customer.customer_id)}>Delete</button>
          </tr>
        {/each}
      </tbody>
    </table>
	{/if}
{:catch}
	<p>Error: Cannot retrieve customer data</p>
{/await}