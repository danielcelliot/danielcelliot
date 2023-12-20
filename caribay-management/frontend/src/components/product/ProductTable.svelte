<script>
  import { onMount, createEventDispatcher } from "svelte";
	import { getData, deleteData } from "../../fetcher";
	import { productsUrl as url, fetchedData } from "../../stores/productStore";

  const dispatch = createEventDispatcher();

	const deleteProduct = async id => {
    const productUrl = `${url}/${id}`;
		const response = await deleteData(productUrl);

		if (response.status == 204) {
      alert("Product deleted successfully!");
      dispatch("fetch");
		}
	}

	const editProduct = product => {
    dispatch("edit", {
      stockId: product.product_id,
      productName: product.product_name,
      attributes: product.attributes,
      options: product.options,
      subcategoryId: product.subcategory_id
    });
	}

  onMount(() => {
    fetchedData.set(getData(url));
  });
</script>

{#await $fetchedData}
	<p>Loading product data...</p>
{:then products}
	{#if !Array.isArray(products) || !products.length}
		<p>No products found</p>
	{:else}
    <table>
      <thead>
        <th>ID</th>
        <th>Product Name</th>
        <th>Attributes</th>
        <th>Options</th>
        <th>Subcategory</th>
        <th>Active</th>
        <th>Created On</th>
        <th>Last Updated On</th>
      </thead>
      <tbody>
        {#each products as product (product.product_id)}
          <tr>
            <td>{product.product_id}</td>
            <td>{product.product_name}</td>
            {#each product.attributes as attributes}
              <td>{Object.keys(attributes)}: {Object.values(attributes)} </td>
            {/each}
            {#each product.options as options}
              <td>{Object.keys(options)}: {Object.values(options)} </td>
            {/each}
            <td>{product.subcategory_id}</td>
            {#if product.is_active === true}
              <td>Yes</td>
            {:else}
              <td>No</td>
            {/if}
            <td>{product.created_on}</td>
            <td>{product.last_updated_on}</td>
            <button on:click={() => editProduct(product)}>Edit</button>
            <button on:click={() => deleteProduct(product.product_id)}>Delete</button>
          </tr>
        {/each}
      </tbody>
    </table>
	{/if}
{:catch}
	<p>Error: Cannot retrieve product data</p>
{/await}
