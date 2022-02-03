<%-- 
    Document   : logout
    Created on : July 6, 2021, 2:07:19 PM
    Author     : Zach
    Logout page that submits form to itself to confirm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log Out</title>
    </head>
    <body>
        <%            
            String confirm = request.getParameter("logout");

            if (confirm != null) {

                session.setAttribute("logged", null);
                session.setAttribute("username", null);
                session.setAttribute("sessionID", null);
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="bg">
            <br>
            <br><div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Proceed with log out?</h1><br></div>
            <div class='container boxedWhite centered'>
                <br>
                <br>
                <form action='logout.jsp' style='display: inline-block' method='post'>
                    <button type='submit' class='button submitButton'>Log Out</button>
                    <input type="hidden" id="logout" name="logout" value="logout">
                </form>
                <form action='index.jsp' style='display: inline-block' method='post'>
                    <button type='submit' class='button submitButton'>Cancel</button>
                </form>
                <br>
                <br>
                <br>
            </div> 
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>