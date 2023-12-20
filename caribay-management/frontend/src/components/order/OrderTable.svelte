<script>
  import { onMount, createEventDispatcher } from "svelte";
	import { getData, deleteData } from "../../fetcher";
  import { orderUrl, fetchedData } from "../../stores/orderStore";
  import Modal from "../../shared/Modal.svelte";
  import Overlay from "../../shared/Overlay.svelte";

  const dispatch = createEventDispatcher();

  let isProductsViewOpen = false;
  let orderProducts = {};

  const editOrder = order => {
    dispatch("edit", {
      orderId: order.orderId,
      customerId: order.customerId,
      customerName: order.customerName,
      shippingInfo: order.shippingInfo,
      paymentInfo: order.paymentInfo,
      products: order.products
    });
  }

	const deleteSupplier = async id => {
    const url = `${orderUrl}/${id}`;
		const response = await deleteData(url);

		if (response.status == 204) {
      alert("Order deleted successfully!");
      dispatch("fetch");
		}
	}

  const viewProducts = (products) => {
    orderProducts = products;
    isProductsViewOpen = true;
  };
  
  onMount(() => {
    fetchedData.set(getData(orderUrl));
  });
</script>

{#await $fetchedData}
  <p>Loading order information...</p>
{:then orders} 
  {#if !Array.isArray(orders) || !orders.length}
    <p>No order information found</p>
  {:else}
    <table>
      <thead>
        <th>Order ID</th>
        <th>Customer Name</th>
        <th>Products</th>
        <th>Shipping Address</th>
        <th>Billing Address</th>
        <th>Shipping Provider</th>
        <th>Shipping Method</th>
        <th>Payment Provider</th>
        <th>Payment Type</th>
        <th>Order Status</th>
        <th>Created On</th>
        <th>Last Updated On</th>
      </thead>
      <tbody>
        {#each orders as order (order.orderId)}
          <tr>
            <td>{order.orderId}</td>
            <td>{order.customerName}</td>
            <td><button on:click={viewProducts(order.products)}>View Products</button></td>
            <td>{order.shippingInfo.shippingAddressFull}</td>
            <td>{order.shippingInfo.billingAddressFull}</td>
            <td>{order.shippingInfo.shippingProviderName}</td>
            <td>{order.shippingInfo.shippingMethodName}</td>
            <td>{order.paymentInfo.paymentProviderName}</td>
            <td>{order.paymentInfo.paymentMethodName}</td>
            <td>{order.statusCodeName}</td>
            <td>{order.created}</td>
            <td>{order.lastModified}</td>
            <button on:click={() => editOrder(order)}>Edit</button>
            <button on:click={() => deleteSupplier(order.orderId)}>Delete</button>
          </tr>
        {/each}
      </tbody>
    </table>
    {#if isProductsViewOpen}
      <Overlay>
        <Modal on:close={() => isProductsViewOpen = false}>
          <table>
            <thead>
              <th>Product ID</th>
              <th>Product Name</th>
              <th>Quantity</th>
            </thead>
            <tbody>
              {#each orderProducts as product}
                <tr>
                  <td>{product['productId']}</td>
                  <td>{product['productName']}</td>
                  <td>{product['quantity']}</td>
                </tr>
              {/each}
            </tbody>
          </table>
        </Modal>
      </Overlay>
    {/if}
  {/if}
{:catch}
  <p>Error: Cannot retrieve order information</p>
{/await}