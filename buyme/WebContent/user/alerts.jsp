<!-- 
// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla
 -->

<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%

Connection con = new Database().connect();
String user = request.getUserPrincipal().getName();
ResultSet rs = null;%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Alerts</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Alerts</h1><%

if(request.getParameter("addError") != null) {%>
	<p>Error adding alert</p><%
}

if(request.getParameter("removeError") != null) {%>
	<p>Error removing alert</p><%
}%>

<p>
	<form action="/buyme/user/AddAlert" method="post">
		<select required name="subcategroy">
			<%
			rs = con.createStatement().executeQuery("SELECT * FROM ItemSubcategory;");
			while (rs.next()) {
				String category = rs.getString("category");
				String subcategory = rs.getString("name");
				
				%>
				<option value="<%=category%>/<%=subcategory%>"><%=category%>/<%=subcategory%></option>
				<%
			}
			%>
		</select>
		<input type="submit" value="Add alert">
	</form>
</p>

<ul><%
	
	rs = con.createStatement().executeQuery("SELECT * FROM Alert WHERE user='" + user + "';");
	while (rs.next()) {
		
		String category = rs.getString("category");
		String subcategory = rs.getString("subcategory");%>
		
		<li>
			<a href="/buyme/user/alert.jsp?category=<%=category%>&subcategory=<%=subcategory%>">
				<%=category%>/<%=subcategory%>
			</a>
			<a href="/buyme/user/RemoveAlert?category=<%=category%>&subcategory=<%=subcategory%>"><input type="button" value="Delete"></a>
		</li><%
	}%>
	
</ul>

</body>
</html><%

con.close();%>