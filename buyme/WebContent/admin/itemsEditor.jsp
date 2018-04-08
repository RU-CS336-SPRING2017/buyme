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

<%
Database db = new Database();
Connection con = db.connect();
String category = request.getParameter("category");
String subcategory = request.getParameter("subcategory");
if (category == null) {%>

	<h3>Categories</h3>
	
	<form action="/buyme/admin/AddCategory" method="post">
	<%if(request.getParameter("addError") != null) { %>
	Error adding category: <%=request.getParameter("addError")%><br>
	<%}%>
		Category: <input required type="text" name="category"> <br>
		<input type="submit" value="Add category">
	</form>
	
	<%
	ResultSet rs = con.createStatement().executeQuery("SELECT name FROM ItemCategory;");
	%>
	
	<ul>
	<%while(rs.next()) {%>
	<%String name =  rs.getString("name");%>
	<li><a href="/buyme/admin/itemsEditor.jsp?category=<%=name%>"><%=name%></a></li>
	<%}%>
	</ul>

<%} else if (category != null && subcategory == null) {%>

	<h3><a href="/buyme/admin/itemsEditor.jsp">Categories</a>/<%=category%></h3>
	
	<%if (request.getParameter("categoryRemoveError") != null) {%>
	Error removing category
	<%}%>
	
	<a href="/buyme/admin/RemoveCategory?category=<%=category%>"><input type="button" value="Remove category"></a>
	
	<h4>Fields</h4>
	
	<form action="/buyme/admin/AddCategoryField" method="post">
	<%if(request.getParameter("fieldAddError") != null) { %>
	Error adding field: <%=request.getParameter("fieldAddError")%><br>
	<%}%>
		Field: <input required type="text" name="field"> <br>
		<input type="hidden" value="<%=category%>" name="category">
		<input type="submit" value="Add field">
	</form>
	
	<%
	ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' and subcategory IS NULL;");
	%>
	
	<%if(request.getParameter("fieldRemoveError") != null) { %>
	Error removing field: <%=request.getParameter("fieldRemoveError")%><br>
	<%}%>
	
	<ul>
	<%while(rs.next()) {%>
	<%String name =  rs.getString("name");%>
	<li><%=name%></li> <a href="/buyme/admin/RemoveCategoryField?category=<%=category%>&field=<%=name%>"><input type="button" value="Delete"></a>
	<%}%>
	</ul>
	
	<h4>Subcategories</h4>
	
	<form action="/buyme/admin/AddSubcategory" method="post">
	<%if(request.getParameter("subcategoryAddError") != null) { %>
	Error adding subcategory: <%=request.getParameter("subcategoryAddError")%><br>
	<%}%>
		Subcategory: <input required type="text" name="subcategory"> <br>
		<input type="hidden" value="<%=category%>" name="category">
		<input type="submit" value="Add subcategory">
	</form>
	
	<%
	rs = con.createStatement().executeQuery("SELECT name FROM ItemSubcategory WHERE category='" + category + "';");
	%>
	
	<ul>
	<%while(rs.next()) {%>
	<%String name =  rs.getString("name");%>
	<li><a href="/buyme/admin/itemsEditor.jsp?category=<%=category%>&subcategory=<%=name%>"><%=name%></a></li>
	<%}%>
	</ul>

<%} else {%>

	<h3><a href="/buyme/admin/itemsEditor.jsp">Categories</a>/<a href="/buyme/admin/itemsEditor.jsp?category=<%=category%>"><%=category%></a>/<%=subcategory%></h3>
	
	<%if (request.getParameter("subcategoryRemoveError") != null) {%>
	Error removing subcategory
	<%}%>
	
	<a href="/buyme/admin/RemoveSubategory?category=<%=category%>&subcategory=<%=subcategory%>"><input type="button" value="Remove subcategory"></a>
	
	<h4>Inherited Fields</h4>
	
	<%
	ResultSet rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' and subcategory IS NULL;");
	%>
	
	<ul>
	<%while(rs.next()) {%>
	<%String name =  rs.getString("name");%>
	<li><%=name%></li>
	<%}%>
	</ul>
	
	<h4>Fields</h4>
	
	<form action="/buyme/admin/AddSubategoryField" method="post">
	<%if(request.getParameter("subcategoryFieldAddError") != null) { %>
	Error adding field: <%=request.getParameter("subcategoryFieldAddError")%><br>
	<%}%>
		Field: <input required type="text" name="field"> <br>
		<input type="hidden" value="<%=category%>" name="category">
		<input type="hidden" value="<%=subcategory%>" name="subcategory">
		<input type="submit" value="Add field">
	</form>
	
	<%
	rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND subcategory='" + subcategory + "';");
	%>
	
	<%if(request.getParameter("fieldRemoveError") != null) { %>
	Error removing field: <%=request.getParameter("fieldRemoveError")%><br>
	<%}%>
	
	<ul>
	<%while(rs.next()) {%>
	<%String name =  rs.getString("name");%>
	<li><%=name%></li> <a href="/buyme/admin/RemoveSubcategoryField?category=<%=category%>&subcategory=<%=subcategory%>&field=<%=name%>"><input type="button" value="Delete"></a>
	<%}%>
	</ul>

<%}
con.close();%>
</body>
</html>