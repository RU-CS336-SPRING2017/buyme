<%@page import="main.*"%>

<html>
<head>
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
	<h3>Or register for a new account</h3>
	<form action="j_security_check" method="post">
		Username: <input required type="text" name="j_username"> <br>
		Password: <input required type="password" name="j_password"> <br>
		<input type="submit" value="Login"> <input type="button"
			value="Register">
	</form>
</body>
</html>