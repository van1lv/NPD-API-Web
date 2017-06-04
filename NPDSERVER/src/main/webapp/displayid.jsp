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
<title>Patient ID</title>
<link rel="stylesheet" href="style.css">

<style>
table.center {
	margin-left: auto;
	margin-right: auto;
	text-align:left;
}

form {
	font-size: 150%;
}

</style>
</head>
<body>
	<%
		String email = request.getParameter("email");
		String name = session.getAttribute("name").toString();
		String password = session.getAttribute("password").toString();

		String pid = "Not found";
		String patient_name = "Not found";
		try {

			String usernameAndPassword = name + ":" + password;
			String authorizationHeaderName = "Authorization";
			String authorizationHeaderValue = "Basic "
					+ java.util.Base64.getEncoder().encodeToString(usernameAndPassword.getBytes());

			Client client = ClientBuilder.newClient();
			WebTarget target = client.target("http://115.146.93.249:8080/NPDSERVER/rest")
					.path("npddoctors/searchids/" + email);

			Response res = target.request("application/json")// Expected response mime type
					.header(authorizationHeaderName, authorizationHeaderValue) // The basic authentication header goes here
					.get(); // Perform a post with the form values */
			System.out.println("sent");
			if (res.getStatus() != 200) {
				System.out.println("not 200");
				throw new RuntimeException("Failed : HTTP error code : " + res.getStatus());
			}
			String output = res.readEntity(String.class);
			System.out.println(output);

			JSONObject msg = new JSONObject(output);

			pid = msg.getString("pid");
			patient_name = msg.getString("name");

		} catch (Exception e) {
			out.println(e);
		}
	%>
	<div class="style">
		<div class="heading">
			<form>
				<h2>Patient ID</h2>
				<table class="center">
					<tr>
						<td style="width: 150px">Email :</td>
						<td style="width: 150px"><%=email%></td>
					</tr>

					<tr>
						<td style="width: 150px">Patient Name :</td>
						<td style="width: 150px"><%=patient_name%></td>
					</tr>
					<tr>
						<td style="width: 150px">Patient ID :</td>
						<td style="width: 150px"><%=pid%></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>