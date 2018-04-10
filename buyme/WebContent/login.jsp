<%@page import="main.*"%>

<html>
<head>
<title>Login</title>
</head>
<body>
	<div style="text-align:center">
	<h1>Login</h1>
	<h4>Or register for a new account</h4>
	<form action="j_security_check" method="post">
		Username: <input required type="text" name="j_username"> <br>
		Password: <input required type="password" name="j_password"> <br>
		<input type="submit" value="Login">
		<br>
		or 
		<a href="../register.jsp"><br><input type="button" value="Register">
		</a>
	</form>
	</div>
</body>
</html>