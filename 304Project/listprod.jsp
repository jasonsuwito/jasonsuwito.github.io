<%@ page import="java.sql.*,java.net.URLEncoder" %>
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

<h1>Shop</h1>
<h4>Search for the Product Name or Category you want to buy: </h4>
<form method="get" action="listprod.jsp">
	<select size="1" name="categoryName">
		<option value="">All</option>
		<option>Keycaps</option>
		<option>Prebuilt Keyboards</option>
		<option>Switches</option>
		<option>Keycap Puller</option>
		<option>Foam</option>
		<option>Lube</option>
	</select>
<input type="text" name="productName" size="40" placeholder="Search">
<input type="submit" value="Submit"><button type="submit" value="">Reset</button>
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
		
//Note: Forces loading of SQL Server driver
try
{	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e)
{
	out.println("ClassNotFoundException: " +e);
}

// Variable name now contains the search string the user entered
// Use it to build a query and print out the resultset.  Make sure to use PreparedStatement!

// Make the connection

// Print out the ResultSet

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
// Close connection

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00

String sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try {
	getConnection();
	Statement stmt = con.createStatement();
	stmt.execute("USE orders");
	PreparedStatement pstmt = con.prepareStatement(sql);

	String cat = "";
	cat = request.getParameter("categoryName");
	
	if(name != null && name.length()>0 && cat != "" && cat != null){
		sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE product.productName LIKE ? AND category.categoryName = ?";
		pstmt = con.prepareStatement(sql);
		String ans = '%'+name+'%';
		pstmt.setString(1, ans);
		pstmt.setString(2, request.getParameter("categoryName"));
	} else if (cat != "" && cat != null) {
		sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE category.categoryName = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("categoryName"));
	} else if (name != null && name.length()>0 && (cat == "" || cat == null)) {
		sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId WHERE product.productName LIKE ?";
		pstmt = con.prepareStatement(sql);
		String ans = '%'+name+'%';
		pstmt.setString(1, ans);
	} else {
		//sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId";
		//sql = "Select product.productId, product.productName, product.productPrice, product.categoryId, category.categoryName FROM product JOIN category ON product.categoryId = category.categoryId JOIN productInventory ON category.categoryId = productInventory.categoryId JOIN orderproduct ON productInventory.productId=orderproduct.productId  GROUP BY product.productId,product.productName,productPrice,product.categoryId,category.categoryName,orderproduct.quantity Order by orderproduct.quantity desc";
		
		pstmt = con.prepareStatement(sql);

	}

	ResultSet rst = pstmt.executeQuery();

		if(!rst.next()) {
			out.print("<h3>Sorry, product does not exist in selected category. Please try again!</h3>");
		} else {
			out.print("<table class=\"table1\"><tr class=\"left\"><th></th><th>Product Name</th><th>Category</th><th>Price</th></tr> ");
			do{
				String pname = rst.getString(2);
				int pid = rst.getInt(1);
				pname = pname.replace(' ','+');
				String x = "<a class=\"button2\" href=addcart.jsp?id=" +rst.getInt(1)+ "&name=" +pname+ "&price=" +rst.getDouble(3)+ ">Add to Cart</a>";
				String y = "<a href=product.jsp?id=" +pid+ ">" +rst.getString(2)+ "</a>";
				String z = rst.getString(5);
				out.print("<tr><td> "+ x +" </td>");
				out.print("<td>"+ y +"</td>");
				out.print("<td>"+ z +"</td>");
				out.print("<td>"+currFormat.format(rst.getDouble(3))+"</td>");
				out.print("</tr>");
			}while(rst.next());
		}
 		
} catch (SQLException ex) {
	out.println(ex);
} finally {
	closeConnection();
}
%>

</html>