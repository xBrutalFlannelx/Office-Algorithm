<%-- 
    Document   : adminPass
    Created on : Jul 21, 2021, 1:39:18 PM
    Author     : Zach
    Update pending admin password and status in DB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Password</title>
    </head>
    <body>    
        <div class="bg">
            <%                
                String username = request.getParameter("username");
                String newPass = request.getParameter("newPass");

                DBConnect dbConnect = new DBConnect();

                String message = dbConnect.updateDB("update office_algorithm.admin set password = '"
                        + newPass + "', status = 'Approved' where username = '"
                        + username + "'");
                //if password and status update is successful, send username and updated
                //password in a hidden field to loginAction.jsp, so new credentials login automatically
                //body onload auto redirects
                if (message.equals("Update Successful")) {
            %>
            <form name='adminLogin' action='loginAction.jsp' method='post'>
                <input type="hidden" id="username" name="username" value="<%=username%>">
                <input type="hidden" id="password" name="password" value="<%=newPass%>">
            </form>
            <body onload="document.adminLogin.submit()">
                <%
                    } else {
                        response.sendRedirect("login.jsp?error=password");
                    }
                %>
                <%@include file="footer.jsp" %>
        </div>
    </body>
</html>

