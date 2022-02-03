<%-- 
    Document   : customerOrder
    Created on : Jul 26, 2021, 4:42:57 PM
    Author     : Zach
    list all orders for specific customer
    option to modify, cancel and ship processing orders
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet, java.math.BigDecimal"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Query</title>
    </head>
    <body>
        <div class="bg">
            <%                
                DBConnect dbConnect = new DBConnect();
                String customerID = request.getParameter("customerID");
                String message = request.getParameter("message");
                
                String customer = "select firstname, lastname, email from customer where customerID = '" + customerID + "'";
                ResultSet rst = dbConnect.DBQuery(customer);
                
                if (message != null) {
                    out.print("<h2 class='centered'><br>" + message + "</h2>");
                }
                if (!rst.next()) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Error</h1><br></div>");
                } else {
                    out.print("<br><div class='container' style='text-align:center'><br><h1><u>" + rst.getString(1)
                            + " " + rst.getString(2) + "<br></u>-<u><br>" + rst.getString(3) + "</u></h1><br></div>");
                }
            %>
            <br>
            <%
                String order = "select purchaseID, date, status from purchase where customerID = '" + customerID + "'";
                ResultSet orders = dbConnect.DBQuery(order);

                if (!orders.next()) {
                    out.print("<div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>No Orders</h1><br></div>");
                } else {

                    orders.beforeFirst();
                    while (orders.next()) {

                        String orderQuery = "select stock.item, stock.cost from stock "
                                + "INNER JOIN stockpurchase on stock.stockID = stockpurchase.stockID where stockpurchase.purchaseID = '"
                                + orders.getString(1) + "'";

                        String quantity = "select quantity from stockpurchase "
                                + "INNER JOIN stock on stockpurchase.stockID = stock.stockID where stockpurchase.purchaseID = '" + orders.getString(1) + "'";

                        ResultSet item = dbConnect.DBQuery(orderQuery);
                        ResultSet itemQuantity = dbConnect.DBQuery(quantity);
                        //calculate order cost and create a table for each
                        BigDecimal _sum = new BigDecimal("0.00");
            %>
            <div class='container boxedTitle lightToDarkBottom' style="display: flex; justify-content: space-between; color: white">
                <h2 class="alignleft"><br><%=orders.getString(3)%><br><br></h2>
                <h2 class="aligncenter"><br>Order # <%=orders.getString(1)%><br><br></h2>
                <h2 class="alignright"><br><%=orders.getString(2)%><br><br></h2>
            </div>
            <div class="container boxedWhite" align="center">
                <br>
                <table>
                    <tr class="lightToDarkBottom" style="color:white">
                        <th>Item</th>
                        <th>Quantity</th>
                        <th>Cost</th>
                    </tr>
                    <%
                        while (item.next()) {
                            
                            itemQuantity.next();

                            BigDecimal _cost = new BigDecimal(item.getString(2));
                            BigDecimal _quantity = new BigDecimal(itemQuantity.getString(1));
                            BigDecimal _temp = _sum;
                            _sum = _cost.multiply(_quantity).add(_temp);
                    %>
                    <tr>
                        <td><%=item.getString(1)%></td>
                        <td><%=itemQuantity.getString(1)%></td>
                        <td><%=item.getString(2)%></td>
                    </tr>      
                    <%}
                        BigDecimal _tax = new BigDecimal("0.0625").multiply(_sum);
                        BigDecimal _shipping = new BigDecimal("9.99");
                        BigDecimal _total = _sum.add(_tax).add(_shipping);
                        _tax = _tax.setScale(2, BigDecimal.ROUND_HALF_UP);
                        _total = _total.setScale(2, BigDecimal.ROUND_HALF_UP);
                    %>  
                    <tr class="lightToDarkBottom" style="color:white">
                        <th>Subtotal</th>
                        <th>Tax & Shipping</th>
                        <th>Total</th>
                    </tr>
                    <tr>
                        <td><%="$" + _sum%></td>
                        <td><%="$" + _tax + " + " + _shipping%></td>
                        <td><%="$" + _total%></td>
                    </tr>
                </table>
            </div>
            <br>
            <% //if order is processing display options to modify
                //if already shipped only display table
                if (orders.getString(3).equals("Processing")) {
            %>
            <div class='container centered'>
                <div class='button submitButton'>
                    <a id="modify" href="">Modify</a>
                </div>
                <div class='button submitButton'>
                    <a id="cancel" href="">Cancel</a>
                </div>
                <div class='button submitButton'>
                    <a id="ship" href="">Ship</a>
                </div>
            </div>
            <script>
                <%//each button ID must be unique or only first set is modified%>
                var orderID = <%=orders.getString(1)%>;
                var customerID = <%=customerID%>;
                document.getElementById("ship").setAttribute('id', orderID + "ship");
                document.getElementById("modify").setAttribute('id', orderID + "modify");
                document.getElementById("cancel").setAttribute('id', orderID + "cancel");
                document.getElementById(orderID + "ship").setAttribute('href', 'orderOnClick.jsp?option=ship&orderID='
                        + orderID + "&customerID=" + customerID);
                document.getElementById(orderID + "modify").setAttribute('href', 'orderOnClick.jsp?option=modify&orderID='
                        + orderID + "&customerID=" + customerID);
                document.getElementById(orderID + "cancel").setAttribute('href', 'orderOnClick.jsp?option=cancel&orderID='
                        + orderID + "&customerID=" + customerID);
            </script> 
            <%}%>
            <br>
            <%}
                }%>
            <br>
            <div class='container centered'>
                <div class='button submitButton'>
                    <a id="return" href="queryCustomer.jsp">Return to Customers</a>     
                </div>
                <br>
            </div>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>
