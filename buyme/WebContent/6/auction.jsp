<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include><%

String id = request.getParameter("id");

Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT * FROM Auction WHERE id='" + id + "';");
rs.next();

String subcategory = rs.getString("subcategory");
String category = rs.getString("subcategory");
String openTime = Database.timestampString(rs.getTimestamp("openTime"));
String closeTime = Database.timestampString(rs.getTimestamp("closeTime"));
String description = rs.getString("description");
String auctioneer = rs.getString("auctioneer");
%>

<h1>Auction #<%=id%></h1>

<h3><%=subcategory%></h3>
Category: <%=category%> <br>
Auctioneer: <%=auctioneer%> <br>
Auction opened: <%=openTime%> <br>
Close time: <%=closeTime%> <br><% 

rs = con.createStatement().executeQuery("SELECT field, value FROM AuctionField WHERE auction='" + id + "';");
while (rs.next()) {
	String field = rs.getString("field");
	String value = rs.getString("value");%>
	<%=field%>: <%=value%> <br><%
}%>

Description: <%=description%><%

con.close();%>

</body>
</html>