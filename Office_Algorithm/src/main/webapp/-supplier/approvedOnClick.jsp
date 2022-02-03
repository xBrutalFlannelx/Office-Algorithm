<%-- 
    Document   : approvedOnClick
    Created on : Jul 12, 2021, 9:52:16 AM
    Author     : Zach
Modifies DB of approved suppliers after confirmation
based on options chosen in querySupplier.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmation</title>
    </head>
    <body>
        <div class="bg">
            <br>
            <%                
                DBConnect dbConnect = new DBConnect();
                String item = request.getParameter("item");
                String option = request.getParameter("option");
                String name = request.getParameter("name");
                String quantity = request.getParameter("quantity");
                String supplierID = request.getParameter("supplierID");

                //redirect if querySupplier.jsp radio is not clicked
                if (option == null) {
                    option = "";
                    response.sendRedirect("querySupplier.jsp?message=error&name=" + name);
                }

                String stock = "select stock.stockID, stock.ordered, stock.available from stock "
                        + "INNER JOIN supplierstock on stock.stockID = supplierstock.stockID where supplierstock.supplierID = '"
                        + supplierID + "' and stock.item = '" + item + "'";

                ResultSet stockSet = dbConnect.DBQuery(stock);

                try {
                    stockSet.next();
                } catch (Exception e) {
                    option = "error";
                    out.print("<h2>Error: Please try again.</h2>");
                }
                //order stock after confirmation accepted
                if (option.equals("confirmOrder")) {

                    int orderedDB = Integer.parseInt(stockSet.getString(2));
                    int orderInput = Integer.parseInt(quantity);
                    int orderSum = orderedDB + orderInput;

                    String update = "update stock set ordered = '" + orderSum + "' where stockID = '"
                            + stockSet.getString(1) + "'";
                    String message = dbConnect.updateDB(update);

                    if (message.equals("Update Successful")) {
                        response.sendRedirect("querySupplier.jsp?name=" + name + "&message=Success: "
                                + quantity + " " + item + "s ordered.");
                    }
                }
                //adjust available stock after confirmation accepted
                if (option.equals("confirmAdjust")) {

                    int availInput = Integer.parseInt(quantity);
                    String update = "update stock set available = '" + availInput + "' where stockID = '"
                            + stockSet.getString(1) + "'";
                    String message = dbConnect.updateDB(update);

                    if (message.equals("Update Successful")) {
                        response.sendRedirect("querySupplier.jsp?name=" + name + "&message=Success: "
                                + item + " inventory updated.");
                    }
                }
                //delete stock after confirmation accepted
                if (option.equals("confirmDelete")) {

                    String deleteSupplierStock = "delete from supplierstock where stockID = '"
                            + stockSet.getString(1) + "' and supplierID = '" + supplierID + "'";
                    String deleteStock = "delete from stock where stockID = '"
                            + stockSet.getString(1) + "'";

                    String message2 = dbConnect.updateDB(deleteSupplierStock);
                    String message3 = dbConnect.updateDB(deleteStock);

                    if (message2.equals("Update Successful")) {
                        if (message3.equals("Update Successful")) {
                            response.sendRedirect("querySupplier.jsp?name=" + name + "&message=Success: "
                                    + item + " inventory deleted.");
                        }
                    }
                }
                //print confirmation page based on option passed from querySupplier.jsp
                //confirmation submit adds "confirm" to option string and sends form to itself
                if (option.equals("Delete")) {

                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h2>"
                            + option + " " + item + "?<br><br>Action cannot be undone.</h2><br></div>");
                }
                if (option.equals("Order")) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h2>"
                            + option + " " + quantity + " " + item + "s?</h2><br></div>");
                }
                if (option.equals("Adjust")) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h2>"
                            + option + " " + item + " Inventory<br><br>Actual Quantity " + quantity + "?</h2><br></div>");
                }
            %>
            <div class='container boxedWhite centered'>
                <br>
                <form name='confirm' action='approvedOnClick.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="item" name="item" value="<%=item%>">
                    <input type="hidden" id="option" name="option" value="<%="confirm" + option%>">
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <input type="hidden" id="quantity" name="quantity" value="<%=quantity%>">
                    <input type="hidden" id="supplierID" name="supplierID" value="<%=supplierID%>">
                    <button type='btnSubmit' class='button submitButton'>Proceed</button> 
                </form>
                <form name='cancelChanges' action='querySupplier.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <button type='btnSubmit' class='button submitButton'>Return</button> 
                </form>
                <br>
                <br>
            </div>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>
