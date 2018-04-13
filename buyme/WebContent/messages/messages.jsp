<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Messages</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<h2><u>My Messages</u></h2>
<form action="/buyme/messages/compose.jsp">
<input type="submit" value="Compose">
<%if (request.getParameter("success") != null){ %>
<%=request.getParameter("success")%><%} %>
</form><br>
<table border="1" width="25%" cellspacing="1">
<tr>
<th>From</th>
<th>Subject</th>
<th>Date Received</th> 
</tr>
<%Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT sentBy, subject, dateTime, id FROM Message WHERE receivedBy='" 
+ request.getUserPrincipal().getName() + "';");
while (rs.next()) {%>	
<tr>
<td><a href="/buyme/messages/viewMessage.jsp?mId=<%=rs.getString("id")%>"><%=rs.getString("sentBy")%></a></td>
<td><%=rs.getString("subject")%></td>
<td><%=rs.getString("dateTime")%></td>
<%} con.close();%>
</table>
</body>
</html>