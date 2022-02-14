<%-- 
    Document   : approvedSupplier
    Created on : Jun 29, 2021, 2:11:23 PM
    Author     : Zach
list company names as hyperlinks of all approved suppliers
clicking on a name leads to querySupplier.jsp to manage/order stock
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Approved Suppliers</title>
    </head>
    <body>
        <div class="bg">
            <%            
                DBConnect dbConnect = new DBConnect();
                String approvedQuery = "Select Name FROM office_algorithm.supplier where Status = 'Approved'";
                ResultSet approved = dbConnect.DBQuery(approvedQuery);

                if (!approved.next()) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>No Approved Accounts</h1><br></div><br>");

                } else {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Approved Supplier Accounts</h1><br></div><br>");
                    approved.beforeFirst();
            %>
            <div class="container boxedWhite" align="center">
                <%while (approved.next()) {%> 
                <br>
                <a id="temp" style="font-size: 25px" href=""><%= approved.getString(1)%></a> 
                <script>
                    var name = "<%= approved.getString(1)%>";
                    document.getElementById("temp").setAttribute('id', name);
                    document.getElementById(name).setAttribute('href', 'querySupplier.jsp?name=' + name);
                </script>
                <br>
                <%}%>
                <br>
            </div>
            <%}%>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
