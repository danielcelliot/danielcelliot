<script>
	import { onMount, createEventDispatcher } from "svelte";
  import { getData, postData } from "../../fetcher";
  import { orderUrl } from "../../stores/orderStore";
  import { customersUrl, fetchedData as customerData } from "../../stores/customerStore";
  import { customerAddressUrl } from "../../stores/addressStore";
  import { paymentOptionsUrl, fetchedData as paymentOptionsData } from "../../stores/paymentStore";
  import { shipmentOptionsUrl, fetchedData as shipmentOptionsData } from "../../stores/shipmentStore";
	import { productsUrl, fetchedData as productsData } from "../../stores/productStore";

	const dispatch = createEventDispatcher();

  let shippingOptionsLabel = " -- select shipping address -- ";
  let billingOptionsLabel = " -- select billing address -- ";
  
  let selectedCustomer;
  let selectedShipAddress;
  let selectedBillAddress;
  let selectedPaymentProvider;
  let selectedPaymentType;
  let selectedPayOption;
  let selectedShipmentProvider;
  let selectedShipOption;
  let selectedProductId;
  let selectedQty;
  let selectedProducts = [];

  let customerAddresses = [];
  let paymentProviderDetails = [];
  let paymentTypes = [];
  let paymentOptions = [];
  let shipmentProviderDetails = [];
  let shipmentOptions = [];
  let productList = [];
  let subtotal = 0;
  let vat = 0;
  let shippingCost = 0;
  let total = 0;

  onMount(() => {
    customerData.set(getData(customersUrl));
    paymentOptionsData.set(getData(paymentOptionsUrl));
    shipmentOptionsData.set(getData(shipmentOptionsUrl));
    productsData.set(getData(productsUrl));
  });

  const addOrder = async () => {
    let products = [];
    selectedProducts.forEach(p => {
      products.push({
        "productId": p.product_id,
        "merchantId": 1,
        "quantity": p.quantity
      })
    });

    let order = {
      "customerId": selectedCustomer,
      "shippingAddressId": selectedShipAddress,
      "billingAddressId": selectedBillAddress,
      "shipmentProviderOptionsId": selectedShipOption,
      "paymentProviderOptionsId": selectedPayOption,
      "products": products
    }
    // console.log(order);

    const response = await postData(orderUrl, order);

    if (response.status == 201) {
      dispatch("close");
      alert("Order created successfully!");
      dispatch("fetch");
    }
  }

	const cancelNew = () => {
		dispatch("close");
	}

  const loadCustomerDetails = async () => {
    // formInputValues.customerId = selectedCustomer;

    if (customerAddresses.length > 0) {
      // clean up previous customer options
      customerAddresses = [];
      selectedShipAddress = "";
      selectedBillAddress = "";
    }

    let addresses = await getData(`${customerAddressUrl}/${selectedCustomer}`);

    if (!Array.isArray(addresses) || !addresses.length) {
      shippingOptionsLabel = "No address found";
      billingOptionsLabel = "No address found";
    } else {
      addresses.forEach(item => {
        customerAddresses = [...customerAddresses, item];
        document.querySelector('#shipping-address').removeAttribute('disabled');
        document.querySelector('#billing-address').removeAttribute('disabled');
      });
    }
  }

  function loadPaymentProviderDetails(providerData) {
    paymentProviderDetails = providerData;
    // console.log(providerDetails);
    return paymentProviderDetails;
  }

  function loadPaymentTypes() {
    // formInputValues.paymentProviderId = selectedPaymentProvider;

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
    
    document.querySelector('#payment-type').removeAttribute('disabled');
    // console.log(paymentTypes);
  }

  function loadPaymentTypeDetails() {
    // formInputValues.paymentTypeId = selectedPaymentType;

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

    paymentOptions = paymentType.options;
    // console.log(currencyOptions);
    document.querySelector('#currency-option').removeAttribute('disabled');
  }
  
  function loadShipmentProviderDetails(providerData) {
    shipmentProviderDetails = providerData;
    // console.log(shipmentProviderDetails);
    return shipmentProviderDetails;
  }

  function loadShipmentMethods() {
    // formInputValues.shipmentProviderId = selectedShipmentProvider;

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
    
    // console.log(paymentTypes);
    document.querySelector('#shipment-method').removeAttribute('disabled');
  }

  function loadProductList(productData) {
    productList = productData;
    return productList;
  }

  async function addProductToList() {
    let foundProduct = productList.find(product => {
      if (product.product_id == selectedProductId) {
        return product;
      }
    });
    
    let unitPrice = await getProductPricing(foundProduct.product_id);
    let product = {
      "product_id": foundProduct.product_id,
      "product_name": foundProduct.product_name,
      "quantity": selectedQty,
      "unit_price": unitPrice
    }

    selectedProducts = [...selectedProducts, product];
    
    // update cost details
    subtotal = subtotal + (unitPrice * selectedQty);
    vat = subtotal * 0.12;
    total = subtotal + vat + shippingCost;

    // cleanup
    selectedProductId = "";
    selectedQty = "";

    // console.log(selectedProducts);
  }

  function removeProductFromList(product) {
    let removedProduct = selectedProducts.find(i => {
      if (i.product_id == product.product_id) {
        return i;
      }
    })

    // update cost details
    subtotal = subtotal - (removedProduct.unit_price * removedProduct.quantity);
    vat = subtotal * 0.12;
    total = subtotal + vat + shippingCost;

    selectedProducts = selectedProducts.filter(p => p.product_id != product.product_id);
  }

  async function getProductPricing(id) {
    let price = await getData(`${productsUrl}/${id}/merchants/1`);
    // console.log(product);
    return price;
  }
