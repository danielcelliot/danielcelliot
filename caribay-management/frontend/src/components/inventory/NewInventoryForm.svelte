<script>
	import { onMount, createEventDispatcher } from "svelte";
  import { getData, postData } from "../../fetcher";
  import { stockUrl, brandUrl, modelUrl } from "../../stores/stockStore";
  
	let formInputValues = {
    modelId: "",
    sku: ""
	}

  let item = {}

	const dispatch = createEventDispatcher();

  const addItem = async () => {
    const response = await postData(stockUrl, formInputValues);

    if (response.status == 201) {
      dispatch("close");
      alert("Inventory item created successfully!");
      dispatch("fetch");
    }
  }

	const cancelNew = () => {
		dispatch("close");
	}
</script>

<label for="model-id">Model ID:</label>
<input type="text" name="model-id" bind:value={formInputValues.modelId}>
<label for="sku">SKU:</label>
<input type="text" name="sku" bind:value={formInputValues.sku}>
<button on:click={addItem}>Save</button>
<button on:click={cancelNew}>Cancel</button>