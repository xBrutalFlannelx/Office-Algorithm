<%-- 
    Document   : adminCreation
    Created on : Jun 29, 2021, 2:05:09 PM
    Author     : Zach
Display input fields for admin to create another admin account
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="/OfficeAlgorithm/adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <script src="../password.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Admin Account</title>
    </head>
    <body>
        <div class="bg">
            <%//print error message if email or username in use
                String error = request.getParameter("error");
                String email = request.getParameter("email");
                //catch null pointer exception
                if (error == null) {
                    error = "";
                }
                if (error.equals("error")) {
                    out.print("<br><h3 class='centered'>Email or Username taken: Please try again.</h3>");
                }
                if (error.equals("success"))
                    out.print("<br><h3 class='centered'>Success: Credentials forwarded to " + email + ".</h3>");
            %>
            <br>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'>
                <br><h1>Create Admin Account</h1><br>
            </div>
            <br>
            <div class="container boxedWhite centered">
                <br>
                <form name="createAdmin" action="adminCreationAction.jsp" method="post">
                    <table border="0">
                        <div class="creation">
                            <tr>
                            <label class='inputLabel'>Email:</label>
                            <input class='form-control center-input' type="email" name="email" maxlength="40" required/>
                            </tr>
                            <tr>
                            <label class='inputLabel'>Username:</label>
                            <input class='form-control center-input' type="text" name="username" maxlength="30" required/>
                            </tr>
                            <tr>
                            <label class='inputLabel'>Password:</label>
                            <input class='form-control center-input' type="password" name="password" id="newPass" maxlength="30" 
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                            </tr>
                            <tr>
                            <label class='inputLabel'>Confirm Password:</label>
                            <input class='form-control center-input' type="password" name="confirmPassword" id="confirmPass" maxlength="30"
                                   pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>
                            </tr>
                        </div>
                        <br>
                        <p id="valid"></p>
                    </table>
                    <tr>
                    <div class='container'>
                        <td><input type="submit" value="Submit" class='button submitButton' onclick="return Validate()"/></td>
                        <td><input type="reset" value="Reset" class='button resetButton'/></td>
                    </div>
                    </tr>
                </form>
                <br>
            </div>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>
<script>
    document.getElementById("newPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
    document.getElementById("confirmPass").title = "Minimum 8 characters \n 1 uppercase \n 1 lowercase \n 1 number";
</script>
