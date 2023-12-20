/*----------------------------------------------   
--Constants
-----------------------------------------------  */

const main = document.querySelector('.page-main');
const heading = document.querySelector('.heading');
const textContent = document.querySelector('.text-content');

/*----------------------------------------------   
--Functions
-----------------------------------------------  */

function smoothScroll(target, duration) {
    var target = document.querySelector(target);
    var targetPosition = target.getBoundingClientRect().top;
    var startPosition = window.pageYOffset;
    var distance = targetPosition - startPosition;
    var startTime = null;

    function animation(currentTime) {
        if (startTime === null) {
            startTime = currentTime;
        }
        var timeElapsed = currentTime - startTime;
        
        var run = easeInQuad(timeElapsed, startPosition, distance, duration);
        
        window.scrollTo(0, run);
        
        if (timeElapsed < duration) {
        requestAnimationFrame(animation);
        }
        
        function easeInQuad(t, b, c, d) {
            t /= d;
            return c*t*t + b;
        }
        
        requestAnimationFrame(animation);
    }
}


/*----------------------------------------------   
--Event Listeners
-----------------------------------------------  */

window.addEventListener("load", () => {
    document.querySelector(".page-container").classList.add("loaded");
});

// Fade-in main page content after bar animation has completed.
window.addEventListener('animationstart', function fadeInContent(event) {
    if (event.animationName == ('scale-in')) {
        main.classList.add('load-in-content');
    }
});

// Slide in text after fade-in animation has started.
window.addEventListener('animationstart', function translateText(event) {
    if (event.animationName == ('fade-in--short')) {
        heading.classList.add('move-heading--down');
        textContent.classList.add('move-paragraph--up');
    }
});