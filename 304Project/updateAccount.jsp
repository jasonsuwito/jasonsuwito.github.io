<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Accounts Page</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1 class="nav">Update your Current Information Here</h1>
<a href="index.jsp">Home</a>/<a href="accountPage.jsp">Accounts</a>/<a href="updateAccount.jsp">Update your Account</a>
<br><br>

<a href="updateAddress.jsp" class="button1">Update Address</a>
<a href="changePassword.jsp" class="button1">Change Password</a>
<a href="accountPage.jsp" class="button1">← Back &ensp;&nbsp;</a>

<%@ include file = "footer.jsp" %>
</html> 