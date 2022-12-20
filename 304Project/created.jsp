<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Accounts Page</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Create a New Account</h1>

<%
String username = request.getParameter("uname");
String password = request.getParameter("pass");
String fname = request.getParameter("fName");
String lname = request.getParameter("lName");
String email = request.getParameter("email");
String pnum = request.getParameter("pnum");
String address = request.getParameter("address");
String city = request.getParameter("city");
String state = request.getParameter("state");
String pcode = request.getParameter("pcode");
String country = request.getParameter("country");

try{
    boolean canMake = true;
    getConnection();
    Statement stmt = con.createStatement();
	stmt.execute("USE orders");
    String checkUser = "SELECT userid FROM customer";
    PreparedStatement pstmt = con.prepareStatement(checkUser);
    ResultSet rst = pstmt.executeQuery();
    
    while(rst.next()){
        if(username.equals(rst.getString(1))){
            out.println("The username \"" + username +"\" already exists. Please try again.");
            canMake = false;
            %><a href="createAccount.jsp"  class="button1">Try again</a><%
        }
    }
    if(canMake == false){
        return;
    }

    String sql = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
	PreparedStatement pstmt2 = con.prepareStatement(sql);
    pstmt2.setString(1, fname);
    pstmt2.setString(2, lname);
    pstmt2.setString(3, email);
    pstmt2.setString(4, pnum);
    pstmt2.setString(5, address);
    pstmt2.setString(6, city);
    pstmt2.setString(7, state);
    pstmt2.setString(8, pcode);
    pstmt2.setString(9, country);
    pstmt2.setString(10, username);
    pstmt2.setString(11, password);
    pstmt2.executeUpdate();

    String sql2 = "SELECT * FROM customer WHERE userid = ?";
    PreparedStatement pstmt3 = con.prepareStatement(sql2);
    pstmt3.setString(1, username);
    ResultSet rst2 = pstmt3.executeQuery();
    %><h3>New account created successfully!</h3><%
    while(rst2.next()){
        out.print("<table class=table border=1 align=center>");
        out.print("<tr><th>Customer Id</th><td>" + rst2.getString(1)+ "</td></tr>");
        out.print("<tr><th>First Name</th><td>"+rst2.getString(2)+"</td></tr>");
        out.print("<tr><th>Last Name</th><td>"+rst2.getString(3)+"</td></tr>");
        out.print("<tr><th>Email</th><td>"+rst2.getString(4)+"</td></tr>");
        out.print("<tr><th>Phone</th><td>"+rst2.getString(5)+"</td></tr>");
        out.print("<tr><th>Address</th><td>"+rst2.getString(6)+"</td></tr>");
        out.print("<tr><th>City</th><td>"+rst2.getString(7)+"</td></tr>");
        out.print("<tr><th>State/Province</th><td>"+rst2.getString(8)+"</td></tr>");
        out.print("<tr><th>Postal Code</th><td>"+rst2.getString(9)+"</td></tr>");
        out.print("<tr><th>Country</th><td>"+rst2.getString(10)+"</td></tr>");
        out.print("<tr><th>Username</th><td>"+rst2.getString(11)+"</td></tr>");
        out.print("<tr><th>Password</th><td>"+rst2.getString(12)+"</td></tr>");
        out.print("</table>");
    }
    %><a href="index.jsp" class="button1">Return to Main Page</a><%
}catch(Exception e){
    out.println(e.toString());
}
%>
</html> 