<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Map" %>
<%@ include file = "header.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shopping Cart</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h2>Your Shopping Cart</h2>

<script>
	function update(newid,newqty)
	{
		window.location="showcart.jsp?update="+newid+"&newqty="+newqty;
	}
</script>
<form name="cartqty">
<%
// Get the current list of products
@SuppressWarnings({"unchecked"})
HashMap<String, ArrayList<Object>> productList = (HashMap<String, ArrayList<Object>>) session.getAttribute("productList");

String deleteId = request.getParameter("delete");
if(deleteId != null){
	productList.remove(deleteId);
}

String updateQuan = request.getParameter("newqty");
String updateId = request.getParameter("update");

if(updateId != null && updateQuan != null) {
	productList.get(updateId).set(3, Integer.parseInt(updateQuan)); 
}

if (productList == null)
{	out.println("<H1>Your shopping cart is empty!</H1>");
	productList = new HashMap<String, ArrayList<Object>>();
}
else
{
	NumberFormat currFormat = NumberFormat.getCurrencyInstance();

	out.print("<table class=\"table1\"><tr><th>Product Id</th><th>Product Name</th><th>Quantity</th><th>Price</th><th>Subtotal</th><th></th></tr>");
	double total =0;

	Iterator<Map.Entry<String, ArrayList<Object>>> iterator = productList.entrySet().iterator();

	while (iterator.hasNext()) 
	{	Map.Entry<String, ArrayList<Object>> entry = iterator.next();
		ArrayList<Object> product = (ArrayList<Object>) entry.getValue();
		if (product.size() < 4)
		{
			out.println("Expected product with four entries. Got: "+product);
			continue;
		}
		String x = "<a href=showcart.jsp?delete=" +product.get(0)+ ">Remove From Cart</a>";

		out.print("<tr><td>"+product.get(0)+"</td>");
		out.print("<td>"+product.get(1)+"</td>");

		String y = "<input type = \"text\" name = \"newqty" + product.get(0) + "\" size = \"3\" value = " + product.get(3) + ">";

		String z = "<input type = \"button\" onclick = \"update(" +product.get(0)+ ", document.cartqty.newqty" + product.get(0) + ".value)\" value=\"Update Quantity\">";

		out.print("<td align = \"center\">" + y + "</td>"); // display quantity

		Object price = product.get(2);
		Object itemqty = product.get(3);

		double pr = 0;
		int qty = 0;
		
		try
		{
			pr = Double.parseDouble(price.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid price for product: "+product.get(0)+" price: "+price);
		}
		try
		{
			qty = Integer.parseInt(itemqty.toString());
		}
		catch (Exception e)
		{
			out.println("Invalid quantity for product: "+product.get(0)+" quantity: "+qty);
		}		
		
		out.print("<td align=\"right\">"+currFormat.format(pr)+"</td>");
		out.print("<td align=\"right\">"+currFormat.format(pr*qty)+"</td>");
		out.print("<td>"+x+"</td>");
		out.print("<td>" + z + "</td>");		
		out.println("</tr>");
		out.println("</tr>");
		total = total +pr*qty;
	}
	out.println("<tr><td colspan=\"4\" align=\"right\"><b>Order Total</b></td>"
			+"<td align=\"right\">"+currFormat.format(total)+"</td></tr>");

	out.println("</table>");

	out.println("<br><a href=\"checkout.jsp\" class=\"button1\">Check Out</a>");
}
%>
<a href="listprod.jsp" class="button1">Continue Shopping</a>
</form>
</html> 