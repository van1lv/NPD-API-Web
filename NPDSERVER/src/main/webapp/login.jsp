<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%-- <%@ page import="javax.ws.rs.*"%> --%>
<%@ page import="org.json.*"%>
<%@ page import="javax.ws.rs.client.*"%>
<%@ page import="javax.ws.rs.core.Response"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>

</head>

<body>
	<%
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		
		try {


			String usernameAndPassword = name + ":" + password;
			String authorizationHeaderName = "Authorization";
			String authorizationHeaderValue = "Basic " + java.util.Base64.getEncoder().encodeToString(usernameAndPassword.getBytes());
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npddoctors/login");
			Response res = target.request("application/json")
										 .header(authorizationHeaderName, authorizationHeaderValue) 
										 .get(); 


			System.out.println("doctor login sent");
			if (res.getStatus() != 200) 
			{
				System.out.println("doctor login response not 200");
				throw new RuntimeException("Failed : HTTP error code : " + res.getStatus());
			}
			String output = res.readEntity(String.class);
			System.out.println(output);
			JSONObject obj = new JSONObject(output);
			System.out.println(obj.toString());
			String op=obj.getString("allow");
			if (op.equals("yes")) 
			{
				session.setAttribute("name", name);
				session.setAttribute("password", password);
				response.sendRedirect("welcome.jsp");
			} 
			else 
			{
				response.sendRedirect("error.jsp");
			}
		} 
		catch (Exception e) 
		{
			out.println(e);
		}
	%>
	<center>
		<p style="color: red">Sorry, information you entered may be invalid.</p>
	</center>
</body>
</html>