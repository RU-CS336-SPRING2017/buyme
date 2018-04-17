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
ResultSet rs = null;


    
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sales Report</title>
</head>
<body>
<jsp:include page="/WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>Sales Report</h1>
<%
rs = con.createStatement().executeQuery("SELECT SUM(winningBid) sum FROM Auction WHERE winningBid IS NOT NULL;");
rs.next();
String str = rs.getString("sum");
String totalEarnings = "$";
if (str == null) {
	totalEarnings += "0.00";
} else {
	totalEarnings += str;
}

%>

<h3>Total Earnings: <%=totalEarnings%></h3>

<ul>
	<li>Earnings per subcategory
		<ul><%
			rs = con.createStatement().executeQuery("SELECT SUM(winningBid) sum, category, subcategory FROM Auction WHERE winningBid IS NOT NULL GROUP BY category, subcategory;");
			while (rs.next()) {
				String category = rs.getString("category");
				String subcategory = rs.getString("subcategory");
				String earnings = rs.getString("sum");%>
				<li><%=category%>/<%=subcategory%>: $<%=earnings%></li><%
			}%>
		</ul>
	</li>
	<li>Earnings per auctioneer
		<ul><%
			rs = con.createStatement().executeQuery("SELECT SUM(winningBid) sum, auctioneer FROM Auction WHERE winningBid IS NOT NULL GROUP BY auctioneer;");
			while (rs.next()) {
				String auctioneer = rs.getString("auctioneer");
				String earnings = rs.getString("sum");%>
				<li><%=auctioneer%>: $<%=earnings%></li><%
			}%>
		</ul>
	</li>
	<li>Total purchased by user
		<ul><%
			rs = con.createStatement().executeQuery("SELECT SUM(winningBid) sum, winner FROM Auction WHERE winningBid IS NOT NULL GROUP BY winner;");
			while (rs.next()) {
				String winner = rs.getString("winner");
				String earnings = rs.getString("sum");%>
				<li><%=winner%>: $<%=earnings%></li><%
			}%>
		</ul>
	</li>
	<li> Best
		<ul>
			<li>Items
				<ul><%
					rs = con.createStatement().executeQuery("SELECT category, subcategory FROM Auction WHERE winningBid=(SELECT MAX(sum) FROM (SELECT SUM(winningBid) sum, category, subcategory FROM Auction WHERE winningBid IS NOT NULL GROUP BY category, subcategory) AS T1)");
					while (rs.next()) {
						String category = rs.getString("category");
						String subcategory = rs.getString("subcategory");%>
						<li><%=category%>/<%=subcategory%></li><%
					}%>
				</ul>
			</li>
			<li>Sellers
				<ul><%
					rs = con.createStatement().executeQuery("SELECT auctioneer FROM Auction WHERE winningBid=(SELECT MAX(sum) FROM (SELECT SUM(winningBid) sum, auctioneer FROM Auction WHERE winningBid IS NOT NULL GROUP BY auctioneer) AS T1)");
					while (rs.next()) {
						String auctioneer = rs.getString("auctioneer");%>
						<li><%=auctioneer%></li><%
					}%>
				</ul>
			</li>
			<li>Buyers
				<ul><%
					rs = con.createStatement().executeQuery("SELECT winner FROM Auction WHERE winningBid=(SELECT MAX(sum) FROM (SELECT SUM(winningBid) sum, winner FROM Auction WHERE winningBid IS NOT NULL GROUP BY winner) AS T1)");
					while (rs.next()) {
						String winner = rs.getString("winner");%>
						<li><%=winner%></li><%
					}%>
				</ul>
			</li>
		</ul>
	</li>
</ul>

</body>
</html><%

con.close();%>