<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Validate Update Account</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Update Address</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="updateAccount.jsp">Update your Account</a>/<a href="updateAddress.jsp">Update Address</a>
<br><br>
<%
    String username = session.getAttribute("authenticatedUser").toString();
    if(username == null){
        response.sendRedirect("login.jsp");
    }else{
		
		String password = request.getParameter("password");
        String newAddress = request.getParameter("newAddress");
		

		if(newAddress == null || password == null){
            out.println("Address or password is null");
            %>
            <a href="updateAddress.jsp" class="button1">Try Again</a>
            <%
				return;
        }
        try{
            boolean canDo = false;
            getConnection();
            Statement stmt = con.createStatement();
	        stmt.execute("USE orders");
            String passwordCheck = "SELECT password FROM customer where userid = ?";
            PreparedStatement pstmt = con.prepareStatement(passwordCheck);
            pstmt.setString(1, username);
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()){
                String passwordReal = rst.getString(1);
                if(passwordReal.equals(password)){
                    canDo = true;
                }
            }
            if(canDo == false){
                out.println("<p>Incorrect password</p>");
                %>
            <a href="updateAddress.jsp" class="button1">Try Again</a>
            <%
                return;
            }

            String sql2 = "UPDATE customer set address = ? WHERE userid = ?";
            //set address = newAddress and userid = username
            
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, newAddress);
            pstmt2.setString(2, username);
            pstmt2.executeUpdate();

            out.println("<p>Your address has been updated!</p>");
            %>
            <a href="index.jsp" class="button1">Return to Main Page</a>
            <%
        }catch(Exception e){
            out.println(e.toString());
        }
    }
%>

</html> 