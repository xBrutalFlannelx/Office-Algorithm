<%-- 
    Document   : querySupplier
    Created on : Jun 24, 2021, 2:50:04 PM
    Author     : Zach
displays account information and associated stock for all supplier accounts
approve/deny pending accounts
adjust available/order/delete approved stock 
pendingOnClick.jsp/approvedOnClick.jsp update DB accordingly
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <script src="../password.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier Information</title>
    </head>
    <body>
        <div class="bg">
            <%            
                DBConnect dbConnect = new DBConnect();
                String name = request.getParameter("name");
                String message = request.getParameter("message");

            %>
            <br>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1><%=name%></h1><br></div>
                    <%  //print table of account info and inventory regardless of status
                        String info = "select supplierID, username, email, status from office_algorithm.supplier where name = '"
                                + name + "'";

                        ResultSet supplierQuery = dbConnect.DBQuery(info);
                        supplierQuery.next();

                        String stock = "select stock.item, stock.available, stock.ordered, stock.cost from office_algorithm.stock "
                                + "INNER JOIN office_algorithm.supplierstock on stock.stockID = supplierstock.stockID where supplierstock.supplierID = '"
                                + supplierQuery.getString(1) + "'";

                        ResultSet stockSet = dbConnect.DBQuery(stock);
                    %>
            <br>
            <div class="container boxedWhite" align="center">
                <br>
                <table>
                    <tr class="lightToDarkBottom" style="color:white">
                        <th class="centered">Username</th>
                        <th class="centered">Email</th>
                        <th class="centered" colspan="2">Status</th>
                    </tr>
                    <tr>
                        <td class="centered"><%=supplierQuery.getString(2)%></td>
                        <td class="centered"><%=supplierQuery.getString(3)%></td>
                        <td class="centered" colspan="2"><%=supplierQuery.getString(4)%></td>
                    </tr>      
                    <%if (stockSet.next()) { %>
                    <tr class="lightToDarkBottom" style="color:white">
                        <th class="centered">Items</th>
                        <th class="centered">Available</th>
                        <th class="centered">Ordered</th>
                        <th class="centered">Cost</th>
                    </tr>
                    <%
                        stockSet.beforeFirst();
                        while (stockSet.next()) {
                    %>
                    <tr>
                        <td class="centered"><%=stockSet.getString(1)%></td>
                        <td class="centered"><%=stockSet.getString(2)%></td>
                        <td class="centered"><%=stockSet.getString(3)%></td>
                        <td class="centered"><%=stockSet.getString(4)%></td>
                    </tr>
                    <% }
                    } else {
                    %>
                    <tr class="lightToDarkBottom" style="color:white;">
                        <td style="text-align: center" colspan="3">No items on file.</td>
                    </tr>
                    <br>
                    <%}%>
                </table>
                <br>
            </div>
            <br>
            <%
                stockSet.beforeFirst();
                if (supplierQuery.getString(4).equals("Pending")) {
                //if account pending display approve/deny/return to previous page buttons
            %>
            <div class='container centered'>
                <form name='approve' action='pendingOnClick.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="supplierID" name="supplierID" value="<%=supplierQuery.getString(1)%>">
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <input type="hidden" id="status" name="status" value="Approve">
                    <button type='btnSubmit' class='button submitButton'>Approve</button>
                </form>
                <form name='deny' action='pendingOnClick.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="supplierID" name="supplierID" value="<%=supplierQuery.getString(1)%>">
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <input type="hidden" id="status" name="status" value="Deny">
                    <button type='btnSubmit' class='button submitButton'>Deny</button> 
                </form>
                <form name='cancel' action='pendingSupplier.jsp' style='display: inline-block' method='post'>
                    <button type='btnSubmit' class='button submitButton'>Return</button> 
                </form>
            </div>

            <%
                }

                if (supplierQuery.getString(4).equals("Approved")) {
                //if account approved print table with dropdown of all associated stock
                //radio button selection to adjust available stock, order, and delete
                //quantity text field
            %>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h2>Update Inventory</h2><br></div>
            <br>
            <div class='container boxedWhite centered'>
                <br>
                <form action="approvedOnClick.jsp" method="post">
                    <table>
                        <tr class="lightToDarkBottom" style="color:white">
                            <th class="centered">Item</th>
                            <th id ="adapt" class="centered" colspan="3">Option</th>
                            <th id ="adapt1" class="centered">Quantity</th>
                        </tr>
                        <tr>
                            <td class="centered"><select name="item" id="item">      
                                    <% while (stockSet.next()) {%>
                                    <option value="<%=stockSet.getString(1)%>"><%=stockSet.getString(1)%></option>
                                    <%}%> 
                                </select></td>
                            <td class="centered"><input type="radio" id="request" name="option" value="Order" onclick="requireQuant(this)">
                                <label for="request">Order Additional</label></td> 
                        <td class="centered"><input type="radio" id="modify" name="option" value="Adjust" onclick="requireQuant(this)">
                            <label for="modify">Adjust Available</label></td>
                        <td class="centered"><input type="radio" id="delete" name="option" value="Delete" onclick="requireQuant(this)">
                            <label for="modify">Delete Stock</label></td>
                        <td id ="adapt2"><input class='form-control' id='quantity' name='quantity' type="number" min="0" step="1" 
                                                placeholder="Enter quantity" oninvalid="this.setCustomValidity('Must be a positive integer')"
                                                oninput="this.setCustomValidity('')"></td>  
                        </tr>
                    </table>
                    <%  //redirect if radio not selected
                        if (message != null) {
                            if (message.equals("error")) {
                                out.print("<br><b>Please select an option to proceed.</b><br>");
                            } else {
                                out.print("<br><b>" + message + "</b><br>");
                            }
                        }
                    %>
                    <br>
                <div style="display: inline-block">
                    <button class="button submitButton" style="display: inline-block" type="submit">Submit</button>
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <input type="hidden" id="supplierID" name="supplierID" value="<%=supplierQuery.getString(1)%>">
                </form>
                <form action="approvedSupplier.jsp" style="display: inline-block" method="post">
                    <button class="button submitButton" type="submit">Return</button>
                </form>
                </div>
                <br>
            </div>
            <%}%>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