</script>

<label for="customer-name">Customer Name:</label>
<select name="customer-name" id="customer-name" bind:value={selectedCustomer} on:change={loadCustomerDetails}>
  <option disabled selected value> -- select customer -- </option>
  {#await $customerData}
    <option disabled value>Loading customers...</option>
  {:then customers}
    {#if !Array.isArray(customers) || !customers.length}
      <option disabled>No customers found</option>
    {:else}
      {#each customers as customer (customer.customer_id)}
        <option value={customer.customer_id}>{customer.first_name} {customer.last_name}</option>
      {/each}
    {/if}
  {:catch}
    <option disabled>Error: Cannot retrieve customer data!</option>
  {/await}
</select>

<label for="shipping-address">Shipping Address:</label>
<select disabled name="shipping-address" id="shipping-address" bind:value={selectedShipAddress}>
  <option disabled selected value id="shipping-option-default">{shippingOptionsLabel}</option>
  {#each customerAddresses as address (address.address_id)}
    <option value={address.address_id}>{address.address_full}</option>
  {/each}
</select>

<label for="billing-address">Billing Address:</label>
<select disabled name="billing-address" id="billing-address" bind:value={selectedBillAddress}>
  <option disabled selected value id="billing-option-default">{billingOptionsLabel}</option>
  {#each customerAddresses as address (address.address_id)}
    <option value={address.address_id}>{address.address_full}</option>
  {/each}
</select>

<label for="payment-provider">Payment Provider:</label>
<select name="payment-provider" id="payment-provider" bind:value={selectedPaymentProvider} on:change={loadPaymentTypes}>
  <option disabled selected value> -- select payment provider -- </option>
  {#await $paymentOptionsData}
    <option disabled value>Loading payment providers...</option>
  {:then providers}
    {#if !Array.isArray(providers) || !providers.length}
      <option disabled>No payment providers found</option>
    {:else}
      {#each loadPaymentProviderDetails(providers) as provider (provider.payment_provider_id)}
        <option value={provider.payment_provider_id}>{provider.payment_provider_name}</option>
      {/each}
    {/if}
  {:catch}
    <option disabled>Error: Cannot retrieve payment provider data!</option>
  {/await}
</select>

<label for="payment-type">Payment Type:</label>
<select disabled name="payment-type" id="payment-type" bind:value={selectedPaymentType} on:change={loadPaymentTypeDetails}>
  <option disabled selected value> -- select a payment type -- </option>
  {#each paymentTypes as type (type.payment_method_id)}
    <option value="{type.payment_method_id}">{type.payment_method_name}</option>
  {/each}
</select>

<label for="currency-option">Currency:</label>
<select disabled name="currency-option" id="currency-option" bind:value={selectedPayOption}>
  <option disabled selected value> -- select currency -- </option>
  {#each paymentOptions as options (options.currency_id)}
    <option value={options.payment_provider_options_id}>{options.denomination}</option>
  {/each}
</select>

<label for="shipment-provider">Shipment Provider:</label>
<select name="shipment-provider" id="shipment-provider" bind:value={selectedShipmentProvider} on:change={loadShipmentMethods}>
  <option disabled selected value> -- select shipment provider -- </option>
  {#await $shipmentOptionsData}
    <option disabled value>Loading shipment providers...</option>
  {:then providers}
    {#if !Array.isArray(providers) || !providers.length}
      <option disabled>No shipment providers found</option>
    {:else}
      {#each loadShipmentProviderDetails(providers) as provider (provider.shipment_provider_id)}
        <option value={provider.shipment_provider_id}>{provider.shipment_provider_name}</option>
      {/each}
    {/if}
  {:catch}
    <option disabled>Error: Cannot retrieve shipment provider data!</option>
  {/await}
</select>

<label for="shipment-method">Shipment Method:</label>
<select disabled name="shipment-method" id="shipment-method" bind:value={selectedShipOption}>
  <option disabled selected value> -- select a shipment method -- </option>
  {#each shipmentOptions as method (method.shipment_method_id)}
    <option value="{method.shipment_provider_options_id}">{method.shipment_method_name}</option>
  {/each}
</select>

<label for="products">Products:</label>
<select name="products" id="products" bind:value={selectedProductId}>
  <option disabled selected value> -- select product -- </option>
  {#await $productsData}
    <option disabled value>Loading products...</option>
  {:then products}
    {#if !Array.isArray(products) || !products.length}
      <option disabled>No product information found</option>
    {:else}
      {#each loadProductList(products) as product (product.product_id)}
        <option value={product.product_id}>{product.product_name}</option>
      {/each}
    {/if}
  {:catch}
    <option disabled>Error: Cannot retrieve product information!</option>
  {/await}
</select>
<label for="quantity">Quantity:</label>
<input type="number" name="quantity" bind:value={selectedQty}>
<button on:click={addProductToList}>+</button>

<table>
  <thead>
    <th>Product</th>
    <th>Quantity</th>
    <th>Unit Price</th>
  </thead>
  <tbody>
    {#each selectedProducts as product}
      <tr>
        <td>{product.product_name}</td>
        <td>{product.quantity}</td>
        <td>{product.unit_price}</td>
        <button on:click={() => removeProductFromList(product)}>X</button>
      </tr>
    {/each}
  </tbody>
</table>

<h1>Subtotal: {subtotal}</h1>
<h1>VAT: {vat}</h1>
<h1>Shipping Cost: {shippingCost}</h1>
<h1>Total: {total}</h1>

<button on:click={addOrder}>Save</button>
<button on:click={cancelNew}>Cancel</button>