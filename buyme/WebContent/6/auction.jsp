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
String auctioneer = rs.getString("auctioneer");%>

<title><%=title%></title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1><%=title%></h1><%

if (request.getUserPrincipal().getName().equals(auctioneer) || request.isUserInRole("customerRep")) {%>
	<a href="/buyme/6/RemoveAuction?id=<%=id%>"><input type="button" value="Remove auction"></a><br><br><%
}

if (request.isUserInRole("user")) {%>
	<a href="/buyme/user/bid.jsp?auction=<%=id%>"><input type="button" value="Bid"></a><br><br><%
}

String bidError = request.getParameter("bidError");
if (bidError != null) {%>
	<p>Error bidding $<%=bidError%></p><%
}%>

Current bid: $<%=db.getCurrentBid(id)%> <br>
<a href="/buyme/6/bids.jsp?auction=<%=id%>">Bid history</a> <br><br>

Category: <%=category%>/<%=subcategory%> <br>
Auctioneer: <%=auctioneer%> <br>
Auction ID: <%=id%> <br> <br>

Auction opened: <%=openTime%> <br>
Close time: <%=closeTime%> <br> <br><% 

rs = con.createStatement().executeQuery("SELECT field, value FROM AuctionField WHERE auction='" + id + "';");
while (rs.next()) {
	String field = rs.getString("field");
	String value = rs.getString("value");%>
	<%=field%>: <%=value%> <br><%
}%>

Description: <%=description%><br><br>

<%rs = con.createStatement().executeQuery("SELECT * FROM Question WHERE id=" + id + ";");
while (rs.next()) {%>
Question: <%=rs.getString("text")%><br>
	
	<%ResultSet rs2 = con.createStatement().executeQuery("SELECT * FROM Answer WHERE qId=" + rs.getString("qId") + ";");
	while(rs2.next()){%>
Answer: <%=rs2.getString("text") %><br><%} %>

<form action="/buyme/6/ReplyQ?qId=<%=rs.getString("qId")%>&aucId=<%=id%>&" method="post">
<textarea required name="text" cols="35" rows="1"></textarea><br>
<input type="submit" value="Reply"><br><br>
</form>	
<%}con.close();%>

<%if (request.getParameter("error") != null){%>
<%= request.getParameter("error")%><br>
<% }%>

Ask a Question!<br>
<form action="/buyme/6/SubmitQuestion?aucId=<%=id %>&" method="post">
<textarea required name="text" cols="35" rows="1"></textarea><br>
<input type="submit" value="Submit Question">

</body>
</html>