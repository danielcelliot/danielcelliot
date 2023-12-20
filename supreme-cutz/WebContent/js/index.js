// const pageLinks = document.querySelectorAll('.page-link');
// const productsLink = document.querySelector('.products');
// const bgImg = document.getElementById('img1');

// pageLinks.forEach((link) => {
//     link.addEventListener('mouseover', () => {
//         if (!link.classList.contains('active')) {
//             // Find active link
//             for (let i = 0; i < pageLinks.length; i++) {
//                 if (pageLinks[i].classList.contains('active')) {
//                     // Remove active status
//                     pageLinks[i].classList.remove('active');
//                 }
//             }

//             //  Set link to active
//             link.classList.add('active');
//             bgImg.style.opacity = '0.0';

//             setTimeout(() => {
//                 if (link.classList.contains('about')) {
//                     bgImg.src = './img/bg/products.jpg';
//                 } else if (link.classList.contains('barbers')) {
//                     bgImg.src = './img/bg/products.jpg';
//                 } else if (link.classList.contains('location')) {
//                     bgImg.src = './img/bg/location-bnw.png';
//                 } else if (link.classList.contains('gallery')) {
//                     bgImg.src = './img/bg/gallery-bnw.png';
//                 } else if (link.classList.contains('prices')) {
//                     bgImg.src = './img/bg/price-list-bnw.jpg';
//                 } else if (link.classList.contains('products')) {
//                     bgImg.src = './img/bg/products.jpg';
//                 }

//                 setTimeout(() => {
//                     bgImg.style.opacity = '1.0';
//                 }, 100);
//             }, 300);
//         }
//     });
// });

// Load first image on home page
// bgImg.src = './img/bg/barbering-bnw.png';


// Open and close sidebar navigation
function show() {
    document.querySelector('.sidebar-nav').classList.toggle('active');
}

// Variables
const menuBtn = document.querySelector('.menu-btn');
let menuOpen = false;

// Animate menu button when clicked
menuBtn.addEventListener('click', () => {
    if(!menuOpen) {
        menuBtn.classList.add('open');
        menuOpen = true;
    } else {
        menuBtn.classList.remove('open');
        menuOpen = false;
    }
});