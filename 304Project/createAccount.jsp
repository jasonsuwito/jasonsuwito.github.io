<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<title>Create Account Page</title>
	<link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Create a New Account</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="createAccount.jsp">Create Account</a>
<br><br>

<form method=post action="created.jsp">
	<table style="display:inline;border-spacing: 2px 15px;">
		<tr>
			<td style="text-align:right">Username:</td>
			<td><input type="text" name="uname" size=25 maxlength=20 required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Password:</td>
			<td><input type="password" name="pass" size=25 maxlength="30" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">First Name:</td>
			<td><input type="text" name="fName" size=25 maxlength="40" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Last Name:</td>
			<td><input type="text" name="lName" size=25 maxlength="40" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Email:</td>
			<td><input type="email" name="email" size=25 maxlength="50" pattern=".+@+.+\.+[A-Za-z]*" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Phone Number:</td>
			<td><input type="tel" name="pnum" size=25 maxlength="12" pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" title="123-456-7890" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Street Address:</td>
			<td><input type="text" name="address" size=25 maxlength="20" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">City:</td>
			<td><input type="text" name="city" size=25 maxlength="20" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">State/Province:</td>
			<td><input type="text" name="state" size=25 maxlength="20" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Postal Code:</td>
			<td><input type="text" name="pcode" size=25 maxlength="20" required><span></span></td>
		</tr>
		<tr>
			<td style="text-align:right">Country:</td>
			<td><input type="text" name="country" size=25 maxlength="40" required><span></span></td>
		</tr>
	</table>
<br>
	<input type="submit" value="Create Account">
<br><br><br>
</form>
</html>