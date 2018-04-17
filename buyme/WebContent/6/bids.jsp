<!-- 
// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla
 -->

<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
String auction = request.getParameter("auction");
Connection con = new Database().connect();
ResultSet rs = con.createStatement().executeQuery("SELECT title, initialPrice FROM Auction WHERE id=" + auction);
rs.next();
String title = rs.getString("title");
BigDecimal initialPrice = rs.getBigDecimal("initialPrice");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%=title%>/Bids</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1><a href="/buyme/6/auction.jsp?id=<%=auction%>"><%=title%></a>/Bids</h1>

Initial price: $<%=initialPrice%><br><br><%

String removeError = request.getParameter("removeError");
if (removeError != null) {%>
	<p>Error removing bid<%
}%>

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
			<td><%=time%></td><%
			if (request.isUserInRole("customerRep")) {%>
				<td><a href="/buyme/customerRep/RemoveBid?auction=<%=auction%>&amount=<%=amount%>">Remove bid</a></td><%
			}%>
		</tr><%
	}%>
	
</table>

</body>
</html><%

con.close();%>