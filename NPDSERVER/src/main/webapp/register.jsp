<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="org.json.*"%>
<%@ page import="javax.ws.rs.client.*"%>
<%@ page import="javax.ws.rs.core.Response"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Register</title>
</head>
<body>
	<%
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullname = request.getParameter("fullname");
		String age = request.getParameter("age");
		String email = request.getParameter("email");
		System.out.println("user:"+username);
		System.out.println("psd:"+password);
		if(password.equals("")||username.equals("")||email.equals(""))
		{
			System.out.println("");
			response.sendRedirect("error.jsp");
			return;
		}
		else
		{
		try {

			String usernameAndPassword = username + ":" + password;
			String authorizationHeaderName = "Authorization";
			String authorizationHeaderValue = "Basic " + java.util.Base64.getEncoder().encodeToString(usernameAndPassword.getBytes());
			//String restResource = "http://localhost:8080/Jersey2/rest";
			Client client = ClientBuilder.newClient();
			WebTarget target = client.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npddoctors/newdoctor/"+fullname+"/"+age+"/"+email);
			
			Response res = target.request("application/json")// Expected response mime type
										 .header(authorizationHeaderName, authorizationHeaderValue) // The basic authentication header goes here
										 .get(); // Perform a post with the form values */
			System.out.println("sent");
			if (res.getStatus() != 200) 
			{
				System.out.println("not 200");
				throw new RuntimeException("Failed : HTTP error code : " + res.getStatus());
			}
			String output = res.readEntity(String.class);
			System.out.println(output);
			
			JSONObject msg = new JSONObject(output);

			if(msg.getString("Allow").equals("yes"))
			{
				session.setAttribute("name", username);
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
			response.sendRedirect("error.jsp");
			out.println(e);
		}
		}
	%>
	<center>
		<p style="color: red">Sorry, information you entered may be
			invalid.</p>
	</center>
</body>
</html>