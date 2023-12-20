<script>
  import { stockUrl, fetchedData } from "../stores/stockStore";
  import { getData } from "../fetcher";
  import InventoryTable from "../components/inventory/InventoryTable.svelte";
  import NewInventoryForm from "../components/inventory/NewInventoryForm.svelte";
  import Modal from "../shared/Modal.svelte";
  import Overlay from "../shared/Overlay.svelte";
  import EditInventoryForm from "../components/inventory/EditInventoryForm.svelte";

  let item = {};
  let isEditFormVisible = false;
  let isCreateFormVisible = false;

  const loadEditForm = e => {
    item = e.detail;
    isEditFormVisible = true;
  }

  const loadNewForm = () => {
    isCreateFormVisible = true;
  }

  const fetchData = async () => {
    fetchedData.set(getData(stockUrl));
  }
</script>

<main>
  <h1>Inventory</h1>
	<button on:click={loadNewForm}>New</button>
  <InventoryTable on:edit={loadEditForm} on:fetch={fetchData} />
  {#if isEditFormVisible}
    <Overlay>
      <Modal on:close={() => isEditFormVisible = false}>
        <EditInventoryForm {item} on:close={() => isEditFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
  {#if isCreateFormVisible}
    <Overlay>
      <Modal on:close={() => isCreateFormVisible = false}>
        <NewInventoryForm on:close={() => isCreateFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
</main>