<%-- 
    Document   : orderOnClick
    Created on : Jul 27, 2021, 4:12:41 PM
    Author     : Zach
    modify/cancel/ship order selected in customerOrder.jsp
    confirm and DB update in same jsp for cancel/ship
    updateOrder.jsp modifies order
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Order</title>
    </head>
    <body>
        <div class="bg">
            <%                
                DBConnect dbConnect = new DBConnect();
                String orderID = request.getParameter("orderID");
                String customerID = request.getParameter("customerID");
                String option = request.getParameter("option");
                String shipSuccess = "";
                String cancelSuccess = "";

                if (option.equals("cancel")) {
                    out.print("<br><br><br><br><br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Cancel Order # "
                            + orderID + " ?</h1><br></div>");
                }
                if (option.equals("ship")) {
                    out.print("<br><br><br><br><br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Ship Order # "
                            + orderID + " ?</h1><br></div>");
                }
                if (option.equals("modify")) {
                    out.print("<br><br><br><br><br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Modify Order # "
                            + orderID + " Below:</h1><br></div>");
                }
                if (option.equals("cancel") || option.equals("ship")) {
                    //confirm order shipment or cancellation
%>
            <div class='container boxedWhite centered'>
                <br>
                <form name='cancelShipConfirm' action='orderOnClick.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="orderID" name="orderID" value="<%=orderID%>">
                    <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                    <input type="hidden" id="option" name="option" value="<%="confirm" + option%>">
                    <button type='btnSubmit' class='button submitButton'>Proceed</button> 
                </form>
                <form name='returnToCustomer' action='customerOrder.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                    <button type='btnSubmit' class='button submitButton'>Return</button> 
                </form>
                <br>
                <br>
            </div>
            <br>
            <br>
            <% }
                if (option.equals("confirmship")) {
                    //update DB to display order as shipped and redirect success message
                    String ship = dbConnect.updateDB("update office_algorithm.purchase set status = 'Shipped' where purchaseID = '"
                            + orderID + "'");
                    if (ship.equals("Update Successful")) {
                        shipSuccess = "Success: Order # " + orderID + " Shipped";
                    } else {
                        shipSuccess = "Error: Please try again";
                    }
            %>
            <form id='shipSuccess' name='shipSuccess' action='customerOrder.jsp' method='post'>
                <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                <input type="hidden" id="message" name="message" value="<%=shipSuccess%>">
            </form>
            <script>
                document.getElementById('shipSuccess').submit();
            </script>
            <%
                }
                if (option.equals("confirmcancel")) {
                    //delete order from DB
                    String stockPurchase = "delete from office_algorithm.stockpurchase where purchaseID = '"
                            + orderID + "'";
                    String purchase = "delete from office_algorithm.purchase where purchaseID = '"
                            + orderID + "'";

                    String cancel = dbConnect.updateDB(stockPurchase);
                    String cancel2 = dbConnect.updateDB(purchase);

                    if (cancel.equals("Update Successful")) {
                        if (cancel2.equals("Update Successful")) {
                            cancelSuccess = "Success: Order # " + orderID + " Cancelled";
                        }
                    } else {
                        cancelSuccess = "Error: Please try again";
                    }
            %>
            <form id='cancelSuccess' name='cancelSuccess' action='customerOrder.jsp' method='post'>
                <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                <input type="hidden" id="message" name="message" value="<%=cancelSuccess%>">
            </form>
            <script>
                document.getElementById('cancelSuccess').submit();
            </script>
            <%
                }
                if (option.equals("modify")) {
                    //display order with input fields to update quantities
                    //updateOrder.jsp calculates changes and modifies DB
                    String stock = "select stock.item, stock.available, stock.stockID from office_algorithm.stock INNER JOIN office_algorithm.stockpurchase on stock.stockID = stockpurchase.stockID where stockpurchase.purchaseID = '"
                            + orderID + "'";
                    String quant = "select quantity from office_algorithm.stockpurchase INNER JOIN office_algorithm.stock on stockpurchase.stockID = stock.stockID where stockpurchase.purchaseID = '"
                            + orderID + "'";

                    ResultSet item = dbConnect.DBQuery(stock);
                    ResultSet quantity = dbConnect.DBQuery(quant);
            %>
            <form action="updateOrder.jsp" id="updateOrder" method="post">
                <div class="container boxedWhite" align="center">
                    <br>
                    <table>
                        <tr class="lightToDarkBottom" style="color:white">
                            <th>Item</th>
                            <th>Order Quantity</th>
                            <th>Available</th>
                            <th>New Order Quantity</th>
                        </tr>

                        <%
                            while (item.next()) {
                                quantity.next();
                        %>
                        <tr>
                            <td><%=item.getString(1)%></td>
                            <td><%=quantity.getString(1)%></td>
                            <td><%=item.getString(2)%></td>
                            <td><input class='form-control' id='temp' name='temp' type="number" min="0" max="1" step="1" 
                                       placeholder="Enter here:"required oninvalid="this.setCustomValidity('')"
                                       oninput="this.setCustomValidity('')">
                                <script>
                                    var inputField = document.getElementById('temp');
                                    var stockID = <%=item.getString(3)%>;
                                    var total = parseInt(<%=item.getString(2)%>)
                                            + parseInt(<%=quantity.getString(1)%>);

                                    inputField.setAttribute('id', stockID);
                                    inputField.setAttribute('name', stockID);
                                    inputField.setAttribute('max', total);
                                </script>
                        </tr>   
                        <%}%>
                        <br>
                    </table>
                    <br>
                </div>
                <br>
                <div class='container centered'>
                    <input type="submit" value="Submit" class='button submitButton'/>
                    <input type="hidden" id="orderID" name="orderID" value="<%=orderID%>">
                    <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                    </form>
                    <form name='cancelModify' action='customerOrder.jsp' style='display: inline-block' method='post'>
                        <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                        <button type='btnSubmit' class='button submitButton'>Return</button> 
                    </form>
                </div>
                <%}%>
            <br>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
