<script>
  import { onMount, createEventDispatcher } from "svelte";
  import { getData, putData } from "../../fetcher";
  import { productsUrl, subcategoriesUrl } from "../../stores/productStore";

  const dispatch = createEventDispatcher();

	let formInputValues = {
    attributeKey: "",
    attributeValue: "",
    optionKey: "",
    optionValue: ""
	}

  export let product = {
    stockId: "",
    productName: "",
    subcategoryId: "",
    attributes: [],
    options: [],
  }

  let subcategories = [];
  let selectedSub = product.subcategoryId;

	const updateProduct = async () => {
    const productDto = {
      productId: product.stockId,
      productName: product.productName,
      attributes: product.attributes,
      options: product.options,
      subcategoryId: product.subcategoryId
    }
  
    const putUrl = `${productsUrl}/${productDto.productId}`;
    const response = await putData(putUrl, productDto);

    if (response.status == 204) {
      dispatch("close");
      alert("Product updated successfully!");
      dispatch("fetch");
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

	const cancelUpdate = () => {
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

<label for="product-name">Product name:</label>
<input type="text" name="product-name" bind:value={product.productName}>

<label for="subcategories">Subcategories:</label>
<select name="subcategories" id="subcategories" bind:value={selectedSub} on:change={() => product.subcategoryId = selectedSub}>
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

<button on:click={updateProduct}>Save</button>
<button on:click={cancelUpdate}>Cancel</button>
