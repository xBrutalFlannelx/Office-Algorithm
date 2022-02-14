<%-- 
    Document   : register
    Created on : Aug 3, 2021, 3:10:06 PM
    Author     : Zach
    change form displayed based on radio selection so 
    suppliers and customers can register accounts
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <script src="password.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Account</title>
    </head>
    <body>
        <div class="bg">
            <%  //message displayed if username/email is already taken
                String error = request.getParameter("error");
                //catch null pointer exception
                if (error == null) {
                    error = "";
                }
                if (error.equals("error")) {
                    out.print("<br><h2 class='centered'>Email or Username taken: Please try again.</h2>");
                }
                //radio button changes which register form is displayed
                //hidden input is submitted with chosen form so registerAction.jsp
                //can distinguish between the two
            %>
            <br>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'>
                <br><h1>Create Account</h1><br>
            </div>
            <br>
            <div class="centered">
                <input type="radio" name="userType" value="customer" onclick="displayForm(this)" checked>
                <label for="request">Customer</label>
                <input type="radio" name="userType" value="supplier" onclick="displayForm(this)">
                <label for="modify">Supplier</label>
            </div>
            <br>
            <div class="container boxedWhite">
                <br>
                <div id="customer" class='creation centered' style="display: block">
                    <form name="customerForm" action="registerAction.jsp" method="post">    
                        <tr>
                        <label class='inputLabel'>Email:</label>
                        <input class='form-control center-input' type="email" name="email" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Username:</label>
                        <input class='form-control center-input' type="text" name="username" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>First Name:</label>
                        <input class='form-control center-input' type="text" name="first" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Last Name:</label>
                        <input class='form-control center-input' type="text" name="last" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Payment Method:</label>
                        <input class='form-control center-input' type="number" name="pay" id="pay" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Password:</label>
                        <input class='form-control center-input' type="password" name="newPass" id="custPass" size="40" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Confirm Password:</label>
                        <input class='form-control center-input' type="password" name="confirmPass" id="custConfirm" size="40" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        </tr>
                        <br>
                        <div class='container centered'>
                            <p id="custValid"></p>
                            <td><input type="submit" value="Submit" class='button submitButton' onclick="return validateCustomer()"/></td>
                            <td><input type="reset" value="Reset" class='button resetButton'/></td>
                            <input type="hidden" id="formType" name="formType" value="customer">
                        </div>
                    </form>
                </div>
                <div id="supplier" class='creation centered' style="display: none">
                    <form name="supplierForm" type="hidden" action="registerAction.jsp" method="post">
                        <tr>
                        <label class='inputLabel'>Email:</label>
                        <input class='form-control center-input' type="email" name="email" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Company Name:</label>
                        <input class='form-control center-input' type="text" name="company" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Username:</label>
                        <input class='form-control center-input' type="text" name="username" size="40" required/>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Password:</label>
                        <input class='form-control center-input' type="password" name="newPass" id="suppPass" size="40" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                        </tr>
                        <tr>
                        <label class='inputLabel'>Confirm Password:</label>
                        <input class='form-control center-input' type="password" name="confirmPass" id="suppConfirm" size="40" 
                               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"required>
                        </tr>
                        <br>
                        <div class='container centered'>
                            <p id="suppValid"></p>
                            <td><input type="submit" value="Submit" class='button submitButton' onclick="return validateSupplier()"/></td>
                            <td><input type="reset" value="Reset" class='button resetButton'/></td>
                            <input type="hidden" id="formType" name="formType" value="supplier">
                        </div>
                    </form>
                </div>
                <a style='font-size: 20px; float: left;' href='login.jsp'>Already have an account? Click Here</a>
                <br>
                </table>
                </tbody>
                <br>
            </div>
            <%@include file="footer.jsp" %>
            < /div>
    </body>
</html>
<script>
    document.getElementById("custPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("custConfirm").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("suppPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("suppConfirm").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("pay").title = "Credit Card Number";
</script>

