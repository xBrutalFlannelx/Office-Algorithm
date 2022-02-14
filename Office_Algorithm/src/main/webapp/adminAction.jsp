<%-- 
    Document   : adminAction
    Created on : Jun 29, 2021, 4:14:48 PM
    Author     : Zach
    Admin home page
List hyperlinks of all pages available to admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home</title>
    </head>
    <body>
        <div class="bg">
            <%                
                String username = (String) session.getAttribute("username");
                out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Welcome " + username + "</h1><br></div>");
            %>
            <br>
            <div class="container boxedWhite" align="center">
                <table border="0">
                    <br>
                    <a style="font-size: 25px" href="approvedSupplier.jsp">Approved Suppliers</a>
                    <br> <br>
                    <a  style="font-size: 25px" href="pendingSupplier.jsp">Pending Suppliers</a>
                    <br> <br>
                    <a style="font-size: 25px" href="queryCustomer.jsp">Customer Orders</a>
                    <br> <br>
                    <a style="font-size: 25px" href="adminCreation.jsp">Admin Creation</a>
                    <br> <br>
                </table>
            </div>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
