<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Compose Message</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Compose Message</h1>

<form action="/buyme/6/SendMessage" method="post">
	<label>To: <input required type="text" name="receivedBy"></label> <br>
	<label>Subject: <input required type="text" name="subject"></label> <br>
	<label>Message: <textarea name="text"></textarea></label> <br>
	<input type="submit" value="Send message">
</form>

</body>
</html>