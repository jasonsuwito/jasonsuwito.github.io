<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Ship</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Shipment</h1>

<%
	// TODO: Get order id

	// String sql = "SELECT ;";
	// stmt.execute(sql);
          
	// TODO: Check if valid order id
	
	// TODO: Start a transaction (turn-off auto-commit)
	// con.setAutoCommit(false);
	
	// TODO: Retrieve all items in order with given id
	// TODO: Create a new shipment record.
	// TODO: For each item verify sufficient quantity available in warehouse 1.
	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
	
	// TODO: Auto-commit should be turned back on
	// con.setAutoCommit(true);

	String sql = "";

	try {
		getConnection();
		con.setAutoCommit(false);

		Statement stmt = con.createStatement();
		stmt.execute("USE orders");
		
		String oid = request.getParameter("orderId");

		sql = "SELECT orderId, productid, quantity FROM orderproduct WHERE orderid = ?";
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1, oid);
		ResultSet rst = pstmt.executeQuery();

		if(!rst.next()) {
			out.print("<h3>Order ID Does Not Exist</h3>");
		}
		Boolean shipSuccess = true;
		out.print("<h3>Shipment information for Order ID: " + request.getParameter("orderId") + "</h3>");
		do {
			String sql2 = "SELECT quantity FROM productinventory WHERE productId = " + rst.getString(2);
			PreparedStatement pstmt2 = con.prepareStatement(sql2);
			ResultSet rst2 = pstmt2.executeQuery();
			rst2.next();

			String sql3 = "UPDATE productinventory SET quantity = quantity-" + rst.getString(3) + " WHERE productId=" + rst.getString(2) + " AND warehouseId = 1";
			PreparedStatement pstmt3 = con.prepareStatement(sql3);
			
			try {
				pstmt3.executeUpdate();
				String sql4 = "SELECT quantity, productId FROM productinventory WHERE productId = " + rst.getString(2);
				PreparedStatement pstmt4 = con.prepareStatement(sql4);
				ResultSet rst4 = pstmt4.executeQuery();
				rst4.next();
				if(rst4.getInt(1) < 0) {
					out.print("<br>Insufficient Inventory for Product ID: " + rst4.getInt(2) + "<br><br>");
					shipSuccess = false;
					con.rollback();
				} else if (rst4.getInt(1) >= 0) {
					out.print("<br>Ordered Product: " + rst.getInt(2) + " Quantity: " + rst.getInt(3) + " Previous Inventory: " + rst2.getInt(1) + " New Inventory: " + rst4.getInt(1) + "<br><br>");
					shipSuccess = true;
					con.commit();
				}
			} catch (SQLException ex2) {
				//out.print(ex2);
			}
		} while(rst.next());

		if(shipSuccess == true) {
			out.print("<h2>Shipment successfully processed!</h2>");
		} else {
			out.print("<h2>Shipment is not processed!</h2>");
		}

		con.setAutoCommit(true);

		//if not enough inventory call con.rollback();
		//if everything is succesfull con.commit();
		//then turn it back on

	} catch (SQLException ex) {
		//out.println(ex);
	} finally {
		closeConnection();
	}
%>

</html>