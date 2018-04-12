<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
String auction = request.getParameter("auction");
Connection con = new Database().connect();
ResultSet rs = con.createStatement().executeQuery("SELECT title FROM Auction WHERE id=" + auction);
rs.next();
String title = rs.getString("title");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1></h1>

<table>

	<tr>
		<th>Bidder</th>
		<th>Amount</th>
		<th>Time</th>
	</tr><%
	
	rs = con.createStatement().executeQuery("SELECT * FROM Bid WHERE auction=" + auction);
	
	while (rs.next()) {
		
		String bidder = rs.getString("bidder");
		BigDecimal amount = rs.getBigDecimal("amount");
		String time = Database.timestampString(rs.getTimestamp("dateTime"));%>
		
		<tr>
			<td><%=bidder%></td>
			<td>$<%=amount%></td>
			<td><%=time%></td>
		</tr><%
	}%>
	
</table>

</body>
</html><%

con.close();%>