<%-- 
    Document   : index
    Created on : Nov 20, 2020, 4:54:05 PM
    Author     : Zach
Home page lists all approved available stock 
and links to login or signup
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet, java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Office Algorithm</title>
    </head>
    <body>
        <div class="bg">
            <%                    
                DBConnect dbConnect = new DBConnect();
                String approvedItems = "Select item, cost, available, status from office_algorithm.stock where Status = 'Approved'";
                ResultSet itemsForSale = dbConnect.validatePwd(approvedItems);

                try {

                    itemsForSale.next();
                    out.print("<br><div class='container boxedTitle midLightToMidDark centered' style='color:white;'>"
                            + "<br><h1>Items In Stock</h1><br></div>");
                    itemsForSale.beforeFirst();
            %>
            <br>
            <div class=" container boxedWhite centered"">
                <br>
                <table>
                    <tr class="lightToDarkBottom" style="color:white">
                        <th class="centered">Inventory</th>
                        <th class="centered">Cost</th>
                    </tr>
                    <%
                        while (itemsForSale.next()) {
                            int avail = Integer.parseInt(itemsForSale.getString(3));
                            if (avail > 0 && itemsForSale.getString(4).equals("Approved")) {
                    %>
                    <tr>
                        <th class="centered"><%=itemsForSale.getString(1)%></th>
                        <th class="centered"><%=itemsForSale.getString(2)%></th>
                    </tr>
                    <%}
                        }%>
                </table>
                <%if (logged == null) {%>
                <div style="display: inline-block; float: left;">
                    <br>
                    <br>
                    <p style='font-size: 20px;'>Interested? </p>
                    <a style='font-size: 20px;'href='register.jsp'><u>Click Here to Sign-Up</u></a>
                </div>
                <div style="display: inline-block; float: right;">
                    <br>
                    <br>
                    <p style='font-size: 20px;'>Otherwise </p>
                    <a style='font-size: 20px;'href='login.jsp'><u>Click Here to Login</u></a>
                </div>
                <br>
                <%}%>
            </div>
            <br>
            <%
                } catch (Exception e) {
                    out.print("<br><div class='container boxedTitle midLightToMidDark centered' style='color:white;'>"
                            + "<br><h1>No Items in Stock<br>Please Check Back Soon!</h1><br></div>");
                }
            %>
            <br>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
