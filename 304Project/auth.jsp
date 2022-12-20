<%
	boolean authenticated = session.getAttribute("authenticatedUser") == null ? false : true;

	if (!authenticated){
		String currPage = request.getRequestURL().toString();
		session.setAttribute("currentpage", currPage);
		session.setAttribute("fromAuth", true);
		String loginMessage = "You have not been authorized to access the URL "+currPage;
        session.setAttribute("loginMessage",loginMessage);        
		response.sendRedirect("login.jsp");
	}
%>
