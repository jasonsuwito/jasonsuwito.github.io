<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Update Address</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Update Address</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="updateAccount.jsp">Update your Account</a>/<a href="updateAddress.jsp">Update Address</a>
<br><br>

<form name="MyForm" method=post action="validateUpdateAcc.jsp">
    <table style="display:inline;text-align:right;">
        <tr>
            <td>New Address:</td>
            <td><input type="text" name="newAddress" size=40 maxlength=50 required></td>
        </tr>
        <tr>
            <td>Enter password to confirm:</td>
            <td><input type="password" name="password" size=40 maxlength="30" required></td>
        </tr>
    </table>
    <br><br>
    <input class="submit" type="submit" name="Submit2" value="Update Address">
</form>
</html> 