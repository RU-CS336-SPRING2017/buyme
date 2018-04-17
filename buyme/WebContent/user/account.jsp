<!-- 
// Authors:
// - Ammaar Muhammad Iqbal
// - Kostyantyn Kashchanov
// - Michael Parrilla
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Acount</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Account</h1>

<h3><%=request.getUserPrincipal().getName()%></h3><%

if(request.getParameter("removeError") != null) {%>
	<p>Error creating auction: <%=request.getParameter("removeError")%></p><%
}%>

<a href="/buyme/5/RemoveAccount"><input type="button" value="Remove account"></a>

</body>
</html>