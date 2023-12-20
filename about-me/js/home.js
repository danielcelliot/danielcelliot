/*----------------------------------------------   
--Constants
-----------------------------------------------  */

const overlay = document.querySelector('.grid-overlay');
const grid = document.querySelector('.grid');
const splashItems = grid.querySelectorAll('.splash');
const initialsItem = grid.querySelector('.initials');


/*----------------------------------------------   
--Functions
-----------------------------------------------  */

function animateInitials() {
    // Get all svg paths for animation
    let Dpath_A = document.getElementById('D-path_A');
    let Dpath_B = document.getElementById('D-path_B');
    let Epath_A = document.getElementById('E-path_A');
    let Epath_B = document.getElementById('E-path_B');
    let Epath_C = document.getElementById('E-path_C');
    
    // Animate letter "D"
    setTimeout(() => {
        Dpath_A.classList.toggle('hidden');
        Dpath_A.classList.toggle('animate-stroke');
    }, 400);
    setTimeout(function() {
        Dpath_B.classList.toggle('hidden');
        Dpath_B.classList.toggle('animate-stroke');
    }, 600);
    
    // Animate letter "E"
    setTimeout(function() {
        Epath_C.classList.toggle('hidden');
        Epath_C.classList.toggle('animate-stroke');
    }, 1200);
    setTimeout(function() {
        Epath_B.classList.toggle('hidden');
        Epath_B.classList.toggle('animate-stroke');
    }, 1400);
    setTimeout(function() {
        Epath_A.classList.toggle('hidden');
        Epath_A.classList.toggle('animate-stroke');
    }, 1600);

    // CLEANUP: remove event listener
    window.removeEventListener('load', animateInitials, false);
}

var moveGridToItem = (event) => {
    let element = event.target;
    let parentElement = element.parentElement;
    let itemName = parentElement.classList[1];
    
    // CLEANUP: remove event listener
    element.removeEventListener('click', moveGridToItem);

    // Change mouse cursor to default pointer
    element.style.cursor = 'default';

    // Move the grid to the specific grid item.
    grid.classList.toggle('move-grid--' + itemName);

    // Fade-out initials
    initialsItem.classList.toggle('invisible');

    // Fade-out headings
    for (let i = 0; i < overlay.children.length; i++) {
        overlay.children[i].classList.toggle('fade-out--fast');
    }

    // Fade-out splash after grid animation has completed.
    window.addEventListener('animationend', function fadeOutSplash(event) {
        if (event.animationName == ('to-' + itemName)) {
            parentElement.classList.toggle('fade-out');
        }
    });

    // Redirect to page after fade-out animation
    window.addEventListener('animationend', function redirectPage(event) {
        window.setTimeout(function () {
            location.href = itemName + '.html';
        }, 1000);
        
    });

    // Change page title
    document.title = itemName.charAt(0).toUpperCase() + itemName.slice(1) + ' - D. Elliot';
}


/*----------------------------------------------   
--Event Listeners
-----------------------------------------------  */

window.addEventListener('load', animateInitials, false);

splashItems.forEach((item) => {
    item.addEventListener('click', moveGridToItem);
});