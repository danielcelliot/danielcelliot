<script>
	import { createEventDispatcher } from "svelte";
  import { putData } from "../../fetcher";
  import { supplierUrl } from "../../stores/supplierStore";
  
  const dispatch = createEventDispatcher();

	export let supplier = {
		supplier_id: "",
		supplier_name: ""
	}

	const updateSupplier = async () => {
    const supplierDto = {
      supplierId: supplier.supplier_id,
      supplierName: supplier.supplier_name
    }
  
    const url = `${supplierUrl}/${supplier.supplier_id}`;
    const response = await putData(url, supplierDto);

    if (response.status == 204) {
      dispatch("close");   // Hide form
      alert("Supplier updated successfully!");
      dispatch("fetch");
		}
  }

	const cancelUpdate = () => {
		dispatch("close");
	}
</script>

<label for="supplier-name">Supplier Name:</label>
<input type="text" name="supplier-name" bind:value={supplier.supplier_name}>
<button on:click={updateSupplier}>Save</button>
<button on:click={cancelUpdate}>Cancel</button>