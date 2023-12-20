<script>
  import { orderUrl, fetchedData } from "../stores/orderStore";
  import { getData } from "../fetcher";
  import Modal from "../shared/Modal.svelte";
  import Overlay from "../shared/Overlay.svelte";
  import OrderTable from "../components/order/OrderTable.svelte";
  import EditOrderForm from "../components/order/EditOrderForm.svelte";
  import NewOrderForm from "../components/order/NewOrderForm.svelte";

  let order = {};
  let isEditFormVisible = false;
  let isCreateFormVisible = false;

  const loadEditForm = e => {
    order = e.detail;
    isEditFormVisible = true;
  }

  const loadNewForm = () => {
    isCreateFormVisible = true;
  }

  const fetchData = async () => {
    fetchedData.set(getData(orderUrl));
  }
</script>

<main>
  <h1>Orders</h1>
	<button on:click={loadNewForm}>New</button>
  <OrderTable on:edit={loadEditForm} on:fetch={fetchData} />
  {#if isEditFormVisible}
    <Overlay>
      <Modal on:close={() => isEditFormVisible = false}>
        <EditOrderForm {order} on:close={() => isEditFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
  {#if isCreateFormVisible}
    <Overlay>
      <Modal on:close={() => isCreateFormVisible = false}>
        <NewOrderForm on:close={() => isCreateFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
</main>