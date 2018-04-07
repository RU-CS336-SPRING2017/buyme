<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Items Editor</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>


<h3>Categories</h3>

<form action="/buyme/admin/AddCategory" method="post">
<%if(request.getParameter("addError") != null) { %>
Error adding category: <%=request.getParameter("addError")%><br>
<%}%>
	Category: <input required type="text" name="category"> <br>
	<input type="submit" value="Add category">
</form>

<%
Database db = new Database();
Connection con = db.connect();
ResultSet rs = con.createStatement().executeQuery("SELECT name FROM ItemCategory;");
%>

<ul>
<%while(rs.next()) {%>
<%String name =  rs.getString("name");%>
<li><a href="/buyme/admin/itemsEditor.jsp?category=<%=name%>"><%=name%></a></li>
<%}%>
</ul>

<%
String category = request.getParameter("category");
if (category != null) {%>

<h3>Fields for category: <%=category%></h3>

<form action="/buyme/admin/AddCategoryField" method="post">
<%if(request.getParameter("fieldAddError") != null) { %>
Error adding category field: <%=request.getParameter("fieldAddError")%><br>
<%}%>
	Field: <input required type="text" name="field"> <br>
	<input type="hidden" value="<%=category%>" name="category">
	<input type="submit" value="Add field">
</form>

<%
rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "';");
%>

<ul>
<%while(rs.next()) {%>
<%String name =  rs.getString("name");%>
<li><%=name%></li>
<%}%>
</ul>

<%}

con.close();
%>
</body>
</html>