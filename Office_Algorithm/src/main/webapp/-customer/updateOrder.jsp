<%-- 
    Document   : updateOrder
    Created on : Jul 28, 2021, 7:40:30 PM
    Author     : Zach
    Modifies order in the DB based on the form submitted in orderOnClick.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet, java.io.*,java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Order</title>
    </head>
    <body>
        <div class="bg">
            <%                
                DBConnect dbConnect = new DBConnect();
                String orderID = request.getParameter("orderID");
                String customerID = request.getParameter("customerID");
                String[] paramName;
                String[] paramValue;

                //scan for all parameters passed to updateOrder.jsp
                //paramater name = stockID and its value = new order quantity
                //start i at 2 to account for orderID and customerID parameters
                int i = 2;
                ResultSet stock = dbConnect.DBQuery("select stockID from stock");

                //allocate array sizes based on total DB stock
                while (stock.next()) {
                    i++;
                }
                //initialize arrays 
                paramName = new String[i];
                paramValue = new String[i];

                i = 0;
                //find all submitted parameters
                //upon DB expansion, this could be any number of items and combinations
                Enumeration paramNames = request.getParameterNames();

                while (paramNames.hasMoreElements()) {

                    String tempName = (String) paramNames.nextElement();

                    if (!tempName.equals("orderID") && !tempName.equals("customerID")) {

                        paramName[i] = tempName;
                        paramValue[i] = request.getParameter(paramName[i]);

                        ResultSet avail = dbConnect.DBQuery("select available from stock where stockID = '" + paramName[i] + "'");

                        ResultSet orderQuant = dbConnect.DBQuery("select quantity from stockpurchase where stockID = '"
                                + paramName[i] + "' and purchaseID = '" + orderID + "'");

                        avail.next();
                        orderQuant.next();
                        //convert strings to ints to calculate updated available stock
                        int available = Integer.parseInt(avail.getString(1));
                        int orderQuan = Integer.parseInt(orderQuant.getString(1));
                        int newQuan = Integer.parseInt(paramValue[i]);
                        //update order item quantity in DB
                        String updateOrder = "update stockpurchase set quantity = '" + paramValue[i] + "' where stockID = '"
                                + paramName[i] + "' and purchaseID = '" + orderID + "'";

                        //calculate new # of available
                        if (newQuan > orderQuan) {
                            available -= (newQuan - orderQuan);
                        }
                        if (newQuan < orderQuan && newQuan != 0) {
                            available += (orderQuan - newQuan);
                        }
                        if (newQuan == 0) {
                            //overwrite updateorder string to delete entry from DB
                            available += orderQuan;
                            updateOrder = "delete from stockpurchase where stockID = '"
                                    + paramName[i] + "' and purchaseID = '" + orderID + "'";
                        }
                        //update avail in DB
                        String updateAvail = "update stock set available = '" + available + "' where stockID = '"
                                + paramName[i] + "'";

                        String modify = dbConnect.updateDB(updateOrder);
                        String modify2 = dbConnect.updateDB(updateAvail);
                        if (modify.equals("Update Successful")) {
                            if (modify2.equals("Update Successful")) {
                                continue;
                            }
                        } else {
                            out.print("<h2>Error: Please try again.</h2>");
                            break;
                        }
                    }
                }
                String message = "Success: Order # " + orderID + " Modified";
            %>
            <form id='updateSuccess' name='updateSuccess' action='customerOrder.jsp' method='post'>
                <input type="hidden" id="customerID" name="customerID" value="<%=customerID%>">
                <input type="hidden" id="message" name="message" value="<%=message%>">
            </form>
            <script>
                document.getElementById('updateSuccess').submit();
            </script>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>

