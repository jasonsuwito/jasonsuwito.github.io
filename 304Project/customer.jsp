<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>NOT-SO-SAFEWAY</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<%
	String userName = (String)session.getAttribute("authenticatedUser");
	String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE userid = ?";

	try {
		getConnection();
		Statement stmt = con.createStatement();
		stmt.execute("USE orders");
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, userName);
		ResultSet rst = pstmt.executeQuery();
		
		if(rst.next()){
			out.println("<h1>Customer Profile</h1>");
			out.print("<table border=1 align=center>");
			out.print("<tr><th>Customer Id</th><td>" + rst.getString(1)+ "</td></tr>");
			out.print("<tr><th>First Name</th><td>"+rst.getString(2)+"</td></tr>");
			out.print("<tr><th>Last Name</th><td>"+rst.getString(3)+"</td></tr>");
			out.print("<tr><th>Email</th><td>"+rst.getString(4)+"</td></tr>");
			out.print("<tr><th>Phone</th><td>"+rst.getString(5)+"</td></tr>");
			out.print("<tr><th>Address</th><td>"+rst.getString(6)+"</td></tr>");
			out.print("<tr><th>City</th><td>"+rst.getString(7)+"</td></tr>");
			out.print("<tr><th>State/Province</th><td>"+rst.getString(8)+"</td></tr>");
			out.print("<tr><th>Postal Code</th><td>"+rst.getString(9)+"</td></tr>");
			out.print("<tr><th>Country</th><td>"+rst.getString(10)+"</td></tr>");
			out.print("<tr><th>Username</th><td>"+rst.getString(11)+"</td></tr>");
			out.print("</table>");
		} else {
			out.print("Data does not exist.");
		}
	} catch (SQLException ex) {
		out.println(ex);
	} finally {
		closeConnection();
	}
%>
</html>