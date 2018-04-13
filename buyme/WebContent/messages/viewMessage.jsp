<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Message Viewer</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<%
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT subject, text, sentBy, dateTime FROM Message WHERE id="
+ request.getParameter("mId") + ";");
while (rs.next()) {%>
From: <%=rs.getString("sentBy") %><br>
Date/time: <%=rs.getString("dateTime") %><br>
Subject: <%=rs.getString("subject") %><br>
Message: <br>
<table border="1" width="25%" cellspacing="1">
<tr><td width="25%">
<%=rs.getString("text")%>
</td></tr>
</table>
<form action="/buyme/messages/compose.jsp?sentBy=<%=rs.getString("sentBy")%>" method="post">
<input type="submit" value="Relpy">
</form>
<form action="/buyme/messages/DeleteMessage?mId=<%=request.getParameter("mId")%>" method="post">
<input type="submit" value="Delete">
</form>
<%} con.close(); %>
<form action="/buyme/messages/messages.jsp">
<input type="submit" value="My messages">
</form>
</body>
</html>