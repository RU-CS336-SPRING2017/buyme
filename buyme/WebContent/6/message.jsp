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
 
String id = request.getParameter("id");
Connection con = new Database().connect();
String user = request.getUserPrincipal().getName();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Message WHERE id=" + id + ";");
rs.next();
String subject = rs.getString("subject");
String text = rs.getString("text");
String sentBy = rs.getString("sentBy");
String receivedBy = rs.getString("receivedBy");
String dateTime = Database.timestampString(rs.getTimestamp("dateTime"));
con.close();

if (!user.equals(sentBy) && !user.equals(receivedBy)) {
	response.sendRedirect("/buyme/6/messages.jsp");
}%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=subject%></title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1><%=subject%></h1>

<p>
	From: <%=sentBy%><br>
	To: <%=receivedBy%><br>
	Time: <%=dateTime%>
</p>

<p><%=text%></p>

</body>
</html>