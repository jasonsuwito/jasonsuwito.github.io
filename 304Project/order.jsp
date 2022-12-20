<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file = "jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Order Processing</title>
	<link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<% 
// Get customer id
String custId = request.getParameter("customerId");
String custPass = request.getParameter("customerPassword");
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

if (custId == null || custId.equals("")) // Determine if valid customer id was entered
	out.println("<h1>Invalid customer id or password. Go back to previous page and try again.</h1>");

else if (productList == null) // Determine if there are products in the shopping cart
	out.println("<h1>Your shopping cart is empty!</h1>");

else { // If either are not true, display an error message
	int num = -1;
	try {
		num = Integer.parseInt(custId);
	}
	catch(Exception e)
	{
		out.println("<h1>Invalid customer id or password. Go back to previous page and try again.</h1>");
		return;
	}

	String sql = "SELECT customerId, firstName+' '+lastName FROM Customer WHERE customerId = ? AND password = ?";

	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

	try {
		getConnection();
		Statement stmt = con.createStatement();
		stmt.execute("USE orders");
		PreparedStatement pstmt = con.prepareStatement(sql);

		pstmt.setInt(1, num);
		pstmt.setString(2, custPass);
		ResultSet rst = pstmt.executeQuery();
		int orderId = 0;
		String custName = "";

		if (!rst.next()) {
			out.println("<h1>Invalid customer id or password. Go back to previous page and try again.</h1>");
		} else {
			custName = rst.getString(2);
			sql = "INSERT INTO OrderSummary(customerId,orderDate) VALUES (?,?)";

			pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);	
			pstmt.setInt(1, num);
			pstmt.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
			pstmt.executeUpdate();
			ResultSet keys = pstmt.getGeneratedKeys();
			keys.next();
			orderId = keys.getInt(1);

			out.println("<h1>Your Order Summary</h1>");
			out.println("<table class=\"table1\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th></tr>");

			double total = 0;
			Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
			while (iterator.hasNext()) { 
				Map.Entry<String, ArrayList<Object>> entry = iterator.next();
				ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
				String productId = (String) product.get(0);
				out.print("<tr><td>"+productId+"</td>");
				out.print("<td>"+product.get(1)+"</td>");
				out.print("<td>"+product.get(3)+"</td>");
				String price = (String) product.get(2);
				double pr = Double.parseDouble(price);
				int qty = ((Integer)product.get(3)).intValue();
				out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
				out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
				out.println("</tr>");
				total = total + pr*qty;
				
				sql = "INSERT INTO OrderProduct (orderId, productId, quantity, price) VALUES (?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, orderId);
				pstmt.setInt(2, Integer.parseInt(productId));
				pstmt.setInt(3, qty);
				pstmt.setString(4, price);
				pstmt.executeUpdate();
			}
			out.println("<tr><td colspan=\"5\" align = \"right\"><b>Order Total: </b>"+currFormat.format(total)+"</td></tr>");
			out.println("</table>");

			sql = "UPDATE OrderSummary SET totalAmount = ? WHERE orderId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setDouble(1, total);
			pstmt.setInt(2, orderId);
			pstmt.executeUpdate();

			out.println("<h3>Order has been placed. Wil be shipped to: </h3>");
			out.println(request.getParameter("shippingName"));
			out.println("<br>"+request.getParameter("shippingAddress"));
			out.println("<br>"+request.getParameter("shippingPostal"));
			out.println("<br>"+request.getParameter("shippingCountry"));
			out.println("<h3>Your order reference number is:</h3>");
			out.println(orderId);
			out.println("<h3>Your payment using "+request.getParameter("paymentOption")+ " was successful!</h3>");
			out.println("<h3>Customer Information:</h3>");
			out.println("Customer: " +custId);
			out.println("<br>Name: " +custName);
					
			out.println("<a href=\"index.jsp\" class=\"button1\">Return to Home</a></h2>");

			//Clear cart
			session.setAttribute("productList", null);
		}
	}
	catch (SQLException ex) {
		out.println(ex);
	} finally {
		closeConnection();
	}
}




// Make connection

// Save order information to database


	/*
	// Use retrieval of auto-generated keys.
	PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);			
	ResultSet keys = pstmt.getGeneratedKeys();
	keys.next();
	int orderId = keys.getInt(1);
	*/

// Insert each item into OrderProduct table using OrderId from previous INSERT

// Update total amount for order record

// Here is the code to traverse through a HashMap
// Each entry in the HashMap is an ArrayList with item 0-id, 1-name, 2-quantity, 3-price

/*
	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();
	while (iterator.hasNext())
	{ 
		Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		String productId = (String) product.get(0);
        String price = (String) product.get(2);
		double pr = Double.parseDouble(price);
		int qty = ( (Integer)product.get(3)).intValue();
            ...
	}
*/

// Print out order summary

// Clear cart if order placed successfully

%>

</html>