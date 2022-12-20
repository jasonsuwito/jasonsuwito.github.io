<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>NOT-SO-SAFEWAY</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<%
// Get product name to search for
// TODO: Retrieve and display info for the product

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

String pid = request.getParameter("id");
String sql = "SELECT productImageURL from product WHERE productId = ?";
String sql2 = "SELECT productName, productId from product WHERE productId = ?";
String sql3 = "SELECT productDesc, productPrice from product WHERE productId = ?";
String prodImgUrl = "";
String prodImgUrl2 = "";

try {
    getConnection();
    Statement stmt = con.createStatement();
    stmt.execute("USE orders");
    PreparedStatement pstmt = con.prepareStatement(sql);
    PreparedStatement pstmt2 = con.prepareStatement(sql2);
    PreparedStatement pstmt3 = con.prepareStatement(sql3);
    
    pstmt.setString(1, pid);
    pstmt2.setString(1, pid);
    pstmt3.setString(1, pid);

    ResultSet rst = pstmt.executeQuery();
    ResultSet rst2 = pstmt2.executeQuery();
    ResultSet rst3 = pstmt3.executeQuery();

    rst.next();
    rst2.next();
    rst3.next();

    out.println("<h2>" + rst2.getString(1) + "</h2>");
    out.println("<p class=\"description\">" + rst3.getString(1) + "</p>");
    out.println("<h4>" + currFormat.format(rst3.getDouble(2)) + "</h4>");
    if (rst.getString(1) != null) {
        prodImgUrl = rst.getString(1);
        out.print("<img src =" + prodImgUrl + " height=\"400\">");

    } else if (rst.getString(1) == null) {
        out.println("<h4>No product image</h4>");
    }
    String pname = rst2.getString(1);
		pname = pname.replace(' ','+');
        String x = "<a class=\"button1\" href=addcart.jsp?id=" +rst2.getInt(2)+ "&name=" +pname+ "&price=" +rst2.getDouble(2)+ ">Add to Cart</a>";
        out.println("<h3>"+x+"</h3>");
        String y = "<a class=\"button1\" href=listprod.jsp>Continue Shopping</a>";
        out.print("<h3>"+y+"</h3>");
} catch (SQLException ex) {
    out.println(ex);
} finally {
    closeConnection();
}
		
// TODO: Retrieve any image stored directly in database. Note: Call displayImage.jsp with product id as parameter.
%>
</html>