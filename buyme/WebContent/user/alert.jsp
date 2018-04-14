<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%

Connection con = new Database().connect();
String user = request.getUserPrincipal().getName();
String category = request.getParameter("category");
String subcategory = request.getParameter("subcategory");
ResultSet rs = null;%>
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Alert/<%=subcategory%></title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1><a href="/buyme/user/alerts.jsp">Alerts</a>/<%=subcategory%></h1>

<h3>Specify a field</h3><%

if(request.getParameter("addError") != null) {%>
	<p>Error adding field</p><%
}

if(request.getParameter("removeError") != null) {%>
	<p>Error removing field</p><%
}%>

<p>
	<form action="AddAlertField" method="post">
		<input type="hidden" value="<%=category%>" name="category">
		<input type="hidden" value="<%=subcategory%>" name="subcategory">
		<select name="field"><%
			rs = con.createStatement().executeQuery("SELECT name FROM CategoryField WHERE category='" + category + "' AND (subcategory IS NULL OR subcategory='" + subcategory + "');");
			while (rs.next()) {
				String name = rs.getString("name");%>
				<option value="<%=name%>"><%=name%></option><%
			}%>
		</select>
		<label>Value: <input required type="text" name="value"></label>
		<input type="submit" value="Add field condition">
	</form>
</p>

<table>
	<tr>
		<th>Field</th>
		<th>Value</th>
	</tr><%
	rs = con.createStatement().executeQuery("SELECT field, value FROM AlertField WHERE user='"+user+"' AND category='"+category+"' AND subcategory='"+subcategory+"' AND user='"+user+"';");
	while (rs.next()) {
		String field = rs.getString("field");
		String value = rs.getString("value");%>
		<tr>
			<td><%=field%></td>
			<td><%=value%></td>
			<td><a href="/buyme/user/RemoveAlertField?category=<%=category%>&subcategory=<%=subcategory%>&field=<%=field%>">Delete</a></td>
		</tr><%
	}%>
</table>

</body>
</html><%

con.close();%>