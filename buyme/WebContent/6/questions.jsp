<%@ page import="main.Database"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
Connection con = new Database().connect();
ResultSet rs = null;
boolean isUser = request.isUserInRole("user");
boolean isCustomerRep = request.isUserInRole("customerRep");%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Questions</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Questions</h1><%

if (isUser) {
	if (request.getParameter("askError") != null) {%>
		<p>Error asking question</p><%
	}%>
	<p>
		<form action="/buyme/user/AskQuestion" method="post">
			<textarea name="question"></textarea>
			<input type="submit" value="Ask">
		</form>
	</p><%
}%>

<h3>Unanswered Questions</h3><%

if (isCustomerRep) {

	if (request.getParameter("answerError") != null) {%>
		<p>Error answering question</p><%
	}%> 

	<table> 
	
		<tr>
			<th>Question</th>
			<th>Answer</th>
		</tr>

<%} else if (isUser) {%> <ul> <%}

rs = con.createStatement().executeQuery("SELECT question, id FROM Question WHERE answer IS NULL;");
while (rs.next()) {
	
	String question = rs.getString("question");
	long id = rs.getLong("id");
	
	if (isUser) {%> <li><%=question%></li> <%} else if (isCustomerRep) {%> 
		<tr>
			<td><%=question%></td>
			<td>
				<form action="/buyme/customerRep/AnswerQuestion" method="post">
					<input type="hidden" name="id" value="<%=id%>">
					<textarea name="answer"></textarea>
					<input type="submit" value="Answer">
				</form>
			</td>
		</tr><%
	}
}%>
	
<%if (isUser) {%> </ul> <%} else if (isCustomerRep) {%> </table> <%}%>

<h3>Answered Questions</h3>

<table>

	<tr>
		<th>Question</th>
		<th>Answer</th>
	</tr>

	<%
	rs = con.createStatement().executeQuery("SELECT * FROM Question WHERE answer IS NOT NULL;");
	while (rs.next()) {
		
		String question = rs.getString("question");
		String answer = rs.getString("answer");
		long id = rs.getLong("id");%>
		
		<tr>
			<td><%=question%></td>
			<td><%
				if (isUser) {%><%=answer%><%} else if (isCustomerRep) {%> 
					<form action="/buyme/customerRep/AnswerQuestion" method="post">
						<input type="hidden" name="id" value="<%=id%>">
						<textarea name="answer"><%=answer%></textarea>
						<input type="submit" value="Update">
					</form><%
				}%>
			</td>
		</tr><%
	}%>
	
</table>

</body>
</html><%

con.close();%>