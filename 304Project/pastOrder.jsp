<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file = "jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Past Orders</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Your Past Orders</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="accountPage.jsp">Past Orders</a>
<br><br>

<a href="accountPage.jsp" class="button1">← Back &ensp;&nbsp;</a>

<%
try{
    NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);
    getConnection();
    int custID = -1;
    String username = session.getAttribute("authenticatedUser").toString();
    Statement stmt = con.createStatement();
    stmt.execute("USE orders");
    String customerCheck = "SELECT customerId FROM customer where userid = ?";
    PreparedStatement pstmt = con.prepareStatement(customerCheck);
    pstmt.setString(1, username);
    ResultSet rst = pstmt.executeQuery();
    while(rst.next()){
        custID = rst.getInt(1);
    }
    String sql = "SELECT * FROM ordersummary where customerId = ?";
    PreparedStatement pstmt2 = con.prepareStatement(sql);
    pstmt2.setInt(1, custID);
    rst = pstmt2.executeQuery();
    out.print("<table style =\"width:100%;max-width:900px;color:black;background-color:white;margin:auto\" border = 5px><tr><th>Order ID</th><th>Order Date and Time</th><th>Total Cost</th></tr> ");
    while(rst.next()){
        out.print("<tr><td>"+rst.getInt(1)+"</td>"); //
        out.print("<td>"+rst.getString(2)+"</td>"); //date
        out.print("<td>"+currFormat.format(rst.getDouble(3))+"</td>"); //total cost
        
        out.println("</tr>");
    }
}catch(Exception e){
    out.println(e);
}
%>

<%@ include file = "footer.jsp" %>
</html> 