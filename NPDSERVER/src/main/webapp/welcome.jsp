<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Welcome</title>

<link rel="stylesheet" href="style.css">

<style>
table {
	text-align: left;
	display: inline-block;
	width: 300px;
	
}

p {
	font-size: 150%;
}

</style>

</head>

<body>

	<p>
		Welcome,
		<%=session.getAttribute("name")%></p>


	<div class="style">
		<div class="heading">

			<form method="get" action="datafetch.jsp">
				<h2>Patient Information</h2>
				<div>
					<table>

						<tr>
							<td style="width: 150px">Patient ID :</td>
							<td><input name="pid" type="text" style="width: 150px" /></td>
						</tr>
						<tr>
							<td style="width: 150px">Game Type :</td>
							<td><select name="game" style="width: 150px">
									<option value="select">game type</option>
									<option value="1">Pipe Game</option>
									<option value="2">Balance Ball Game</option>
									<option value="3">Card Memory Game</option>
									<option value="4">Breakout Game</option>
									<option value="5">Choose Color Game</option>
									<option value="6">Balloon Game</option>
							</select></td>
						</tr>

						<tr>
							<td style="width: 150px">Result Type :</td>
							<td><select name="results" onchange="admSelectCheck(this);"
								style="width: 150px">
									<option value="select">result type</option>
									<option value="Max">Max Score Comparison</option>
									<option id="admOption" value="Each">Score per Level</option>
							</select></td>
						</tr>
						<tr>
							<td style="width: 150px"></td>
							<td id="admDivCheck" style="display: none;"><select
								name="level" style="width: 150px">
									<option value="select">level</option>
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
									<option value="5">5</option>
									<option value="6">6</option>
							</select></td>
						</tr>


					</table>
				</div>
				<button type="submit" class="float">Submit</button>

			</form>


			<form action="searchidform.jsp" style="align: left">
				<button type="submit" class="float">SearchID</button>
			</form>

			<form action="logout.jsp">
				<button type="submit" class="float">Logout</button>
			</form>


		</div>
	</div>

	<script type="text/javascript">
		function admSelectCheck(nameSelect) {
			if (nameSelect) {
				admOptionValue = document.getElementById("admOption").value;
				if (admOptionValue == nameSelect.value) {
					document.getElementById("admDivCheck").style.display = "block";
				} else {
					document.getElementById("admDivCheck").style.display = "none";
				}
			} else {
				document.getElementById("admDivCheck").style.display = "none";
			}
		}
	</script>
</body>

</html>