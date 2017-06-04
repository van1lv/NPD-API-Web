<%@ page import="org.json.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Max Score Comparison</title>
<link rel="stylesheet" href="style.css">
<%
	 String pid = session.getAttribute("pid").toString();
     String name = session.getAttribute("name").toString();
	 String password = session.getAttribute("password").toString();
	 String stringArray = session.getAttribute("MaxArray").toString();
	 JSONArray resultArray  = new JSONArray(stringArray);
	 System.out.println("max:"+stringArray);
	// String resultArray
	 
	//container
	 JSONObject level1 = new JSONObject();
	 JSONObject level2 = new JSONObject();
	 JSONObject level3 = new JSONObject();
	 JSONObject level4 = new JSONObject();
	 JSONObject level5 = new JSONObject();
	 JSONObject level6 = new JSONObject();
	 level1.put("patient", 0);
	 level1.put("maxScore",0);
	 level2.put("patient", 0);
	 level2.put("maxScore",0);
	 level3.put("patient", 0);
	 level3.put("maxScore",0);
	 level4.put("patient", 0);
	 level4.put("maxScore",0);
	 level5.put("patient", 0);
	 level5.put("maxScore",0);
	 level6.put("patient", 0);
	 level6.put("maxScore",0);
	
	 for(int i=0;i<resultArray.length();i++)
	 {
		 if(resultArray.getJSONObject(i).get("level").equals("1"))
		 {
			 System.out.print(1);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level1.put("patient", pscore);
			 level1.put("maxScore",mscore);
			 System.out.println(level1);
			 
		 }
		 else if(resultArray.getJSONObject(i).get("level").equals("2"))
		 {
			 System.out.print(2);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level2.put("patient", pscore);
			 level2.put("maxScore",mscore);
			 System.out.println(level2);
		 }
		 else if(resultArray.getJSONObject(i).get("level").equals("3"))
		 {
			 System.out.print(3);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level3.put("patient", pscore);
			 level3.put("maxScore",mscore);
			 System.out.println(level3);
		 }
		 else if(resultArray.getJSONObject(i).get("level").equals("4"))
		 {
			 System.out.print(4);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level4.put("patient", pscore);
			 level4.put("maxScore",mscore);
		 }
		 else if(resultArray.getJSONObject(i).get("level").equals("5"))
		 {
			 System.out.print(5);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level5.put("patient", pscore);
			 level5.put("maxScore",mscore);
		 }
		 else if(resultArray.getJSONObject(i).get("level").equals("6"))
		 {
			 System.out.print(5);
			 int pscore = Integer.parseInt(resultArray.getJSONObject(i).get("patient").toString());
			 int mscore = Integer.parseInt(resultArray.getJSONObject(i).get("maxScore").toString());
			 level6.put("patient", pscore);
			 level6.put("maxScore",mscore);
		 }	 
	 }
%>
<script type="text/javascript">
	window.onload = function () {
		var chart = new CanvasJS.Chart("chartContainer",
		{
			theme: "theme2",
                        animationEnabled: true,
			title:{
				text: "Max Score Comparison",
				fontSize: 30
			},
			toolTip: {
				shared: true
			},			
			axisY: {
              //title: "Max score of all patients"
			},
			axisY2: {
              //title: "Patient"
			},			
			data: [ 
			{
				type: "column",	
				name: "Patient score",
				legendText: "Patient score",
				showInLegend: true, 
				dataPoints:[
				{label: "Level 1", y: <%=level1.get("patient")%>},
				{label: "Level 2", y: <%=level2.get("patient")%>},
				{label: "Level 3", y: <%=level3.get("patient")%>},
				{label: "Level 4", y: <%=level4.get("patient")%>},
				{label: "Level 5", y: <%=level5.get("patient")%>},
				{label: "Level 6", y: <%=level6.get("patient")%>},
				
				]
			},
			{
				type: "column",	
				name: "Max score",
				legendText: "Max score",
				axisYType: "secondary",
				showInLegend: true,
				dataPoints:[
				{label: "Level 1", y: <%=level1.get("maxScore")%>},
				{label: "Level 2", y: <%=level2.get("maxScore")%>},
				{label: "Level 3", y: <%=level3.get("maxScore")%>},
				{label: "Level 4", y: <%=level4.get("maxScore")%>},
				{label: "Level 5", y: <%=level5.get("maxScore")%>},
				{label: "Level 6", y: <%=level6.get("maxScore")%>},
				
				]
			}
			
			],
          legend:{
            cursor:"pointer",
            itemclick: function(e){
              if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
              	e.dataSeries.visible = false;
              }
              else {
                e.dataSeries.visible = true;
              }
            	chart.render();
            }
          },
        });

chart.render();
}
</script>
<script src="canvasjs.min.js"></script>
</head>
<body>
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
</body>
</html>