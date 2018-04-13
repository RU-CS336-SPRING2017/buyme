<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Compose Message</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>
<h2><u>Compose Message</u></h2>

<%if(request.getParameter("addError") != null) {%>
	No such user: <%=request.getParameter("addError")%><%}%><br>

<%if (request.getParameter("sentBy") != null) {%>
<form action="/buyme/messages/Compose?sentBy=<%=request.getParameter("sentBy")%>&receivedBy=<%=request.getParameter("sentBy")%>&" method="post">
To: <%=request.getParameter("sentBy") %><br>
Subject: <input required type="text" name="subject"><br>
<textarea required name="text" cols="40" rows="5"></textarea><br>
<input type="submit" value="Send"></form><%} 

else{%>
<form action="/buyme/messages/Compose?sentBy=<%=request.getUserPrincipal().getName()%>&" method="post">
To: <input required type="text" name="receivedBy"><br>
Subject: <input required type="text" name="subject"><br>
<textarea required name="text" cols="40" rows="5"></textarea><br>
<input type="submit" value="Send"></form><%}%>

<form action="/buyme/messages/messages.jsp">
<input type="submit" value="My messages"></form>
</body>
</html>