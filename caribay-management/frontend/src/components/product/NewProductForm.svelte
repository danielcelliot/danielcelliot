<script>
	import { onMount, createEventDispatcher } from "svelte";
  import { getData, postData } from "../../fetcher";
  import { productsUrl, subcategoriesUrl } from "../../stores/productStore";

	let formInputValues = {
    stockId: "",
		productName: "",
		subcategoryId: "",
    attributeKey: "",
    attributeValue: "",
    optionKey: "",
    optionValue: ""
	}
  
  let product = {
    stockId: "",
    productName: "",
    subcategoryId: "",
    attributes: [],
    options: [],
  }

  let subcategories = [];
  let selectedSub;

	const dispatch = createEventDispatcher();

	const addProduct = async () => {
    product.stockId = formInputValues.stockId;
    product.productName = formInputValues.productName;
    product.subcategoryId = formInputValues.subcategoryId;

    const response = await postData(productsUrl, product);

    if (response.status == 201) {
      dispatch("close");
      alert("Product created successfully!");
      dispatch("fetch");
    }
    else {
      let json = await response.json();
      console.log(json);
    }
	}

  const addAttribute = () => {
    let attrObj = {
      [formInputValues.attributeKey]: formInputValues.attributeValue
    }
    
    product.attributes = [...product.attributes, attrObj];
    
    // Clear attribute fields
    formInputValues.attributeKey = "";
    formInputValues.attributeValue = "";
  }

  const addOption = () => {
    let optObj = {
      [formInputValues.optionKey]: formInputValues.optionValue
    }
    
    product.options = [...product.options, optObj];
    
    // Clear option fields
    formInputValues.optionKey = "";
    formInputValues.optionValue = "";
  }

  const deleteAttribute = (keys) => {
    let attr = keys[0];
    product.attributes = product.attributes.filter(attribute => Object.keys(attribute) != attr);
  }

  const deleteOption = (keys) => {
    let opt = keys[0];
    product.options = product.options.filter(option => Object.keys(option) != opt);
  }

	const cancelNew = () => {
		dispatch("close");
	}
  
  onMount(async () => {
    let data = await getData(subcategoriesUrl);

    data.forEach(i => {
      let sub = {
        subcategory_id: i.subcategory_id,
        subcategory_name: i.subcategory_name
      }
      subcategories.push(sub);
    })

    // Svelte quirk - must be reassigned to display updated info
    subcategories = [...subcategories];
  });
</script>

<label for="stock-id">Stock ID:</label>
<input type="text" name="stock-id" bind:value={formInputValues.stockId}>

<label for="product-name">Product name:</label>
<input type="text" name="product-name" bind:value={formInputValues.productName}>

<label for="subcategories">Subcategories:</label>
<select name="subcategories" id="subcategories" bind:value={selectedSub} on:change={() => formInputValues.subcategoryId = selectedSub}>
  <option disabled selected value> -- select a subcategory -- </option>
  {#each subcategories as subcategory (subcategory.subcategory_id)}
    <option value="{subcategory.subcategory_id}">{subcategory.subcategory_name}</option>
  {/each}
</select>

<table>
  <thead>
    <th>Attribute name</th>
    <th>Attribute value</th>
  </thead>
  <tbody>
    {#each product.attributes as attribute}
      <tr>
        <td>{Object.keys(attribute)}</td>
        <td>{Object.values(attribute)}</td>
        <button on:click={() => deleteAttribute(Object.keys(attribute))}>X</button>
      </tr>
    {/each}
    <tr>
      <td contenteditable="true" bind:textContent={formInputValues.attributeKey}></td>
      <td contenteditable="true" bind:textContent={formInputValues.attributeValue}></td>
      <button on:click={addAttribute}>+</button>
    </tr>
  </tbody>
</table>

<table>
  <thead>
    <th>Option name</th>
    <th>Option value</th>
  </thead>
  <tbody>
    {#each product.options as option}
      <tr>
        <td>{Object.keys(option)}</td>
        <td>{Object.values(option)}</td>
        <button on:click={() => deleteOption(Object.keys(option))}>X</button>
      </tr>
    {/each}
    <tr>
      <td contenteditable="true" bind:textContent={formInputValues.optionKey}></td>
      <td contenteditable="true" bind:textContent={formInputValues.optionValue}></td>
      <button on:click={addOption}>+</button>
    </tr>
  </tbody>
</table>

<button on:click={addProduct}>Save</button>
<button on:click={cancelNew}>Cancel</button>
