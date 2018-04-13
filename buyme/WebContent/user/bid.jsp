<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
String type = request.getParameter("type");
String auction = request.getParameter("auction");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bid</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Bid</h1><%

if (type != null && type.equals("auto")) {%>
<%
} else if (type != null && type.equals("manual")) {%>

	<form action="/buyme/user/Bid" method="post">
		<label>Amount: <input type="text" name="amount"></label>
		<input type="hidden" name="type" value="manual">
		<input type="hidden" name="auction" value="<%=auction%>">
		<input type="submit" value="Bid">
	</form><%

} else {%>
	<h3>Choose a bid type</h3>	
	<ul>
		<li><a href="/buyme/user/bid.jsp?auction=<%=auction%>&type=manual">Manual</a></li>
		<li><a href="/buyme/user/bid.jsp?auction=<%=auction%>&type=auto">Auto</a></li>
	</ul><%
}%>

</body>
</html>