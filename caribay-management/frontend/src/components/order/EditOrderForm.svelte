<script>
	import { onMount, createEventDispatcher } from "svelte";
  import { getData, putData } from "../../fetcher";
  import { orderUrl } from "../../stores/orderStore";
  import { customersUrl, fetchedData as customerData } from "../../stores/customerStore";
  import { customerAddressUrl } from "../../stores/addressStore";
  import { paymentOptionsUrl, fetchedData as paymentOptionsData } from "../../stores/paymentStore";
  import { shipmentOptionsUrl, fetchedData as shipmentOptionsData } from "../../stores/shipmentStore";
	import { productsUrl, fetchedData as productsData } from "../../stores/productStore";

	const dispatch = createEventDispatcher();

  export let order = {
    orderId: "",
    customerId: "",
    customerName: "",
    shippingInfo: {},
    paymentInfo: {},
    products: {}
  }

  let selectedCustomer;
  let selectedShipAddress;
  let selectedBillAddress;
  let selectedPaymentProvider;
  let selectedPaymentType;
  let selectedPayOption;
  let selectedShipmentProvider;
  let selectedShipOption;
  // let selectedProductId;
  // let selectedQty;
  let selectedProducts = [];

  let customerAddresses = [];
  let paymentProviderDetails = [];
  let paymentTypes = [];
  let paymentOptions = [];
  let shipmentProviderDetails = [];
  let shipmentOptions = [];
  // let productList = [];
  let subtotal = 0;
  let vat = 0;
  // let shippingCost = 0;
  let total = 0;

  onMount(() => {
    // console.log(order);
    
    // Bind order details to default selections
    selectedCustomer = order.customerId;
    selectedShipAddress = order.shippingInfo.shippingAddressId;
    selectedBillAddress = order.shippingInfo.billingAddressId;
    selectedPaymentProvider = order.paymentInfo.paymentProviderId;
    selectedPaymentType = order.paymentInfo.paymentMethodId;
    selectedPayOption = order.paymentInfo.paymentProviderOptionsId;
    selectedShipmentProvider = order.shippingInfo.shippingProviderId;
    selectedShipOption = order.shippingInfo.shippingProviderOptionsId;
    selectedProducts = order.products;

    loadCustomerDetails();
    loadPaymentProviderDetails();
    loadShipmentProviderDetails();
    getProductPricing(selectedProducts);
    // loadPaymentTypes();
    // customerData.set(getData(customersUrl));
    // paymentOptionsData.set(getData(paymentOptionsUrl));
    // shipmentOptionsData.set(getData(shipmentOptionsUrl));
    // productsData.set(getData(productsUrl));
  });

  const submitUpdatedOrder = async () => {
    let products = selectedProducts.map(p => {
      return {
        "productId": p.productId,
        "merchantId": 1,
        "quantity": p.quantity
      }
    });

    let orderDto = {
      "orderId": order.orderId,
      "shippingAddressId": selectedShipAddress,
      "billingAddressId": selectedBillAddress,
      "shipmentProviderOptionsId": selectedShipOption,
      "paymentProviderOptionsId": selectedPayOption,
      "products": products
    }
    // console.log(orderDto);

    const url = `${orderUrl}/${order.orderId}`;
    const response = await putData(url, orderDto);

    if (response.status == 204) {
      dispatch("close");   // Hide form
      alert("Order updated successfully!");
      dispatch("fetch");
    }
  }

	const cancelEdit = () => {
		dispatch("close");
	}

  const loadCustomerDetails = async () => {
    let addresses = await getData(`${customerAddressUrl}/${selectedCustomer}`);
    addresses.forEach(item => {
      customerAddresses = [...customerAddresses, item];
    });
    // console.log(customerAddresses);
  }

  async function loadPaymentProviderDetails() {
    let providerData = await getData(`${paymentOptionsUrl}`);
    paymentProviderDetails = providerData;
    loadPaymentTypes();
    // console.log(paymentProviderDetails);
  }

  function loadPaymentTypes() {
    // console.log(paymentProviderDetails);
    if (paymentTypes.length > 0) {
      paymentTypes = [];
      paymentOptions = [];
      selectedPaymentType = "";
      selectedPayOption = "";
    }

    let provider = paymentProviderDetails.find(item => {
      if (item.payment_provider_id == selectedPaymentProvider) {
        return item;
      }
    });

    paymentTypes = provider.payment_methods;
    loadPaymentTypeDetails();
    // console.log(paymentTypes);
  }

  function loadPaymentTypeDetails() {
    if (paymentOptions.length > 0) {
      paymentOptions = [];
      selectedPayOption = "";
    }

    // console.log(paymentTypes);
    let paymentType = paymentTypes.find(item => {
      if (item.payment_method_id == selectedPaymentType) {
        return item;
      }
    })
    if (paymentType != undefined) {
      paymentOptions = paymentType.options;
    }
    
    // console.log(paymentType);
    // console.log(`Selected currency ID: ${selectedPayOption}`);
    // console.log(paymentOptions);
  }
  
  async function loadShipmentProviderDetails() {
    let providerData = await getData(`${shipmentOptionsUrl}`);
    shipmentProviderDetails = providerData;
    loadShipmentMethods();
    // console.log(shipmentProviderDetails);
  }

  function loadShipmentMethods() {
    if (shipmentOptions.length > 0) {
      shipmentOptions = [];
      selectedShipOption = "";
    }

    let provider = shipmentProviderDetails.find(item => {
      if (item.shipment_provider_id == selectedShipmentProvider) {
        return item;
      }
    });

    shipmentOptions = provider.shipment_methods;
    // console.log(shipmentOptions);
  }

  function removeProductFromList(product) {
    selectedProducts = selectedProducts.filter(p => p.productId != product.productId);

    // reset totals
    subtotal = 0;
    vat = 0;
    total = 0;

    // update cost details
    if (selectedProducts.length) {
      selectedProducts.forEach(product => {
        subtotal = subtotal + (product.unitPrice * product.quantity);
        vat = subtotal * 0.12;
        total = subtotal + vat;
      })
    }
  }

  async function getProductPricing(products) {
    const updatedProducts = await Promise.all(products.map(async product => {
      return {
        quantity: product.quantity,
        productId: product.productId,
        productName: product.productName,
        unitPrice: await getData(`${productsUrl}/${product.productId}/merchants/1`)
      }
    }))

    selectedProducts = updatedProducts;

    // update cost details
    selectedProducts.forEach(product => {
      subtotal = subtotal + (product.unitPrice * product.quantity);
      vat = subtotal * 0.12;
      total = subtotal + vat;
    })

    // return selectedProducts;
  }

  function updateTotals() {
    // reset totals
    subtotal = 0;
    vat = 0;
    total = 0;

    // update cost details
    selectedProducts.forEach(product => {
      if (product.quantity != "" && product.quantity > 0) {
        subtotal = subtotal + (product.unitPrice * product.quantity);
        vat = subtotal * 0.12;
        total = subtotal + vat;
      }
    })
  }
