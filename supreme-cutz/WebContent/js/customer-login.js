const overlay = document.querySelector('.modal-container');
const spinner = document.querySelector('.spinner-container.dialog');
const dialogMsg = document.querySelector('#error-msg');
const dialogHeading = document.querySelector("#error-heading");
const dialogBox = document.querySelector('.modal-content');
const yesBtn = document.querySelector('#yes');
const noBtn = document.querySelector('#no');
const cancelBtn = document.querySelectorAll('.cancel-btn');
const logoutBtn = document.querySelector('.log-out-btn');

noBtn.addEventListener('click', () => {
    overlay.style.display = 'none';
});

cancelBtn.forEach((btn) => {
    btn.addEventListener('click', () => {
        var orderId = btn.id;
        var href = "../scriptlets/cancelOrder.jsp?order_id=" + orderId;

        displayDialog("Confirm Cancel", "Are you sure you want to cancel this order?", href);
    })
})

logoutBtn.addEventListener('click', () => {
    var href = "../scriptlets/submitLogout.jsp";

    displayDialog("Confirm Sign Out", "Are you sure you want to sign out?", href);
})

function displayDialog(msgHeader, msgType, action) {
    dialogHeading.innerHTML = msgHeader;
    dialogMsg.innerHTML = msgType;
    
    overlay.style.display = 'initial';

    yesBtn.addEventListener('click', () => {
        window.location.href = action;
    })
}