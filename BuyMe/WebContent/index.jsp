<%@page import="main.*"%>

<html>
<head>
<title>BuyMe</title>
</head>
<body>
	<h1>BuyMe</h1>
	<%if (!Database.isLoggedIn()) {%>
	<form action="authenticate" method="post">
		Username: <input required type="text" name="username"> <br>
		Password: <input required type="password" name="password"> <br>
		<input type="submit" value="Login"> <input type="button"
			value="Register">
	</form>
	<%} else {%>
	<input type="button" value="Logout">
	<%}%>
</body>
</html>