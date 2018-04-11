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

<h1>Auctions</h1>

<a href="/buyme/user/createAuction.jsp"><input type="button" value="Create auction"></a>

<table>
	<tr>
		<th>Item</th>
		<th>Auctioneer</th>
	</tr>

<%
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Auction;");

while (rs.next()) {
	String category = rs.getString("category");
	String subcategory = rs.getString("subcategory");
	String auctioneer = rs.getString("auctioneer");
%>

	<tr>
		<td><%=category%> / <%=subcategory%></td>
		<td><%=auctioneer%></td>
	</tr><%
}%>

</table><%

con.close();%>

</body>
</html>