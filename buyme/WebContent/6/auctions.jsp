<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Auctions</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Auctions</h1><%

if(request.getParameter("removeError") != null) {%>
	<p>Error removing auction with ID: <%=request.getParameter("removeError")%></p><%
}%>

<table>

	<tr>
		<th>Title</th>
		<th>Auctioneer</th>
		<th>Close time</th>
	</tr><%
	
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Auction WHERE winner IS NULL;");

while (rs.next()) {
	String id = rs.getString("id");
	String title = rs.getString("title");
	String category = rs.getString("category");
	String subcategory = rs.getString("subcategory");
	String auctioneer = rs.getString("auctioneer");
	String closeTime = Database.timestampString(rs.getTimestamp("closeTime"));%>

	<tr>
		<td><a href="/buyme/6/auction.jsp?id=<%=id%>"><%=title%></a></td>
		<td><%=auctioneer%></td>
		<td><%=closeTime%></td>
	</tr><%
}%>

</table><%

con.close();%>

</body>
</html>