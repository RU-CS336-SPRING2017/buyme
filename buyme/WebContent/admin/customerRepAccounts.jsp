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
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Customer Rep Accounts</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<h1>Customer Rep Accounts</h1>
<%if(request.getParameter("addError") != null) { %>
<p>Error creating customer rep: <%=request.getParameter("addError")%></p>
<%}%>
<p>
<form action="/buyme/admin/CreateCustomerRep" method="post">
	Username: <input required type="text" name="username">
	Password: <input required type="password" name="password">
	<input type="submit" value="Create New Customer Rep">
</form>
</p>
<%if(request.getParameter("removeError") != null) { %>
<p>Error removing customer rep: <%=request.getParameter("removeError")%></p>
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