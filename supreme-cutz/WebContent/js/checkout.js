// -----------------------------
// |       Constants           |
// -----------------------------

const checkoutContainer = document.querySelector('.checkout-container');
const spinnerContainer = document.querySelector('.spinner-container');
const pageBullet = document.querySelector('.checkout-header');

// -- Shipping form --
const address = document.querySelector('#address');
const city = document.querySelector('#city');
const phone = document.querySelector('#phone');
const delivery = document.querySelector('#delivery');
const addressBtn = document.querySelector('#address-btn');

// -- Payment form --
const cardName = document.querySelector('#card-name');
const cardNo = document.querySelector('#card-no');
const cvc = document.querySelector('#cvc');
const ccBtn = document.querySelector('#cc-btn');

// -- Confrimation form --
const confirmBtn = document.querySelector('#confirm-btn');
const reviewBtn = document.querySelector('#review-btn');

// -- Order success form --
const redirectBtn = document.querySelector('.redirect-btn');


// -----------------------------
// |       Functions           |
// -----------------------------

function changePageBullet() {
    for (let i = 0; i < pageBullet.children.length; i++) {
        if (pageBullet.children[i].classList.contains('is-active')) {
            pageBullet.children[i].classList.remove('is-active');
            
            if (pageBullet.children[i].nextElementSibling) {
                pageBullet.children[i].nextElementSibling.classList.add('is-active');

                return;
            }
        }    
    }
}

function changePage() {
    for (let i = 0; i < checkoutContainer.children.length; i++) {
        // Find the element that is currently displayed
        if (checkoutContainer.children[i].classList.contains('is-showing')) {
            // Check if active element has a sibling element
            if (checkoutContainer.children[i].nextElementSibling) {
                // Display next sibling element
                fadePageOut(checkoutContainer.children[i]);

                // Wait for fadeOut animation to complete
                setTimeout(() => {
                    startLoadingAnimation(1600);

                    // Wait for loading animation to complete
                    setTimeout(() => {
                        // Next page bullet
                        changePageBullet();
                        // Display next page
                        fadePageIn(checkoutContainer.children[i].nextElementSibling);
                    }, 2000);
                }, 600);

                return;
            }
        }
    }
}

function resartForms() {
    for (let i = 0; i < checkoutContainer.children.length; i++) {
        // Find the element that is currently displayed
        if (checkoutContainer.children[i].classList.contains('is-showing')) {
            // Fdae out active element
            fadePageOut(checkoutContainer.children[i]);

            // Wait for fadeOut animation to complete
            setTimeout(() => {
                startLoadingAnimation(1600);

                // Wait for loading animation to complete
                setTimeout(() => {
                    // Display first page
                    fadePageIn(checkoutContainer.children[3]);

                    // Next page bullet
                    for (let i = 0; i < pageBullet.children.length; i++) {
                        if (pageBullet.children[i].classList.contains('is-active')) {
                            pageBullet.children[i].classList.remove('is-active');
                            pageBullet.children[0].classList.add('is-active');
                            
                            return;
                        }    
                    }
                }, 2000);
            }, 600);

            return;
        }
    }
}

function startLoadingAnimation(timeout) {
    setTimeout(() => {
        spinnerContainer.classList.toggle('is-showing');
        setTimeout(() => {
            spinnerContainer.classList.toggle('is-showing');
        }, timeout);
    }, 400);
}

function fadePageOut(element) {
    if (element.classList.contains('fade-in')) {
        element.classList.remove('fade-in');
    }
    
    element.classList.add('fade-out');

    setTimeout(() => {
        element.classList.remove('is-showing');
    }, 600);
}

function fadePageIn(element) {
    element.classList.add('is-showing');
    element.classList.add('fade-in');
}


// -----------------------------
// |       Event Listeners     |
// -----------------------------

reviewBtn.addEventListener('click', (e) => {
    e.preventDefault();

    // Go back to first form
    resartForms();
});

addressBtn.addEventListener('click', (e) => {
    if (address.value != "" && city.value != "" && phone.value.length == 7) {
        e.preventDefault();
        // Add shipping address to review form
        document.querySelector('#shipping-confirm').innerHTML = address.value + ', ' + city.value;
        // Add delivery details to review form
        document.querySelector('#delivery-confirm').innerHTML = delivery.value;
        changePage();
    }
});

ccBtn.addEventListener('click', (e) => {
    if (cardName.value != "" && cardNo.value.length == 16 && cvc.value.length == 3) {
        e.preventDefault();
        // Add credit card number to review form
        document.querySelector('#ccard-confirm').innerHTML = cardNo.value.slice(-4);
        changePage();
    }
});

confirmBtn.addEventListener('click', (e) => {
    e.preventDefault();

    var address = document.querySelector('#address');
    var city = document.querySelector('#city');
    var phone = document.querySelector('#phone');
    var delivery = document.querySelector('#delivery');
    var cardNo = document.querySelector('#card-no');
    var orderTotal = document.querySelector('#order-total');

    var http = new XMLHttpRequest();
    http.open("POST", "../scriptlets/submitOrder.jsp", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    
    var orderInfo = "address=" + address.value + "&city=" + city.value + "&contact_no=" + phone.value + "&delivery_info=" + delivery.value + "&card_no="  + cardNo.value + "&total=" + orderTotal.innerHTML;
    
    http.send(orderInfo);
    http.onload = function() {
        if (http.responseText.trim() == "success") {
            console.log('Response: ' + http.responseText.trim());
            changePage();
        }
    }
});