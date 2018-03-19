<%@page import="main.Database"%>

<html>
<body>
<h2>login</h2>
<p>


<%

String username = request.getParameter("username");
String password = request.getParameter("password");

Database db = new Database();

Database.loggedIn = db.verifyUser(username, password);

if (Database.loggedIn) {
	Database.username = username;
	out.println("Logged in!");
} else {
	out.println("Invalid login!");
}


%>

</p>
</body>
</html>