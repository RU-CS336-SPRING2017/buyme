<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Account Manager</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<h4><u>Existing BuyMe Accounts</u></h4>
<table>
<tr>
<th>Username</th>
<th>Password</th>
<th>Change Password</th>
</tr>
<%
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT username, password FROM Account WHERE type='user';");
while (rs.next()) {%>
<tr>
<td><%=rs.getString("username")%></td>
<td><%=rs.getString("password")%></td>
<td><form action="/buyme/customerRep/ChangePassCR?username=<%=rs.getString("username")%>&" method="post">
<input type="text" name="password" required="required">
 <input type="submit" name="password" value="Change">
 <%if(request.getParameter("updateError") != null) { %>
Error updating password for user: <%=request.getParameter("updateError")%><%}%>
</form></td>
</tr>
<%}
con.close();
%>
</table>
</body>
</html>