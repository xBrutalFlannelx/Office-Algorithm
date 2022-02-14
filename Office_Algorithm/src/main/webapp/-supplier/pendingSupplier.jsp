<%-- 
    Document   : pendingSupplier
    Created on : Jun 22, 2021, 3:53:52 PM
    Author     : Zach
list company names as hyperlinks of all pending suppliers
clicking on a name leads to querySupplier.jsp to view account info
with option to approve/deny account
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Suppliers</title>
    </head>
    <body>
        <div class="bg">
            <%                
                DBConnect dbConnect = new DBConnect();
                String message = request.getParameter("message");

                if (message != null) {
                    out.print("<h2 class='centered'><br>" + message + "</h2>");
                }
                //list hyperlinks of all pending supplier accounts
                ResultSet pending = dbConnect.DBQuery("Select Name FROM office_algorithm.supplier where Status = 'Pending'");

                if (!pending.next()) {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>No Pending Accounts</h1><br></div><br>");

                } else {
                    out.print("<br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Pending Supplier Accounts</h1><br></div><br>");
                    pending.beforeFirst();
            %>
            <div id="box" class="container boxedWhite" align="center">
                <%while (pending.next()) {%> 
                <br>
                <a id="temp" style="font-size: 25px" href=""><%= pending.getString(1)%></a> 
                <script>
                    var name = "<%= pending.getString(1)%>";
                    document.getElementById("temp").setAttribute('id', name);
                    document.getElementById(name).setAttribute('href', 'querySupplier.jsp?name=' + name);
                </script>
                <br>
                <%}%>
                <br>
            </div>
            <%}%>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>
