<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create Auction</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Create Auction</h1><%

String category = request.getParameter("category");
String subcategory = request.getParameter("subcategory");

Connection con = new Database().connect();

if (category == null) {%>
	
	<h3>Choose a category</h3><%
	
	ResultSet rs = con.createStatement().executeQuery("SELECT name FROM ItemCategory;");%>
	
	<ul><%
	while (rs.next()) {
		String name = rs.getString("name");%>
		<li><a href="/buyme/user/createAuction.jsp?category=<%=name%>"><%=name%></a></li>	
<%	}%>
	</ul><%
	
} else if (subcategory == null) {%>
	
	<h3>Choose a subcategory</h3><%
	
	ResultSet rs = con.createStatement().executeQuery("SELECT name FROM ItemSubcategory WHERE category='" + category + "';");%>
	
	<ul><%
	while (rs.next()) {
		String name = rs.getString("name");%>
		<li><a href="/buyme/user/createAuction.jsp?category=<%=category%>&subcategory=<%=name%>"><%=name%></a></li>	
<%	}%>
	</ul><%
	
} else {%>

	<form action="/buyme/user/CreateAuction" method="post">
		
		<label>Title: <input required type="text" name="title"></label><br><br>
		<label>Initial Price: <input required name="initialPrice" type="number" step="0.01"></label><br>
		<label>Bid Increment: <input required name="bidIncrement" type="number" step="0.01"></label><br>
		<label>Minimum Price: <input name="minimumPrice" type="number" step="0.01"></label><br><br>
		<label>Close Time: <input required name="closeTime" type="datetime-local"></label><br><br><%
		
		ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
		
		while (rs.next()) {
		
			String field = rs.getString("name");%>
			<label><%=field%>: <input required type="text" name="<%=field%>"></label><br><%
		}%>
		
		<br><label>Description: <textarea required name="description"></textarea></label><br><br>
		
		<input type="hidden" value="<%=category%>" name="category">
		<input type="hidden" value="<%=subcategory%>" name="subcategory">
		<input type="submit" value="Create">
	
	</form><%
}

con.close();%>

</body>
</html>