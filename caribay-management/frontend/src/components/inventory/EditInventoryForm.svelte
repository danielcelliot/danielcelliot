<script>
	import { createEventDispatcher } from "svelte";
  import { putData } from "../../fetcher";
  import { stockUrl } from "../../stores/stockStore";
  
  const dispatch = createEventDispatcher();

	export let item = {
		stock_id: "",
		model_id: "",
		sku: ""
	}

	const updateItem = async () => {
    const itemDto = {
      stockId: item.stock_id,
      modelId: item.model_id,
      sku: item.sku
    }
  
    const url = `${stockUrl}/${item.stock_id}`;
    const response = await putData(url, itemDto);

    if (response.status == 204) {
      dispatch("close");   // Hide form
      alert("Inventory item updated successfully!");
      dispatch("fetch");
		}
  }

	const cancelUpdate = () => {
		dispatch("close");
	}
</script>

<label for="model-id">Model ID:</label>
<input type="text" name="model-id" bind:value={item.model_id}>
<label for="sku">SKU:</label>
<input type="text" name="sku" bind:value={item.sku}>
<button on:click={updateItem}>Save</button>
<button on:click={cancelUpdate}>Cancel</button>