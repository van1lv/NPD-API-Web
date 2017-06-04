<%@ page import="java.sql.*"%>
<%@ page import="javax.ws.rs.*"%>
<%@ page import="javax.ws.rs.core.Response"%>
<%@ page import="javax.net.ssl.*"%>
<%@ page import="javax.ws.rs.client.*"%>
<%@ page import="java.util.*"%>
<%@ page import="org.json.*"%>
<%@ page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dispatcher</title>

<%
		String id = request.getParameter("pid");
		String gametype = request.getParameter("game");
		String resultstype = request.getParameter("results");
		/* <option value="select">select</option>
		<option value="1-PipeGame">Pipe Game</option>
	  <option value="2-BalanceBallGame">Balance Ball Game</option>
		<option value="3-CardMemoryGame">Card Memory Game</option>
		<option value="4-BreakoutGame">Breakout Game</option>
		<option value="5-ChooseColorGame">Choose Color Game</option>
		<option value="6-BalloonGame">Balloon Game</option> */
		
		 try {
				if(resultstype.equals("Max"))
				{
				 //store resuls from db
					JSONObject level1 = new JSONObject();
					JSONObject level2 = new JSONObject();
					JSONObject level3 = new JSONObject();
				//name and password
					String name = session.getAttribute("name").toString();
					String password = session.getAttribute("password").toString();
					
					String usernameAndPassword = name + ":" + password;
					String authorizationHeaderName = "Authorization";
					String authorizationHeaderValue = "Basic " + java.util.Base64.getEncoder().encodeToString(usernameAndPassword.getBytes());
//--------------------------------------------------------------------------------------------------
//replace uri
					Client getUri = ClientBuilder.newClient();   
					WebTarget uriTarget = getUri.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npdpatients/patients/"+id);
					Response clientRes = uriTarget.request("application/json")
											 .header(authorizationHeaderName, authorizationHeaderValue) 
											 .get(); 
					String resUri = clientRes.readEntity(String.class);
					System.out.println(resUri);
					JSONArray resArray  = new JSONArray(resUri);		
					String actMax = null;
					for(int i=0;i<resArray.length();i++)
					 {
						 if(resArray.getJSONObject(i).get("service").equals("maxscore"))
						 {
							String uri = resArray.getJSONObject(i).get("uri").toString();
							String replaced = uri.replace("{gid}", gametype);
							System.out.println(gametype);
							System.out.println("replaced:"+replaced);
							actMax = replaced; 
						 }
					 }

					//sending request and get response

//--------------------------------------------------------------------------------------------------
				//String restResource = "http://localhost:8080/Jersey2/rest";
					Client client = ClientBuilder.newClient();   
					WebTarget target = client.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npdpatients/patients/"+id+"/"+actMax);
				
					Response res = target.request("application/json")
											 .header(authorizationHeaderName, authorizationHeaderValue) 
											 .get(); 
											 
					System.out.println("sent");
					if(res.getStatus() != 200) 
					{
						System.out.println("max:not 200");
						throw new RuntimeException("Failed : HTTP error code : " + res.getStatus());
					}
					String output = res.readEntity(String.class);
					JSONArray resultArray  = new JSONArray(output);
					System.out.println(output);
					
					session.setAttribute("pid",id);
					session.setAttribute("MaxArray", resultArray);
					response.sendRedirect("displaymaxscore.jsp");
				}
				else if(resultstype.equals("Each"))
					{
						JSONObject level1 = new JSONObject();
						JSONObject level2 = new JSONObject();
						JSONObject level3 = new JSONObject();
				//name and pass
				        String level = request.getParameter("level");
						String name = session.getAttribute("name").toString();
						String password = session.getAttribute("password").toString();
						
						String usernameAndPassword = name + ":" + password;
						String authorizationHeaderName = "Authorization";
						String authorizationHeaderValue = "Basic " + java.util.Base64.getEncoder().encodeToString(usernameAndPassword.getBytes());
//--------------------------------------------------------------------------------------------------
//replace uri
						String actPer = null;
						Client getUri = ClientBuilder.newClient();   
						WebTarget uriTarget = getUri.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npdpatients/patients/"+id);
						Response clientRes = uriTarget.request("application/json")// Expected response mime type
												 .header(authorizationHeaderName, authorizationHeaderValue) // The basic authentication header goes here
												 .get(); // Perform a post with the form values */
						String resUri = clientRes.readEntity(String.class);
						System.out.println(resUri);
						JSONArray resArray  = new JSONArray(resUri);		
						String actUri = null;
						for(int i=0;i<resArray.length();i++)
						 {
							 if(resArray.getJSONObject(i).get("service").equals("perlevel"))
							 {
								String uri = resArray.getJSONObject(i).get("uri").toString();
								String replacedfirst = uri.replace("{gid}", gametype);	
								String replacedsecond = replacedfirst.replace("{level}", level);	
								System.out.println("-------------------------------");
								System.out.println("replaced:"+replacedsecond);
								System.out.println("-------------------------------");
								actPer = replacedsecond; 
							 }
						 }
//--------------------------------------------------------------------------------------------------
						Client client = ClientBuilder.newClient();
						WebTarget target = client.target("http://115.146.93.249:8080/NPDSERVER/rest").path("npdpatients/patients/"+id+"/"+actPer);
				
						Response res = target.request("application/json")// Expected response mime type
											 .header(authorizationHeaderName, authorizationHeaderValue) // The basic authentication header goes here
											 .get(); // Perform a post with the form values */
						System.out.println("sent");
						if(res.getStatus() != 200) 
						{
							System.out.println("not 200");
							throw new RuntimeException("Failed : HTTP error code : " + res.getStatus());
						}
						
						String output = res.readEntity(String.class);
						JSONArray resultArray  = new JSONArray(output);
						System.out.println(output);
						System.out.println("each");
					
						session.setAttribute("pid",id);
						session.setAttribute("PatientScore", resultArray);
						response.sendRedirect("displayscoreperlevel.jsp");
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
	%>	
<script src="canvasjs.min.js"></script>
<script type="text/javascript"></script>
</head>
<body>
</body>
</html>