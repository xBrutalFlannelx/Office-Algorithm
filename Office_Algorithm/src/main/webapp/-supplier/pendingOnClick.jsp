<%-- 
    Document   : pendingOnClick
    Created on : Jun 30, 2021, 2:13:24 PM
    Author     : Zach
update status of pending supplier in DB after querySupplier.jsp submission
deny deletes account from DB
confirmation page displayed before update
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" import="myBeans.DBConnect, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="../adminCSS.css"/>
        <%@include file="../header.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Confirmation</title>
    </head>
    <body>
        <div class="bg">
            <br>
            <%                
                DBConnect dbConnect = new DBConnect();
                String supplierID = request.getParameter("supplierID");
                String name = request.getParameter("name");
                String status = request.getParameter("status");
            %>
            <br>
            <div class='container boxedTitle lightToDarkBottom' style='color:white'><br><h1><%=status%></h1><br><h2><%=name%>?</h2><br></div>
            <div class='container boxedWhite centered'>
                <br> 
                <br>
                <form name='confirmStatus' action='pendingOnClick.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="supplierID" name="supplierID" value="<%=supplierID%>">
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <input type="hidden" id="status" name="status" value="<%="confirm" + status%>">
                    <button type='btnSubmit' class='button submitButton'>Proceed</button> 
                </form>
                <form name='cancel' action='querySupplier.jsp' style='display: inline-block' method='post'>
                    <input type="hidden" id="name" name="name" value="<%=name%>">
                    <button type='btnSubmit' class='button submitButton'>Cancel</button> 
                </form>
                <br>
                <br>
                <%
                    ResultSet updateStock = dbConnect.DBQuery("Select stockID from office_algorithm.supplierstock where supplierID = '"
                            + supplierID + "'");
                    // if approve is confirmed
                    if (status.equals("confirmApprove")) {

                        while (updateStock.next()) {

                            String approveStock = dbConnect.updateDB("update office_algorithm.stock set status = 'Approved' where stockID = '"
                                    + updateStock.getString(1) + "'");
                            if (!approveStock.equals("Update Successful")) {
                                out.print("<br><h2 class='centered'>Error: Please try again</h2></div>");
                                return;
                            }
                        }

                        String approveSupplier = dbConnect.updateDB("update office_algorithm.supplier set status = 'Approved' where supplierID = '"
                                + supplierID + "'");
                        if (approveSupplier.equals("Update Successful")) {

                            String approved = "Success: " + name + " Approved";
                %>
                <form id='approveSuccess' name='approveSuccess' action='pendingSupplier.jsp' method='post'>
                    <input type="hidden" id="message" name="message" value="<%=approved%>">
                </form>
                <script>
                    document.getElementById('approveSuccess').submit();
                </script> 
                <%
                        }
                    }
                    //if deny is confirmed
                    if (status.equals("confirmDeny")) {

                        String denyStock = dbConnect.updateDB("delete from office_algorithm.supplierstock where supplierID = '"
                                + supplierID + "'");
                        String denySupplier = dbConnect.updateDB("delete from office_algorithm.supplier where supplierID = '"
                                + supplierID + "'");

                        while (updateStock.next()) {

                            String deleteStock = dbConnect.updateDB("delete from office_algorithm.stock where stockID = '"
                                    + updateStock.getString(1) + "'");
                            if (!deleteStock.equals("Update Successful")) {
                                out.print("<br><h2 class='centered'>Error: Please try again</h2></div>");
                                return;
                            }
                        }

                        if (denyStock.equals("Update Successful") && denySupplier.equals("Update Successful")) {

                            String denied = "Success: " + name + " Denied";
                %>
                <form id='denySuccess' name='approveSuccess' action='pendingSupplier.jsp' method='post'>
                    <input type="hidden" id="message" name="message" value="<%=denied%>">
                </form>
                <script>
                    document.getElementById('denySuccess').submit();
                </script> 
                <%}
                    }%>
                <br>
            </div>
            <%@include file="../footer.jsp" %>
        </div>
    </body>
</html>