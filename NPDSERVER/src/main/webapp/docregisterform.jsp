
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="style.css" type="text/css">
<title>Doctor Register</title>

<link rel="stylesheet" href="style.css">
</head>


<body>
	<div class="style">
		<div class="heading">
			<h2>Doctor Register</h2>
			<form method="get" action="register.jsp">
				<div class="input-group input-group-lg">
					

					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" name="username"
							placeholder="Username*">
					</div>
					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i class="fa fa-lock"></i></span>
						<input type="password" class="form-control" name="password"
							placeholder="Password*">
					</div>
					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" name="fullname"
							placeholder="Full name">
					</div>

					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" name="age"
							placeholder="Age">
					</div>

					<div class="input-group input-group-lg">
						<span class="input-group-addon"><i class="fa fa-user"></i></span>
						<input type="text" class="form-control" name="email"
							placeholder="Email*">
					</div>
					
					
				</div>
				<button type="submit" class="float">Register</button>
			</form>
		</div>
	</div>
	<p>* : Cannot be null.</p>

</body>
</html>