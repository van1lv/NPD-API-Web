<%@ page import="org.json.*"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Score per Level</title>
<link rel="stylesheet" href="style.css">
</head>
<%
	//String pid = session.getAttribute("pid").toString();
	String name = session.getAttribute("name").toString();
	String password = session.getAttribute("password").toString();
	String stringArray = session.getAttribute("PatientScore").toString();

	JSONArray resultArray = new JSONArray(stringArray);

System.out.println("per:" + stringArray);

	 JSONObject time0 = new JSONObject();
	 JSONObject time1 = new JSONObject();
	 JSONObject time2 = new JSONObject();
	 JSONObject time3 = new JSONObject();
	 JSONObject time4 = new JSONObject();
	 JSONObject time5 = new JSONObject();
	 
	 JSONObject time6 = new JSONObject();
	 JSONObject time7 = new JSONObject();
	 JSONObject time8 = new JSONObject();
	 JSONObject time9 = new JSONObject();
	 
	 
	 time0.put("score",0);
	 time0.put("time",0);
	 time1.put("score",0);
	 time1.put("time",0);
	 time2.put("score",0);
	 time2.put("time",0);
	 time3.put("score",0);
	 time4.put("time",0);
	 time4.put("score",0);
	 time4.put("time",0);
	 time5.put("score",0);
	 time5.put("time",0); 
	 
	 time6.put("score",0);
	 time6.put("time",0); 
	 
	 time7.put("score",0);
	 time7.put("time",0); 
	 
	 time8.put("score",0);
	 time8.put("time",0); 
	 
	 time9.put("score",0);
	 time9.put("time",0); 
	ArrayList<JSONObject> array = new ArrayList<JSONObject>();


   for(int i= 0; i < resultArray.length();i++)
   {
	   JSONObject timeRecord = new JSONObject();
	  // System.out.println(timeRecord.toString());
	  
	   JSONObject time = new JSONObject();
	   
	   String number = Integer.toString(i);
	   
	   timeRecord = resultArray.getJSONObject(i);
	  
	   time.put("x", timeRecord.get("time").toString());
	   time.put("y",Integer.parseInt(timeRecord.get("score").toString()));
	  // time.put("sign",i);
	   array.add(time);
	   
   }
   System.out.println("array:"+array.toString());
   JSONArray jsonArray = new JSONArray(array);
   System.out.println("json:"+jsonArray.toString());

   
%>


<script type="text/javascript">

window.onload = function(){
	      var jsonData = <%=jsonArray%>;
		  var dataPoints = [];
		 
		  for (var i = 0; i < jsonData.length; i++) {
		      dataPoints.push({
		        x: new Date(jsonData[i].x),
		        y: jsonData[i].y
		      });
		    }

		    var chart = new CanvasJS.Chart("chartContainer", 
		      {
		    	theme: "theme2",
		    	title: {
		    		 	text: "Patient Recient Score"
		    		   },
		        toolTip:{
		        		content: "Score:{y}"
		        		},
		        axisX: {
		        		title: "Time",
		        		valueFormatString: "DD MMM YYYY hh:mm:ss" 
		      		   },
		        axisY: {
		        		includeZero: false
		      		   },
		      data: [{
		        type: "line",
		        lineThickness: 3,
		        dataPoints: dataPoints
		      }]
		    });
		    chart.render();
}
</script>
<script src="canvasjs.min.js"></script>




<body>
	<div id="chartContainer" style="height: 300px; width: 100%;"></div>
</body>
</html>