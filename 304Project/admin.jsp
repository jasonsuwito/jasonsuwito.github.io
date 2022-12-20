<%@ include file="auth.jsp"%>
<%@ include file="jdbc.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Administrator Page</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Welcome to the Administrator Page</h1>
<a href="index.jsp">Home</a>/<a href="admin.jsp">Administrator</a>
<br><br>

<a href="loaddata.jsp" class="button1">Reload Database</a>
<a href="index.jsp" class="button1">← Back &ensp;&nbsp;</a>

<%
// TODO: Write SQL query that prints out total order amount by day
String sql = "SELECT CAST(orderDate AS DATE), SUM(totalAmount) FROM ordersummary GROUP BY CAST(orderDate AS DATE)";
String sql1 = "SELECT sum(totalAmount) FROM ordersummary";
String sql2 = "SELECT firstName+' '+lastName, email, phonenum FROM customer";
String sql3 = "SELECT productName, SUM(orderproduct.quantity) AS qsold FROM orderproduct JOIN product ON orderproduct.productId = product.productId GROUP BY productName ORDER BY qsold DESC";
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.US);

try {
    getConnection();
    Statement stmt = con.createStatement();
    stmt.execute("USE orders");
    PreparedStatement pstmt = con.prepareStatement(sql);
    PreparedStatement pstmt1 = con.prepareStatement(sql1); 
    PreparedStatement pstmt2 = con.prepareStatement(sql2); 
    PreparedStatement pstmt3 = con.prepareStatement(sql3); 

    ResultSet rst = pstmt.executeQuery();
    ResultSet rst1 = pstmt1.executeQuery();
    ResultSet rst2 = pstmt2.executeQuery();
    ResultSet rst3 = pstmt3.executeQuery();
   
    out.println("<h2>Administrator Sales Report by Day</h2>");
    out.print("<table class=table2 border=1>");
    out.print("<tr><th>Order Date</th><th>Total Order Amount</th></tr>");
	while(rst.next()){
		out.print("<tr><td>"+rst.getDate(1)+"</td><td>"+currFormat.format(rst.getDouble(2))+"</td></tr>");
	}
    while(rst1.next()){
        out.print("<tr><td>"+"TOTAL: "+"</td><td>"+currFormat.format(rst1.getDouble(1))+"</td></tr>");
    }
    out.print("</table>");

    out.println("<h2>Customer List</h2>");
    out.print("<table class=table2 border=1>");
    out.print("<tr><th>Name</th><th>Email</th><th>Phone Number</th></tr>");
	while(rst2.next()){
		out.print("<tr><td>"+rst2.getString(1)+"</td><td>"+rst2.getString(2)+"</td><td>"+rst2.getString(3)+"</td></tr>");
	}
    out.print("</table>");

    out.println("<h2>Top 5 Products</h2>");
   
    out.print("<table id=top5Prod class=table2 border=1>");
    out.print("<tr><th>Product Name</th><th>Quantity Sold</th></tr>");
	int rst3count = 0;
    rst3.next();
    while(rst3count < 5){
		out.print("<tr><td>"+rst3.getString(1)+"</td><td>"+rst3.getString(2)+"</td></tr>");
        rst3count++;
        rst3.next();
	}
    out.print("</table>");
    out.println("<br>");
    out.println("<div id = \"top5ProdGraph\" class=table2></div>");

} catch (SQLException ex) {
    out.println(ex);
} finally {
    closeConnection();
}
%>

<script src = "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src = "https://code.highcharts.com/highcharts.js"></script> 
<script src = "https://code.highcharts.com/modules/data.js"></script>

<br>

<script language = "JavaScript">
    $(document).ready(function() {
        var data = {
            table: 'top5Prod'
        };
        var chart = {
            type: 'column'
        };
        var title = {
            text: ''
        };      
        var yAxis = {
            allowDecimals: false,
            title: {
            text: 'Quantity Sold'
            }
        };
        var tooltip = {
            formatter: function () {
            return '<b>' + this.series.name + '</b><br/>' +
                this.point.y + ' - ' + this.point.name.toUpperCase();
            }
        };
        var credits = {
            enabled: false
        };  
        var json = {};   
        json.chart = chart; 
        json.title = title;
        json.data = data;
        json.yAxis = yAxis;
        json.credits = credits;  
        json.tooltip = tooltip;  
        $('#top5ProdGraph').highcharts(json);
    });
</script>

</html>