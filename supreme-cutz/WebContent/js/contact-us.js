const overlay = document.querySelector('.modal-container');
const signupOkBtn = document.querySelector('#signup-ok');

if (signupOkBtn != null) {
	signupOkBtn.addEventListener('click', () => {
	    overlay.style.display = 'none';
	});
}
