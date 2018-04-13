<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<form action="/buyme/admin/CreateCustomerRep" method="post">
<%if(request.getParameter("addError") != null) { %>
Error creating customer rep: <%=request.getParameter("addError")%><br>
<%}%>
	Username: <input required type="text" name="username"> <br>
	Password: <input required type="password" name="password"> <br>
	<input type="submit" value="Create New Customer Rep">
</form>
<%if(request.getParameter("removeError") != null) { %>
Error removing customer rep: <%=request.getParameter("removeError")%><br>
<%}%>
<table>
<tr>
<th>Username</th>
<th>Password</th>
</tr>
<%
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT username, password FROM Account WHERE type='customerRep';");
while (rs.next()) {%>
<tr>
<td><%=rs.getString("username")%></td>
<td><%=rs.getString("password")%></td>
<td><a href="/buyme/admin/RemoveAccount?username=<%=rs.getString("username")%>"><input type="button" value="Remove"></a></td>
</tr>
<%}
con.close();
%>
</table>
</body>
</html>