<script>
  import { onMount, createEventDispatcher } from "svelte";
	import { getData, deleteData } from "../../fetcher";
	import { stockUrl, fetchedData } from "../../stores/stockStore";

  const dispatch = createEventDispatcher();

  const editItem = item => {
    dispatch("edit", {
      stock_id: item.stock_id,
      model_id: item.model_id,
      sku: item.sku
    });
  }

	const deleteItem = async id => {
    const url = `${stockUrl}/${id}`;
		const response = await deleteData(url);

		if (response.status == 204) {
      alert("Inventory item deleted successfully!");
      dispatch("fetch");
		}
	}
  
  onMount(() => {
    fetchedData.set(getData(stockUrl));
  });
</script>

{#await $fetchedData}
  <p>Loading inventory data...</p>
{:then inventory} 
  {#if !Array.isArray(inventory) || !inventory.length}
    <p>No inventory data found</p>
  {:else}
    <table>
      <thead>
        <th>Stock ID</th>
        <th>Model ID</th>
        <th>SKU</th>
        <th>Active</th>
        <th>Created On</th>
        <th>Last Updated On</th>
      </thead>
      <tbody>
        {#each inventory as item (item.stock_id)}
          <tr>
            <td>{item.stock_id}</td>
            <td>{item.model_id}</td>
            <td>{item.sku}</td>
            {#if item.is_active === true}
              <td>Yes</td>
            {:else}
              <td>No</td>
            {/if}
            <td>{item.created_on}</td>
            <td>{item.last_updated_on}</td>
            <button on:click={() => editItem(item)}>Edit</button>
            <button on:click={() => deleteItem(item.stock_id)}>Delete</button>
          </tr>
        {/each}
      </tbody>
    </table>
  {/if}
{:catch}
    <p>Error: Cannot retrieve inventory data</p>
{/await}