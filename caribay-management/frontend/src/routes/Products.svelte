<script>
  import { productsUrl, fetchedData } from "../stores/productStore";
  import { getData } from "../fetcher";
  import EditProductForm from "../components/product/EditProductForm.svelte";
  import NewProductForm from "../components/product/NewProductForm.svelte";
  import ProductTable from "../components/product/ProductTable.svelte";
  import Modal from "../shared/Modal.svelte";
  import Overlay from "../shared/Overlay.svelte";

  let product = {};
  let isEditFormVisible = false;
  let isCreateFormVisible = false;

  const loadEditForm = (e) => {
    product = e.detail;
    isEditFormVisible = true;
  }

  const loadNewForm = () => {
    isCreateFormVisible = true;
  }

  const fetchData = async () => {
    fetchedData.set(getData(productsUrl));
  }
</script>

<main>
  <h1>Products</h1>
	<button on:click={loadNewForm}>New</button>
  <ProductTable on:edit={loadEditForm} on:fetch={fetchData} />
  {#if isEditFormVisible}
    <Overlay>
      <Modal on:close={() => isEditFormVisible = false}>
        <EditProductForm {product} on:close={() => isEditFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
  {#if isCreateFormVisible}
    <Overlay>
      <Modal on:close={() => isCreateFormVisible = false}>
        <NewProductForm on:close={() => isCreateFormVisible = false} on:fetch={fetchData} />
      </Modal>
    </Overlay>
  {/if}
</main>
