<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"><%

String id = request.getParameter("id");

Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Auction WHERE id='" + id + "';");
rs.next();

String title = rs.getString("title");
String subcategory = rs.getString("subcategory");
String category = rs.getString("category");
String openTime = Database.timestampString(rs.getTimestamp("openTime"));
String closeTime = Database.timestampString(rs.getTimestamp("closeTime"));
String description = rs.getString("description");
String auctioneer = rs.getString("auctioneer");
String bidIncrement = rs.getString("bidIncrement");%>

<title><%=title%></title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1><%=title%></h1><%

if (request.getUserPrincipal().getName().equals(auctioneer) || request.isUserInRole("customerRep")) {%>
	<p><a href="/buyme/6/RemoveAuction?id=<%=id%>"><input type="button" value="Remove auction"></a></p><%
}

if (request.isUserInRole("user")) {%>
	<p><a href="/buyme/user/bid.jsp?auction=<%=id%>"><input type="button" value="Bid"></a></p><%
}

String bidError = request.getParameter("bidError");
if (bidError != null) {%>
	<p>Error bidding $<%=bidError%></p><%
}%>

<p>
	Current bid: $<%=db.getCurrentBid(id)%> <br>
	<a href="/buyme/6/bids.jsp?auction=<%=id%>">Bid history</a>
</p>

<p>
	Category: <%=category%>/<%=subcategory%> <br>
	Auctioneer: <%=auctioneer%> <br>
	Auction ID: <%=id%> <br>
	Bid increment: $<%=bidIncrement%>
</p>

<p>
	Auction opened: <%=openTime%> <br>
	Close time: <%=closeTime%>
</p>

<p><%
	rs = con.createStatement().executeQuery("SELECT field, value FROM AuctionField WHERE auction='" + id + "';");
	while (rs.next()) {
		String field = rs.getString("field");
		String value = rs.getString("value");%>
		<%=field%>: <%=value%> <br><%
	}%>
</p>

<h4>Description:</h4>
<%=description%>

</body>
</html><%

con.close();%>