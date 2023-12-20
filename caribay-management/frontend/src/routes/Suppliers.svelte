<script>
  import { supplierUrl, fetchedData } from "../stores/supplierStore";
  import { getData } from "../fetcher";
  import Modal from "../shared/Modal.svelte";
  import Overlay from "../shared/Overlay.svelte";
  import SupplierTable from "../components/supplier/SupplierTable.svelte";
  import EditSupplierForm from "../components/supplier/EditSupplierForm.svelte";
  import NewSupplierForm from "../components/supplier/NewSupplierForm.svelte";

  let supplier = {};
  let isEditFormVisible = false;
  let isCreateFormVisible = false;

  const loadEditForm = e => {
    supplier = e.detail;
    isEditFormVisible = true;
  }

  const loadNewForm = () => {
    isCreateFormVisible = true;
  }

  const fetchData = async () => {
    fetchedData.set(getData(supplierUrl));
  }
</script>

<main>
  <h1>Suppliers</h1>
	<button on:click={loadNewForm}>New</button>
  <SupplierTable on:edit={loadEditForm} on:fetch={fetchData} />
  {#if isEditFormVisible}
    <Overlay>
      <Modal on:close={() => isEditFormVisible = false}>
        <EditSupplierForm {supplier} on:close={() => isEditFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
  {#if isCreateFormVisible}
    <Overlay>
      <Modal on:close={() => isCreateFormVisible = false}>
        <NewSupplierForm on:close={() => isCreateFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
</main>