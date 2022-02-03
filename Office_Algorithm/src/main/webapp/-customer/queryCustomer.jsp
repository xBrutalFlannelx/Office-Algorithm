<%-- 
    Document   : queryCustomer
    Created on : Jun 29, 2021, 2:14:56 PM
    Author     : Zach
    List all customer accounts for admin 
    on click customerOrder.jsp lists all orders for account
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customers</title>
    </head>
    <body>
        <div class="bg">
            <%                
                DBConnect dbConnect = new DBConnect();
                String customer = "Select customerID, firstname, lastname, email FROM customer";
                ResultSet rst = dbConnect.DBQuery(customer);

                if (!rst.next()) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>No Customers</h1><br></div>");
                } else {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Customers</h1><br></div>");
                }
            %>
            <br>
            <div class="container boxedWhite" align="center">
                <table border="0">

                    <%
                        rst.beforeFirst();
                        while (rst.next()) {
                    %>
                    <br>
                    <a id="temp" style="font-size: 25px" href=""><%="ID: " + rst.getString(1) + " - " + rst.getString(4) + " - " + rst.getString(2) + " " + rst.getString(3)%></a> 
                    <script>
                        var ID = "<%= rst.getString(1)%>";
                        document.getElementById("temp").setAttribute('id', ID);
                        document.getElementById(ID).setAttribute('href', 'customerOrder.jsp?customerID=' + ID);
                    </script>
                    <br>
                    <%}%>
                    <br>
                </table>
            </div>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>
