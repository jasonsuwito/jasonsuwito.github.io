<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);
	
	try{
		authenticatedUser = validateLogin(out,request,session);
	}catch(IOException e){
		System.err.println(e);
	}
	// Test Successful login
	if(authenticatedUser != null){
		String currPage = (String)session.getAttribute("currentpage");
		Boolean fromAuth = (Boolean)session.getAttribute("fromAuth");
		if(currPage == null || fromAuth != true)
			response.sendRedirect("index.jsp");
		else
			response.sendRedirect(currPage);
	} else{
		response.sendRedirect("login.jsp");
	}
	session.setAttribute("fromAuth", false);
%>

<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;
		String user2 = "";

		if(username == null || password == null){
			return null;
		}
		try{	
			getConnection();
			Statement stmt = con.createStatement();
			stmt.execute("USE orders");
			String sql = "SELECT userid, password FROM customer";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
				if(username.equals(rst.getString(1))){
					out.println(username);
					if(password.equals(rst.getString(2))){
						out.println(password);
						retStr = username;	
						closeConnection();
						break;
					}else{
						retStr = null;
					}
				}else{
					retStr = null;
				}
			}
			// TODO: If userId and password match some customer account, set retStr to be the username.
			closeConnection();	
		}catch (SQLException ex) {
			out.println(ex);
		}
		
		if(retStr != null){
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		}else{
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
		}
		return retStr;
	}
%>