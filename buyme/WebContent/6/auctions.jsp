<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    
    Database db = new Database();
    Connection con = db.connect();
    ResultSet rs = null;
    
    String searchSubcategory = request.getParameter("subcategory");
    String search = request.getParameter("search");
    String orderBy = request.getParameter("orderBy");
    
    String whereClause = "";
    String orderByClasue = "";
    
    if (searchSubcategory != null && !searchSubcategory.equals("")) {
    	whereClause += " AND category='"+searchSubcategory.split("/")[0]+"' AND subcategory='"+searchSubcategory.split("/")[1]+"'";
    }
    
    if (orderBy != null) {
    	orderByClasue += " ORDER BY " + orderBy;
    }
    
    
    
    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Auctions</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Auctions</h1>

<p>
	<form action="/buyme/6/auctions.jsp" method="get">
		<select name="subcategory">
			<option value="">Category</option>
			<%
			rs = con.createStatement().executeQuery("SELECT * FROM ItemSubcategory;");
			while (rs.next()) {
				String cat = rs.getString("category");
				String sub = rs.getString("name");
			%>
				<option value="<%=cat%>/<%=sub%>"><%=cat%>/<%=sub%></option>
			<%
			}%>
		</select>
		<label>Search <input type="text" name="search"></label>
		<input type="submit" value="Search">
	</form>
</p><%

if(request.getParameter("removeError") != null) {%>
	<p>Error removing auction with ID: <%=request.getParameter("removeError")%></p><%
}%>

<table>

<%
String queryString = request.getQueryString();
String orderByString = "/buyme/6/auctions.jsp";
orderByString += "?orderBy=";

%>

	<tr>
		<th><a href="<%=orderByString%>title">Title</a></th>
		<th><a href="<%=orderByString%>auctioneer">Auctioneer</a></th>
		<th><a href="<%=orderByString%>closeTime">Close time</a></th>
	</tr><%
	
rs = con.createStatement().executeQuery("SELECT * FROM Auction WHERE winner IS NULL"+whereClause+orderByClasue+";");

while (rs.next()) {
	String id = rs.getString("id");
	String title = rs.getString("title");
	String category = rs.getString("category");
	String subcategory = rs.getString("subcategory");
	String auctioneer = rs.getString("auctioneer");
	String closeTime = Database.timestampString(rs.getTimestamp("closeTime"));
	
	if (search == null || title.toLowerCase().contains(search.toLowerCase())) {%>
		<tr>
			<td><a href="/buyme/6/auction.jsp?id=<%=id%>"><%=title%></a></td>
			<td><%=auctioneer%></td>
			<td><%=closeTime%></td>
		</tr><%
	}
}%>

</table><%

con.close();%>

</body>
</html>