</script>

<label for="order-id">Order ID:</label>
<input type="text" name="order-id" id="order-id" bind:value={order.orderId} disabled>

<label for="customer-name">Customer Name:</label>
<input type="text" name="customer-name" id="customer-name" bind:value={order.customerName} disabled>

<label for="shipping-address">Shipping Address:</label>
<select name="shipping-address" id="shipping-address" bind:value={selectedShipAddress}>
  {#each customerAddresses as address (address.address_id)}
    <option value={address.address_id}>{address.address_full}</option>
  {/each}
</select>

<label for="billing-address">Billing Address:</label>
<select name="billing-address" id="billing-address" bind:value={selectedBillAddress}>
  {#each customerAddresses as address (address.address_id)}
    <option value={address.address_id}>{address.address_full}</option>
  {/each}
</select>

<label for="payment-provider">Payment Provider:</label>
<select name="payment-provider" id="payment-provider" bind:value={selectedPaymentProvider} on:change={loadPaymentTypes}>
  {#each paymentProviderDetails as provider (provider.payment_provider_id)}
    <option value={provider.payment_provider_id}>{provider.payment_provider_name}</option>
  {/each}
</select>

<label for="payment-type">Payment Type:</label>
<select name="payment-type" id="payment-type" bind:value={selectedPaymentType} on:change={loadPaymentTypeDetails}>
  {#each paymentTypes as type (type.payment_method_id)}
    <option value="{type.payment_method_id}">{type.payment_method_name}</option>
  {/each}
</select>

<label for="currency-option">Currency:</label>
<select name="currency-option" id="currency-option" bind:value={selectedPayOption}>
  {#each paymentOptions as options (options.currency_id)}
    <option value={options.payment_provider_options_id}>{options.denomination}</option>
  {/each}
</select>

<label for="shipment-provider">Shipment Provider:</label>
<select name="shipment-provider" id="shipment-provider" bind:value={selectedShipmentProvider} on:change={loadShipmentMethods}>
  {#each shipmentProviderDetails as provider (provider.shipment_provider_id)}
    <option value={provider.shipment_provider_id}>{provider.shipment_provider_name}</option>
  {/each}
</select>

<label for="shipment-method">Shipment Method:</label>
<select name="shipment-method" id="shipment-method" bind:value={selectedShipOption}>
  {#each shipmentOptions as method (method.shipment_method_id)}
    <option value="{method.shipment_provider_options_id}">{method.shipment_method_name}</option>
  {/each}
</select>

<table>
  <thead>
    <th>ID</th>
    <th>Name</th>
    <th>Quantity</th>
    <th>Unit Price</th>
  </thead>
  <tbody>
    <!-- {#await getProductPricing(selectedProducts) then _products} -->
      {#each selectedProducts as product, i}
        <tr>
          <td>{product.productId}</td>
          <td>{product.productName}</td>
          <td contenteditable="true" bind:textContent={selectedProducts[i].quantity} on:input={updateTotals}></td>
          <td>${product.unitPrice}</td>
          <!-- <button on:click={() => removeProductFromList(product)}>X</button> -->
        </tr>
      {/each}
    <!-- {/await} -->
  </tbody>
</table>

<h1>Subtotal: ${subtotal}</h1>
<h1>VAT: ${vat}</h1>
<!-- <h1>Shipping Cost: {shippingCost}</h1> -->
<h1>Total: ${total}</h1>

<button on:click={submitUpdatedOrder}>Save</button>
<button on:click={cancelEdit}>Cancel</button>