<%-- 
    Document   : registerAction.jsp
    Created on : Aug 4, 2021, 3:01:40 PM
    Author     : Zach
Check for duplicate username or email 
entry before DB insertion 
supplier/customer accounts only
form is displayed after supplier account creation, for user to input stock
form submits back to registerAction.jsp to add stock to DB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Submit Account</title>
    </head>
    <body>
        <div class="bg">
            <%                
                String form = request.getParameter("formType");
                String email = request.getParameter("email");
                String username = request.getParameter("username");
                String password = request.getParameter("confirmPass");
                String company = request.getParameter("company");
                String first = request.getParameter("first");
                String last = request.getParameter("last");
                String pay = request.getParameter("pay");

                String pendingSuccess = "<h3>Supplier Account Submitted<br><br>Please await Admin Approval</h3><br><br>";

                DBConnect dbConnect = new DBConnect();

                //if form parameter is null, supplier stock form has been submitted already
                if (form == null) {

                    form = "";
                    String supplierID = request.getParameter("pendingSupplierID");
                    String item = request.getParameter("item");
                    String cost = request.getParameter("cost");
                    String avail = request.getParameter("avail");

                    //insert stock
                    String stock = "INSERT into stock (item, cost, available, ordered, status) values ('"
                            + item + "', '" + cost + "', '" + avail + "', '0', 'Pending')";
                    String message = dbConnect.updateDB(stock);
                    //find stockID of new insert
                    ResultSet stockID = dbConnect.DBQuery("Select stockID from stock where item = '" + item + "'");
                    stockID.next();
                    //insert relation into supplierstock
                    String message1 = dbConnect.updateDB("INSERT into supplierstock (supplierID, stockID) values ('"
                            + supplierID + "', '" + stockID.getString(1) + "')");
                    //if both successfull create success message to return to login.jsp and autosubmit form
                    if (message.equals("Update Successful") && message1.equals("Update Successful")) {
            %>
            <form id='supplierItem' name='supplierItem' action='login.jsp' method='post'>
                <input type="hidden" id="error" name="error" value="<%=pendingSuccess%>">
            </form>
            <script>
                document.getElementById('supplierItem').submit();
            </script>
            <%
                    }
                }
                //if customer form submitted
                if (form.equals("customer")) {

                    String customer = "INSERT into customer (email, username, password, firstname, lastname, paymethod) values ('"
                            + email + "', '" + username + "', '" + password + "', '" + first + "', '" + last + "', '" + pay + "')";

                    String duplicate = "Select customerID FROM customer where Username = '"
                            + username + "' or email = '" + email + "'";

                    ResultSet existingAccount = dbConnect.DBQuery(duplicate);
                    //check for duplicate email/username before DB update
                    if (existingAccount.next()) {
                        response.sendRedirect("register.jsp?error=error");
                    } else {
                        String message = dbConnect.updateDB(customer);
                        if (message.equals("Update Successful")) {
                            //if successful create message to be submitted to login.jsp
                            String success = "<h2>Success: Customer Account Created<br>Please login below</h2><br><br>";
            %>
            <form id='newCustomer' name='newCustomer' action='login.jsp' method='post'>
                <input type="hidden" id="error" name="error" value="<%=success%>">
            </form>
            <script>
                document.getElementById('newCustomer').submit();
            </script>
            <%
                        }
                    }
                }
                //if supplier form submitted
                if (form.equals("supplier")) {

                    String supplier = "INSERT into supplier (email, username, password, name, status) values ('"
                            + email + "', '" + username + "', '" + password + "', '" + company + "', 'Pending')";

                    String duplicate = "Select supplierID FROM supplier where Username = '"
                            + username + "' or email = '" + email + "'";

                    ResultSet existingAccount = dbConnect.DBQuery(duplicate);
                    //check for duplicate email/username before DB update
                    if (existingAccount.next()) {
                        response.sendRedirect("register.jsp?error=error");
                    } else {
                        String message1 = dbConnect.updateDB(supplier);
                        if (message1.equals("Update Successful")) {
                            //if account creation successful, print stock form header 
                            out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'>"
                                    + "<br><h1>Please Submit Inventory Below</h1><br></div><br>");
                            //query DB for new account key and print form
                            ResultSet pendingItems = dbConnect.DBQuery("Select supplierID from supplier where name = '" + company + "'");
                            try {
                                pendingItems.next();
                            } catch (Exception e) {
                                out.print("<h2>Error: Please try again.</h2>");
                            }
            %>
            <div class="container boxedWhite centered">
                <form action="registerAction.jsp" method="post">
                    <table>
                        <br>
                        <tr class="lightToDarkBottom" style="color:white">
                            <th class="centered">Item Name</th>
                            <th class="centered">Individual Cost</th>
                            <th class="centered">Quantity Available</th>
                        </tr>
                        <tr>
                            <td><input class='form-control center-input' style="width: 250px" id='item' name='item' type="text" size="30" required></td> 
                            <td><input class='form-control center-input' style="width: 250px" id='cost' name='cost' type="text" size="10" required></td>
                            <td><input class='form-control center-input' style="width: 250px" id='avail' name='avail' type="text" size="10" required></td>
                        </tr>
                    </table>
                    <br>
                    <p class="centered"><b>Submitting Inventory will increase your chance of Approval<br>Otherwise Press Cancel</b></p>
                    <div class="centered" style="display: inline-block">
                        <button class="button submitButton" style="display: inline-block" type="submit">Submit</button>
                        <input type="hidden" id="pendingSupplierID" name="pendingSupplierID" value="<%=pendingItems.getString(1)%>">
                        </form>
                        <form action="login.jsp" style="display: inline-block" method="post">
                            <button class="button submitButton" type="submit">Cancel</button>
                            <input type="hidden" id="error" name="error" value="<%=pendingSuccess%>">
                        </form>
                    </div>
                  <br>
                </div>
          <%
                      }
                  }
              }
          %>
        <%@include file="footer.jsp" %>
      </div>
    </body>
</html>

