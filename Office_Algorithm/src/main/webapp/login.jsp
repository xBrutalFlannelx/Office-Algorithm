<%-- 
    Document   : login
    Created on : Jul 7, 2021, 4:55:25 PM
    Author     : Zach
input fields to submit to loginAction.jsp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="adminCSS.css"/>
        <%@include file="header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <div class="bg">
            <br><br><br>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1>Login</h1><br></div>   
            <div class="container boxedWhite">

                <form name='login' action='loginAction.jsp' method='post'>
                    <div class="creation centered">
                        <br><br>   
                        <%  //login messages
                            String validate = request.getParameter("error");
                            //null pointer catch for next line
                            if (validate == null) {
                                validate = "";
                            }//login invalid
                            else if (validate.equals("invalid")) {
                                out.print("<h3>Invalid username or password:<br>Please try again</h3><br><br>");
                            }//pending admin update password error
                            else if (validate.equals("password")) {
                                out.print("<h3>Error updating password: Please try again</h3><br><br>");
                            }//customer account created
                            else if (validate.equals("success")) {
                                out.print("<h3>Success: Please login below</h3><br><br>");
                            } //pending supplier awaiting approval
                            else if (validate.equals("pending")) {
                                out.print("<h3>Pending Supplier Account:<br><br>Please await Admin Approval</h3><br><br>");
                            }
                              //message sent after supplier creation 
                            else {
                                out.print(validate);
                            }
                        %>
                        <p>
                            <label class='inputLabel'>Username:</label>
                            <input class='form-control center-input' id='username' name='username' type="text" maxlength="30" placeholder="Enter Username"required>
                        </p>

                        <p>
                            <label class='inputLabel'>Password:</label>
                            <input class='form-control center-input' id='password' name='password' type="password" maxlength="30" placeholder="Enter Password"required>
                        </p>
                    </div>
                    <div class='container centered'>
                        <button type='btnSubmit' class='button submitButton'>Submit</button>
                        <button type='reset' class='button resetButton'>Reset</button> 
                    </div>
                </form>
                <br>
                <a style="font-size: 20px" href="register.jsp">Need to create an account? Click here</a>
                <br><br>
            </div>
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>
