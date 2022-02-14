<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>

<head>
    <link rel="stylesheet" href="adminCSS.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <script>
        function preventBack() {
            window.history.forward();
        }
        setTimeout("preventBack()", 0);
        window.onunload = function () {
            null
        };

    </script>    
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
    <div class="jumbotron-fluid midLightToMidDark text-light">
        <img src="logo.jpg" alt="Office Algorithm" style="width:125px; height:125x;"%>
        <h3 class='display-3' style="display: inline-block; vertical-align: bottom; font-size: 80px"> Office Algorithm</h3>
        <%
            String logged = (String) session.getAttribute("logged");
            String user = (String) session.getAttribute("username");
            //when logged in, show user type in top right of header
            if (logged != null)
                out.print("<div style='float: right; display: inline-block;'><h3>" + logged + "</h3></div>");
        %>
        <br>
    </div>


    <nav class="navbar navbar-expand-lg navbar-dark bg-darkest">
        <a id="home" class="navbar-brand" href="index.jsp">Home</a>
        <ul class="navbar-nav">
            <%
                // Login Check
                if (logged == null) {
                    out.print("<li class='nav-item'>"
                            + "<a class='nav-link' href='login.jsp'>Login</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='register.jsp'>  Register</a></li>");
                } else if (logged == "admin") {
                    // If logged in display new page options
                    out.print("<li class='nav-item'>"
                            + "<a class='nav-link' href='adminAction.jsp'>" + user + " Home</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='approvedSupplier.jsp'>Approved Suppliers</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='pendingSupplier.jsp'>Pending Suppliers</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='queryCustomer.jsp'>Customer Orders</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='adminCreation.jsp'>Admin Creation</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='logout.jsp'>Logout</a></li>");
                    //customer and supplier home currently redirect to index         
                } else if (logged == "customer") {

                    out.print("<li class='nav-item'>"
                            + "<a class='nav-link' href='index.jsp'>" + user + " Home</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='logout.jsp'>Logout</a></li>");

                } else if (logged == "supplier") {

                    out.print("<li class='nav-item'>"
                            + "<a class='nav-link' href='index.jsp'>" + user + " Home</a></li>"
                            + "<li class='nav-item'>"
                            + "<a class='nav-link' href='logout.jsp'>Logout</a></li>");

                }
            %>
        </ul>
    </nav>
</body>
