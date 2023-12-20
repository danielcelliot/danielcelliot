<script>
  import { customersUrl as url, fetchedData } from "../stores/customerStore";
  import { getData } from "../fetcher";
	import CustomerTable from "../components/customer/CustomerTable.svelte";
	import EditCustomerForm from "../components/customer/EditCustomerForm.svelte";
  import NewCustomerForm from "../components/customer/NewCustomerForm.svelte";
  import Modal from "../shared/Modal.svelte";
  import Overlay from "../shared/Overlay.svelte";

  let customer = {};
  let isEditFormVisible = false;
  let isCreateFormVisible = false;

  const loadEditData = (e) => {
    customer = e.detail;
    isEditFormVisible = true;
  }

  const fetchData = async () => {
    fetchedData.set(getData(url));
  }
</script>

<main>
  <h1>Customers</h1>
	<button on:click={() => isCreateFormVisible = true}>+ New</button>
	<CustomerTable on:edit={loadEditData} on:fetch={fetchData} />
  {#if isEditFormVisible}
    <Overlay>
      <Modal on:close={() => isEditFormVisible = false}>
        <EditCustomerForm {customer} on:close={() => isEditFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
  {#if isCreateFormVisible}
    <Overlay>
      <Modal on:close={() => isCreateFormVisible = false}>
        <NewCustomerForm on:close={() => isCreateFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
</main>
