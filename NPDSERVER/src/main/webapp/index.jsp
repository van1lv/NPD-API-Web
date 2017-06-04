<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>NPD | Login</title>

<link rel="stylesheet" href="style.css">



</head>
<body>
	<div class="style">
		<div class="heading">
			<h2>Doctor Login</h2>
			<form method="get" action="login.jsp">

				<div class="input-group input-group-lg">
					<span class="input-group-addon"><i class="fa fa-user"></i></span> 
					<input
						type="text" class="form-control" name ="name" placeholder="Username">
				</div>

				<div class="input-group input-group-lg">
					<span class="input-group-addon"><i class="fa fa-lock"></i></span> 
					<input
						type="password" class="form-control" name="password" placeholder="Password">
				</div>

				<button type="submit" class="float">Login</button>

			</form>
			<form action="docregisterform.jsp">
				<button type="submit" class="float">Register</button>
			</form>
		</div>
	</div>


</body>
</html>