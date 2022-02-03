

//check that password and confirm password match
function Validate() {
    var password = document.getElementById("newPass").value;
    var confirmPassword = document.getElementById("confirmPass").value;
    if (password !== confirmPassword) {
        document.getElementById("valid").innerHTML = "<b>Passwords do not match.</b>";
        return false;
    }
    return true;
}
//customer version of validate()
function validateCustomer() {
    var password = document.getElementById("custPass").value;
    var confirmPassword = document.getElementById("custConfirm").value;
    if (password !== confirmPassword) {
        document.getElementById("custValid").innerHTML = "<b>Passwords do not match.</b>";
        return false;
    }
    var pay = document.getElementById("pay").value;
    if (pay.length !== 16) {
        document.getElementById("custValid").innerHTML = "<b>Payment must be 16 Digit Credit Card Number</b>";
        return false;
    }
    return true;
}
//supplier version of validate()
function validateSupplier() {
    var password = document.getElementById("suppPass").value;
    var confirmPassword = document.getElementById("suppConfirm").value;
    if (password !== confirmPassword) {
        document.getElementById("suppValid").innerHTML = "<b>Passwords do not match.</b>";
        return false;
    }
    return true;
}
//toggles between customer/supplier regristration form
function displayForm(x) {
    if (x.value === "customer") {
        document.getElementById("customer").style.display = 'block';
        document.getElementById("supplier").style.display = 'none';
    } else if (x.value === "supplier") {
        document.getElementById("customer").style.display = 'none';
        document.getElementById("supplier").style.display = 'block';
    }
}
//in querySupplier.jsp toggle approved supplier table depending on 
//radio option (revise/order/delete)
function requireQuant(x) {
    if (x.value === "Delete") {
        document.getElementById("quantity").required = "";
        document.getElementById("quantity").style.display = 'none';
        document.getElementById("adapt").colspan = '4';
        document.getElementById("adapt1").style.display = 'none';
        document.getElementById("adapt2").style.display = 'none';
    } else {
        document.getElementById("quantity").required = "required";
        document.getElementById("adapt").colspan = '3';
        document.getElementById("adapt1").style.display = 'block';
        document.getElementById("adapt2").style.display = 'block';
    }
    if (x.value === "Adjust") {
        document.getElementById("quantity").placeholder = "Enter Total Amount Available";
        document.getElementById("quantity").style.display = 'block';
    }
    if (x.value === "Order") {
        document.getElementById("quantity").placeholder = "Enter Amount to Order";
        document.getElementById("quantity").style.display = 'block';
    }
}

