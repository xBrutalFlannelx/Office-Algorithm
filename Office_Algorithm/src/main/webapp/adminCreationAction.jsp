<%-- 
    Document   : adminCreationAction
    Created on : Jul 1, 2021, 7:50:19 PM
    Author     : Zach
receive form from adminCreation.jsp, 
check for duplicate username/email
insert pending admin in DB
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create new admin</title>
    </head>
    <body>
        <div class="bg">
            <h1>Create new admin</h1>
            <%                
                String email = request.getParameter("email");
                String username = request.getParameter("username");
                String password = request.getParameter("password");

                DBConnect dbConnect = new DBConnect();

                String sql = "INSERT into office_algorithm.admin (email, username, password, status) values ('"
                        + email + "', '" + username + "', '" + password + "', 'Pending')";

                String duplicate = "Select adminID FROM office_algorithm.admin where Username = '"
                        + username + "' or email = '" + email + "'";

                ResultSet existingAccount = dbConnect.DBQuery(duplicate);

                if (existingAccount.next()) {
                    response.sendRedirect("adminCreation.jsp?error=error");
                } //insert into admin table if account info doesn't match current DB
                else {
                    String message = dbConnect.updateDB(sql);
                    if (message.equals("Update Successful")) {
                        response.sendRedirect("adminCreation.jsp?error=success&email=" + email);
                    }
                }
            %>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
