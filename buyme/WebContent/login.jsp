<html>
<head>
<title>Login</title>
</head>
<body>
	<h1>Login</h1>
	<h3>Or register for a new account</h3>
	
	<%
	String success = request.getParameter("registrationSuccess");
	if (success != null) {%>
	<p>Successfully registered <%=success%></p>
	<%}%>
	
	<jsp:include page="WEB-INF/includes/loginForm.jsp"></jsp:include>
</body>
</html>