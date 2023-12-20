<script>
  import { createEventDispatcher } from "svelte";
  
  const dispatch = createEventDispatcher();
  const handleClick = () => {
    dispatch("close");
  }
</script>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<div class="bg-white text-black rounded-md px-8 py-10 relative max-w-lg opacity-95" on:click|stopPropagation>
  <button class="absolute top-2 right-3 text-4xl text-gray-300 hover:-translate-y-0.5 transition-transform" on:click={handleClick}>
    &times;
  </button>
  <slot />
</div>