<html>
<head>
<title>Login</title>
</head>
<body>
	<div style="text-align:center">
	<h1>Login</h1>
<<<<<<< HEAD
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
=======
	<h3>Or register for a new account</h3>
	
	<%
	String success = request.getParameter("registrationSuccess");
	if (success != null) {%>
	<p>Successfully registered <%=success%></p>
	<%}%>
	
	<jsp:include page="WEB-INF/includes/loginForm.jsp"></jsp:include>
>>>>>>> master
</body>
</html>