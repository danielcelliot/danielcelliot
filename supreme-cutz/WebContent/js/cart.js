// -----------------------------
// |       Constants           |
// -----------------------------

const plusBtns = document.querySelectorAll('.plus-btn');
const minusBtns = document.querySelectorAll('.minus-btn');
const closeBtns = document.querySelectorAll('.close-btn');
const checkoutBtn = document.querySelector('.checkout-btn');

const emptyCartElement = document.querySelector('.empty-cart');
const subtotalValueElement = document.querySelector('span#subtotal-value');
const shippingValueElement = document.querySelector('span#shipping-value');
const totalValueElement = document.querySelector('span#total-value');

const costPerLb = 40;


// -----------------------------
// |       Functions           |
// -----------------------------

function updateCartTotal() {
    var subtotalElements = document.querySelectorAll('.subtotal-value');
    var inputElements = document.querySelectorAll('.qty-value');

    var grandTotal = 0;
    var subtotals = 0;
    var shippingCost = 0;

    subtotalElements.forEach((element) => {
        subtotals += parseFloat(element.innerHTML);
    });

    inputElements.forEach((element) => {
        var weight = parseFloat(element.dataset.weight);
        // DEBUG
        console.log("Item weight: " + weight);
        var qty = parseInt(element.value);

        shippingCost += (costPerLb * (weight * qty));

        // DEBUG
        console.log("Shipping cost: " + shippingCost);
    });

    if (subtotals === 0) {
        // Display 'Your cart is empty' message.
        emptyCartElement.classList.remove('empty');
        checkoutBtn.remove();
    }
    
    // Display new totals
    shippingValueElement.innerHTML = shippingCost.toFixed(2);
    subtotalValueElement.innerHTML = subtotals.toFixed(2);
    totalValueElement.innerHTML = (subtotals + shippingCost).toFixed(2);
}

function removeFromCart(product) {
    var http = new XMLHttpRequest();
    http.open("POST", "../scriptlets/removeFromCart.jsp", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    var params = "param1=" + product;
    http.send(params);
}

function addItemsToOrder() {
    // Get all items in cart
    var cartItems = document.querySelectorAll('.id');

    cartItems.forEach((item) => {
        // Get product id
        var productId = item.classList[2];
        // Get quantity
        var quantity = item.value;

        // DEBUG
        console.log("ProductId: " + productId + " -- " + "Qty: " + quantity);

        var params = "id=" + productId + "&" + "qty=" + quantity;

        // Add to user session
        var http = new XMLHttpRequest();
        http.open("POST", "../scriptlets/addToOrder.jsp", true);
        http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
        http.onreadystatechange = function() {
            if (http.readyState == 4 && http.status == 200) {
                // DEBUG
                console.log(http.responseText.trim());
            }
        }
        http.send(params);
    });

    window.location.href = '../scriptlets/verifySession.jsp?param1=../pages/checkout.jsp&checkout=ready';
}

// -----------------------------
// |       Event Listeners     |
// -----------------------------

checkoutBtn.addEventListener('click', (e) => {
    e.preventDefault();

    addItemsToOrder();
});

closeBtns.forEach((btn) => {
    btn.addEventListener('click', () => {
        // Remove item to cart (user session)
        removeFromCart(btn.id);

        btn.parentElement.parentElement.remove();
        updateCartTotal();
    });
})

plusBtns.forEach((btn) => {
    btn.addEventListener('click', (e) => {
        e.preventDefault();

        // Get quantity amount element
        var inputElement = btn.closest('div').querySelector('input');
        // Get quantity amount
        var inputValue = parseInt(inputElement.value);

        // Get stock amount
        var stockAmt = inputElement.dataset.stockAmt;

        if (inputValue < 10 && inputValue < stockAmt) {
            inputValue += 1;

            // Increase the quanity amount
            inputElement.value = inputValue;
        }

        // Get unit price
        var unitPrice = parseFloat(btn.closest('div').nextElementSibling.querySelector('.unit-price').innerHTML);
        // Get subtotal element
        var subtotalElement = btn.closest('div').nextElementSibling.nextElementSibling.querySelector('.subtotal-value');
        
        // Increase item subtotal value
        subtotalElement.innerHTML = (unitPrice *  inputValue).toFixed(2);

        updateCartTotal();
    })
})

minusBtns.forEach((btn) => {
    btn.addEventListener('click', (e) => {
        e.preventDefault();

        // Get quantity amount element
        var inputElement = btn.closest('div').querySelector('input');
        // Get quantity amount
        var inputValue = parseInt(inputElement.value);

        if (inputValue > 1) {
            inputValue -= 1;

            // Increase the quanity amount
            inputElement.value = inputValue;
        }

        // Get unit price
        var unitPrice = parseFloat(btn.closest('div').nextElementSibling.querySelector('.unit-price').innerHTML);
        // Get subtotal element
        var subtotalElement = btn.closest('div').nextElementSibling.nextElementSibling.querySelector('.subtotal-value');
        
        // Increase item subtotal value
        subtotalElement.innerHTML = (unitPrice *  inputValue).toFixed(2);

        updateCartTotal();
    })
})


// Display cart total on page load
window.onload = updateCartTotal();