<!DOCTYPE html>
<html lang="en">
<head>
    <title>NOT-SO-SAFEWAY</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Please Login to System</h1>	

<%
// Print prior error login message if present
if (session.getAttribute("loginMessage") != null)
	out.println("<p>"+session.getAttribute("loginMessage").toString()+"</p>");
%>

<form name="MyForm" method=post action="validateLogin.jsp">
	<br>
	<table style="display:inline">
		<tr>
			<td><input type="text" name="username" size=20 maxlength=20 placeholder="Username" required></td>
		</tr>
		<tr>
			<td><input type="password" name="password" size=20 maxlength="20" placeholder="Password" required></td>
		</tr>
	</table>
	<br>
	<br>
	<input type="submit" name="Submit2" value="Log In">
</form>

</html>