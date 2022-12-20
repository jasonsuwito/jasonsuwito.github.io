<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ include file = "jdbc.jsp" %>
<%@ include file = "header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>NOT-SO-SAFEWAY</title>
	<link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Order List</h1>

<%
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection

// Write query to retrieve all order summary records

// For each order in the ResultSet

	// Print out the order summary information
	// Write a query to retrieve the products in the order
	//   - Use a PreparedStatement as will repeat this query many times
	// For each product in the order
		// Write out product information 

// Close connection

// ---------------------------------

String sql = "SELECT orderId, O.orderDate, O.customerId, firstName+' '+lastName, totalAmount FROM ordersummary AS O JOIN customer AS C ON O.customerId = C.customerId";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try {
	getConnection();
	Statement stmt = con.createStatement();
	stmt.execute("USE orders");

	ResultSet rst = stmt.executeQuery(sql);
	out.print("<table style =\"width:100%;max-width:900px;margin:auto;color:black;background-color:white\" border = 5px ><tr><th>Order ID</th><th>Order Date and Time</th><th>Customer ID</th><th>Customer Name</th><th>Total Amount</th></tr> ");
	sql = "SELECT productId, quantity, price FROM orderproduct WHERE orderId = ? order by quantity desc";
	PreparedStatement pstmt = con.prepareStatement(sql);
	String sql2 = "Select productId, quantity, price FROM orderproduct WHERE orderId = ? order by quantity desc";
	PreparedStatement pstmt2 = con.prepareStatement(sql2);

	while (rst.next()){
		int orderId = rst.getInt(1);
		out.print("<tr><td>"+orderId+"</td>");
		out.print("<td>"+rst.getString(2)+"</td>");
		out.print("<td>"+rst.getInt(3)+"</td>");
		out.print("<td>"+rst.getString(4)+"</td>");
		out.print("<td>"+currFormat.format(rst.getDouble(5))+"</td>");
		out.println("</tr>");

		
		//internals
		pstmt2.setInt(1, orderId);
		ResultSet rst2 = pstmt2.executeQuery();

		out.println("<tr align=\"right\"><td colspan=\"5\"><table style =\"width:100%;color:black;background-color:#abffc1\" border = 2px></td></tr>");
		out.println("<th>Product Id</th><th>Quantity</th><th>Price</th>");

		while(rst2.next()){
			int orderId2 = rst2.getInt(1);
			out.print("<tr style=\"text-align:center\"><td>"+orderId2+"</td>");
			out.print("<td>"+rst2.getInt(2)+"</td>");
			out.println("<td>"+currFormat.format((Double)rst2.getDouble(3))+"</td></tr>");
		}
		out.println("</table></td></tr>");
	}
	out.println("</table>");
	
} catch (SQLException ex) {
	out.println(ex);
} finally {
	closeConnection();
}
%>

</body>
</html>