<%-- 
    Document   : loginAction
    Created on : Aug 4, 2021, 7:18:47 PM
    Author     : Zach
Query DB to confirm if credentials are an admin/supplier/customer
pending admin will be prompted to change default password
Currently Suppliers/Customers can only create accounts, login and logout
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <script src="password.js"></script>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <div class="bg">
            <br><br>   
            <%                
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                String validateAdmin = "Select adminID, status FROM office_algorithm.admin where username = '"
                        + username + "' and password = '" + password + "'";
                String validateCustomer = "Select customerID FROM office_algorithm.customer where username = '"
                        + username + "' and password = '" + password + "'";
                String validateSupplier = "Select supplierID, status FROM office_algorithm.supplier where username = '"
                        + username + "' and password = '" + password + "'";

                DBConnect dbConnect = new DBConnect();
                ResultSet admin = dbConnect.validatePwd(validateAdmin);
                ResultSet customer = dbConnect.validatePwd(validateCustomer);
                ResultSet supplier = dbConnect.validatePwd(validateSupplier);

                if (admin.next()) {

                    if (admin.getString(2).equals("Approved")) {
                        //keep track of user session and redirect to admin home page
                        session.setAttribute("logged", "admin");
                        session.setAttribute("username", username);
                        session.setAttribute("sessionID", admin.getString(1));
                        response.sendRedirect("adminAction.jsp");
                        return;
                    }

                    if (admin.getString(2).equals("Pending")) {
                        //pending admin will create new password below
                        out.print("<br><div class='container boxedTitle lightToDarkBottom'><br><h1>Welcome "
                                + username + "</h1><br></div>");
                    }

                } else if (customer.next()) {
                    //keep track of user session and redirect to index.jsp
                    session.setAttribute("logged", "customer");
                    session.setAttribute("username", username);
                    session.setAttribute("sessionID", customer.getString(1));
                    response.sendRedirect("index.jsp");
                    return;

                } else if (supplier.next()) {

                    if (supplier.getString(2).equals("Approved")) {
                        //keep track of approved user session and redirect to index.jsp
                        session.setAttribute("logged", "supplier");
                        session.setAttribute("username", username);
                        session.setAttribute("sessionID", supplier.getString(1));
                        response.sendRedirect("index.jsp");
                        return;
                    }

                    if (supplier.getString(2).equals("Pending")) {
                        //pending supplier can't login without approval
                        response.sendRedirect("login.jsp?error=pending");
                        return;
                    }

                } else {
                    //return to login page with error upon empty resultSets
                    response.sendRedirect("login.jsp?error=invalid");
                    return;
                }
                //pending admin requires password change to proceed
            %>
            <form name='updatePass' action='adminPass.jsp' method='post'>
                <div class="container boxedWhite centered">
                    <br><h2>Please update your current password</h2><br>
                    <tr>
                    <label class='inputLabel'>Password:</label>
                    <input class='form-control center-input' type="password" name="newPass" id="newPass" size="40" 
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                    </tr>
                    <tr>
                    <label class='inputLabel'>Confirm Password:</label>
                    <input class='form-control center-input' type="password" name="confirmPass" id="confirmPass" size="40" 
                           pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required>
                    </tr>
                    <div class='container centered'>
                        <br>
                        <p id="valid"></p>
                        <button class="button submitButton" type="submit" onclick="return Validate()">Submit</button>
                        <input type="hidden" id="username" name="username" value="<%=username%>">
                        <input type="reset" value="Reset" class='button resetButton'/>
                        <br><br>
                    </div>
            </form>
        </div>
        <br><br>       
        <%@include file="footer.jsp" %>
    </div>
</body>
</html>
<script>
    document.getElementById("newPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("confirmPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
</script>

