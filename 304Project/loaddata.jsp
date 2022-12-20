<%@ include file="auth.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Scanner" %>
<%@ page import="java.io.File" %>
<%@ include file="jdbc.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>NOT-SO-SAFEWAY</title>
    <link rel="stylesheet" type="text/css" href="css/mystyles.css" media="screen" />
</head>

<h1>Load Database</h1>
<a href="loaddata.jsp" class="button1">Reload</a>
<a href="index.jsp" class="button1">Return to Main Page</a>
<div class="left">
    <%
    out.print("<h3>Connecting to Database...</h3>");

    getConnection();
            
    String fileName = "/usr/local/tomcat/webapps/shop/ddl/orderdb_sql.ddl";

    try
    {
        // Create statement
        Statement stmt = con.createStatement();
        
        Scanner scanner = new Scanner(new File(fileName));
        // Read commands separated by ;
        scanner.useDelimiter(";");
        while (scanner.hasNext())
        {
            String command = scanner.next();
            if (command.trim().equals("") || command.trim().equals("go"))
                continue;
            out.print(command+"<br>");        // Uncomment if want to see commands executed
            try
            {
                stmt.execute(command);
            }
            catch (Exception e)
            {	// Keep running on exception.  This is mostly for DROP TABLE if table does not exist.
                out.println(e+"<br>");
            }
        }	 
        scanner.close();
        
        out.print("<br><h3>Database loaded.</h3>");
    }
    catch (Exception e)
    {
        out.print(e);
    }  
    %>
</div>
</html>