const productCards = document.querySelectorAll('.product-card');
const cartIconEmpty = document.querySelector('.fa-shopping-cart');
const cartIconAdd = document.querySelector('.fa-cart-plus');

productCards.forEach((card) => {
    card.addEventListener('mouseover', () => {
        card.classList.add('animate');
    });
    
    card.addEventListener('mouseout', () => {
        card.classList.remove('animate');
    });
});

document.querySelectorAll('.add-to-cart').forEach(button => {
    button.addEventListener('click', e => {
        button.classList.toggle('added');
        button.classList.remove('mouse-over');
        button.disabled = true;

        // Add item to cart (user session)
        addToCart(button.id);

        // Change cart icon status
        if (cartIconEmpty.classList.contains('is-showing')) {
            cartIconEmpty.classList.remove('is-showing');
            cartIconAdd.classList.add('is-showing');
        }
    });
});

function addToCart(product) {
    var http = new XMLHttpRequest();
    http.open("POST", "../scriptlets/addToCart.jsp", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    var params = "id=" + product;
    http.send(params);
}