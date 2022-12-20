<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Validate Password</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Change Password</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="updateAccount.jsp">Update your Account</a>/<a href="changePassword.jsp">Change Password</a>
<br><br>
<%
    String username = session.getAttribute("authenticatedUser").toString();
    if(username == null){
        response.sendRedirect("login.jsp");
    }else{
		String password = request.getParameter("password");
        String newPassword = request.getParameter("newPass");
		
		if(newPassword == null || password == null){
            %><p>New password or password is null</p>
            <a href="changePassword.jsp" class="button1">Try Again</a><%
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
                %><p>Incorrect current password</p>
                <a href="changePassword.jsp" class="button1">Try Again</a><%
                return;
            }

            String sql2 = "UPDATE customer set password = ? WHERE userid = ?";
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, newPassword);
            pstmt2.setString(2, username);
            pstmt2.executeUpdate();
            
            %><p>Your password has been updated!</p>
            <a href="index.jsp" class="button1">Return to Main Page</a><%
        }catch(Exception e){
            out.println(e.toString());
        }
    }
%>
</html> 