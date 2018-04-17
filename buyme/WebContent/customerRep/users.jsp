<!-- 
// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla
 -->

<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%

Connection con = new Database().connect();%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Users</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Users</h1><%

String resetError = request.getParameter("resetError");
if (resetError != null) {%>
	<p>Error resetting password for <%=resetError%></p><%
}%>

<table>

	<tr>
		<th>Username</th>
		<th>Reset Password</th>
	</tr><%

	ResultSet rs = con.createStatement().executeQuery("SELECT username FROM Account WHERE type='user';");
	
	while (rs.next()) {
		
		String username = rs.getString("username");%>
		
		<tr>
			<td><%=username%></td>
			<td>
				<form action="/buyme/customerRep/ResetPassword" method="post">
					<input type="hidden" value="<%=username%>" name="username">
					<label>New password: <input required type="text" name="password"></label>
					<input type="submit" value="Reset password">
				</form>
			</td>
		</tr><%
	}%>
	
</table>

</body>
</html>
<%
con.close();
%>