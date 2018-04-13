<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
Connection con = new Database().connect();
String user = request.getUserPrincipal().getName();
boolean inbox = true;
if (request.getParameter("outbox") != null) {
	inbox = false;
}%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Messages</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Messages</h1><%

String sendError = request.getParameter("sendError");
if (sendError != null) {%>
	<p>Error sending message to <%=sendError%></p><%
}%>

<a href="/buyme/6/compose.jsp"><input type="button" value="Compse message"></a><%

if (inbox) {%>
	<p><a href="/buyme/6/messages.jsp?outbox">Outbox</a></p>
	<h3>Inbox</h3> <%
} else {%>
	<p><a href="/buyme/6/messages.jsp">Inbox</a></p>
	<h3>Outbox</h3> <%
}%>

<table>

	<tr>
		<th>Subject</th><%
		if (inbox) {%> <th>From</th> <%}
		else {%> <th>To</th ><%}%>
		<th>Time</th>
	</tr><%
	
	String query = "SELECT * FROM Message WHERE ";
	if (inbox) { query += "sentTo='"; }
	else { query += "receivedBy='"; }
	query += user + "';";
	ResultSet rs = con.createStatement().executeQuery(query);
	
	while (rs.next()) {
		
		String subject = rs.getString("subject");
		String person = null;
		if (inbox) { person = rs.getString("sentBy"); }
		else { person = rs.getString("receivedBy"); }
		String time = Database.timestampString(rs.getTimestamp("dateTime"));
		String id = rs.getString("id");%>
		
		<tr>
			<td><a href="/buyme/6/message.jsp?id=<%=id%>"><%=subject%></a></td>
			<td><%=person%></td>
			<td><%=time%></td>
		</tr><%
	}%>

</table>

</body>
</html><%

con.close();%>