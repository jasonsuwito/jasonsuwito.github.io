<%
if (session.getAttribute("authenticatedUser") != null){
        out.println("<h3>"+"Signed in as: " + session.getAttribute("authenticatedUser").toString()+"</h3>");
}	
%>