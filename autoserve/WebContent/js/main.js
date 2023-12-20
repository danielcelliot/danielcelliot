const header = document.querySelector('header');
const links = document.querySelectorAll('nav ul li a');
const buttonQuote = document.querySelector('.button.quote');
const heroSection = document.querySelector('.hero');

const heroSectionOptions = {
    rootMargin: '-90% 0px 0px 0px'
};
const heroSectionOptionsBtn = {
    rootMargin: '-50% 0px 0px 0px'
};

const heroSectionObserver = new IntersectionObserver((entries, heroSectionObserver) => {
    entries.forEach (entry => {
        // console.log(entry.target);
        if (!entry.isIntersecting) {
            header.classList.add('header-scrolled');
            header.classList.add('fade-in-background');
            links.forEach(link => {
                link.classList.add('nav-scrolled');
            });
        } else {
            header.classList.remove('header-scrolled');
            header.classList.remove('fade-in-background');
            links.forEach(link => {
                link.classList.remove('nav-scrolled');
            });
        }
    });
}, heroSectionOptions);

heroSectionObserver.observe(heroSection);


const heroSectionObserverBtn = new IntersectionObserver((entries, heroSectionObserver) => {
    entries.forEach (entry => {
        // console.log(entry.target);
        if (!entry.isIntersecting) {
            buttonQuote.classList.add('scale-in');
        } else {
            buttonQuote.classList.remove('scale-in');
        }
    });
}, heroSectionOptionsBtn);

heroSectionObserverBtn.observe(heroSection);