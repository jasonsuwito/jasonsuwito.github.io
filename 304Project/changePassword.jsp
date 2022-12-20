<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Change Password</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Change Password</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="updateAccount.jsp">Update your Account</a>/<a href="changePassword.jsp">Change Password</a>
<br><br>

<form name="MyForm" method=post action="validatePassword.jsp">
    <table style="display:inline;text-align:right;">
        <tr>
            <td>Old password:</td>
            <td><input type="password" name="password" size=30 maxlength=30 required></td>
        </tr>
        <tr>
            <td>New Password:</td>
            <td><input type="password" name="newPass" size=30 maxlength="30" required></td>
        </tr>
    </table>
    <br>
    <br>
    <input class="submit" type="submit" name="Submit2" value="Update password">
</form>

</html> 