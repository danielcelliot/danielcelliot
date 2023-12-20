// -----------------------------
// |       Constants           |
// -----------------------------

const loginForm =  document.querySelector('.login-form');
const regForm = document.querySelector('.register-form');
const signUpLink = document.querySelector('.sign-up-link');
const signupBtn = document.querySelector('#signup-btn');
const signInBtn = document.querySelector('#login-btn');
const overlay = document.querySelector('.modal-container');
const spinner = document.querySelector('.spinner-container.dialog');
const dialogMsg = document.querySelector('#error-msg');
const dialogHeading = document.querySelector("#error-heading");
const dialogBox = document.querySelector('.modal-content');
const okBtn = document.querySelector('#ok');
const signupOkBtn = document.querySelector('#signup-ok');


// -----------------------------
// |       Event Listeners     |
// -----------------------------

signUpLink.addEventListener('click', () => {
    // Fade out login form
    loginForm.style.opacity = 0;

    setInterval(() => {
        loginForm.classList.remove('is-showing');
        regForm.classList.add('is-showing');
        
        // Fade in registration form
        setInterval(() => {
            regForm.style.opacity = 1;
        }, 100);
    }, 500);

});

signInBtn.addEventListener('click', (e) => {
    var email = document.getElementById("email").value;
    var password = document.getElementById("password").value;
    
    if (email != "" && password != "") {
        e.preventDefault();
        submitLogin(email, password);
    }
});

signupBtn.addEventListener('click', (e) => {
    var firstName = document.getElementById("signup-fname").value;
    var lastName = document.getElementById('signup-lname').value;
    var email = document.getElementById("signup-email").value;
    var password = document.getElementById("signup-pwd").value;
    var confirmPass = document.getElementById('signup-pwd-confirm').value;
    
    if (password != confirmPass) {
        e.preventDefault();
        
        overlay.style.display = 'initial';
        spinner.style.display = 'initial';

        setTimeout(() => {
            spinner.style.display = 'none';
            displayDialog("pwd_mismatch");
        }, 1500);
    } else if (firstName != "" && lastName != "" && email != "" && password != "" && confirmPass != "") {
        e.preventDefault();
        submitSignup(firstName, lastName, email, password);
    }
});

okBtn.addEventListener('click', () => {
    overlay.style.display = 'none';
    dialogBox.style.display = 'none';

    document.getElementById("email").focus();
})

if (signupOkBtn != null) {
    signupOkBtn.addEventListener('click', () => {
        signupOkBtn.parentElement.parentElement.parentElement.remove();
    
        document.getElementById("email").focus();
    });
}


// -----------------------------
// |       Functions           |
// -----------------------------

function displayDialog(msgType) {
    dialogHeading.innerHTML = "There was a problem";

    if (msgType == "login_error") {
        dialogMsg.innerHTML = "Your e-mail address or password is incorrect";
    } else if (msgType == "email_error") {
        dialogMsg.innerHTML = "Please enter a valid e-mail address";
    } else if (msgType == "email_exists") {
        dialogMsg.innerHTML = "This e-mail address is already in use";
    } else if (msgType == "pwd_mismatch") {
        dialogMsg.innerHTML = "Please make sure your passwords match";
    }

    dialogBox.style.display = 'flex';
    okBtn.focus();
}

function submitSignup(fname, lname, email, pass) {
    var http = new XMLHttpRequest();
    http.open("POST", "../scriptlets/submitReg.jsp", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    
    var signupInfo = "firstname=" + fname + "&lastname=" + lname + "&email=" + email + "&password=" + pass;
    
    http.send(signupInfo);
    http.onload = function() {
        overlay.style.display = 'initial';
        spinner.style.display = 'initial';

        setTimeout(() => {
            spinner.style.display = 'none';

            if (http.responseText.trim() == "email_error" || http.responseText.trim() == "email_exists") {
                displayDialog(http.responseText.trim());
            } else {
                window.location.href = http.responseText;
            }
        }, 1500);
    }
}

function submitLogin(email, password) {
    var http = new XMLHttpRequest();
    http.open("POST", "../scriptlets/submitLogin.jsp", true);
    http.setRequestHeader("Content-type","application/x-www-form-urlencoded");
    
    var email_pwd = "email=" + email + "&" + "password=" + password;
    
    http.send(email_pwd);
    http.onload = function() {
        overlay.style.display = 'initial';
        spinner.style.display = 'initial';

        setTimeout(() => {
            spinner.style.display = 'none';

            if (http.responseText.trim() == "login_error" || http.responseText.trim() == "email_error") {
                displayDialog(http.responseText.trim());
            } else {
                window.location.href = http.responseText;
            }
        }, 1500);
    }
}