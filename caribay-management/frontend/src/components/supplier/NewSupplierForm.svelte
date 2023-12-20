<script>
	import { onMount, createEventDispatcher } from "svelte";
  import { getData, postData } from "../../fetcher";
  import { supplierUrl } from "../../stores/supplierStore";
  
	let formInputValues = {
    supplierName: ""
	}

  let suppiler = {}

	const dispatch = createEventDispatcher();

  const addSupplier = async () => {
    const response = await postData(supplierUrl, formInputValues);

    if (response.status == 201) {
      dispatch("close");
      alert("Supplier created successfully!");
      dispatch("fetch");
    }
  }

	const cancelNew = () => {
		dispatch("close");
	}
</script>

<label for="supplier-name">Supplier Name:</label>
<input type="text" name="supplier-name" bind:value={formInputValues.supplierName}>
<button on:click={addSupplier}>Save</button>
<button on:click={cancelNew}>Cancel</button>