<script>
  import { onMount, createEventDispatcher } from "svelte";
	import { getData, deleteData } from "../../fetcher";
	import { supplierUrl, fetchedData } from "../../stores/supplierStore";

  const dispatch = createEventDispatcher();

  const editSupplier = suppiler => {
    dispatch("edit", {
      supplier_id: suppiler.supplier_id,
      supplier_name: suppiler.supplier_name
    });
  }

	const deleteSupplier = async id => {
    const url = `${supplierUrl}/${id}`;
		const response = await deleteData(url);

		if (response.status == 204) {
      alert("Supplier deleted successfully!");
      dispatch("fetch");
		}
	}
  
  onMount(() => {
    fetchedData.set(getData(supplierUrl));
  });
</script>

{#await $fetchedData}
  <p>Loading supplier data...</p>
{:then suppliers} 
  {#if !Array.isArray(suppliers) || !suppliers.length}
    <p>No supplier information found</p>
  {:else}
    <table>
      <thead>
        <th>Supplier ID</th>
        <th>Supplier Name</th>
        <th>Active</th>
        <th>Created On</th>
        <th>Last Updated On</th>
      </thead>
      <tbody>
        {#each suppliers as supplier (supplier.supplier_id)}
          <tr>
            <td>{supplier.supplier_id}</td>
            <td>{supplier.supplier_name}</td>
            {#if supplier.is_active === true}
              <td>Yes</td>
            {:else}
              <td>No</td>
            {/if}
            <td>{supplier.created_on}</td>
            <td>{supplier.last_updated_on}</td>
            <button on:click={() => editSupplier(supplier)}>Edit</button>
            <button on:click={() => deleteSupplier(supplier.supplier_id)}>Delete</button>
          </tr>
        {/each}
      </tbody>
    </table>
  {/if}
{:catch}
    <p>Error: Cannot retrieve supplier information</p>
{/await}