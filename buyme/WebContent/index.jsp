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
<title>BuyMe</title>
</head>
<body>
<jsp:include page="WEB-INF/includes/navbar.jsp"></jsp:include>

<h1>BuyMe</h1>

<%
if (request.isUserInRole("admin")) {
%>

<p>Admin accounts have a number of responsibilities that include:</p>
<ol>
<li>Creating customer representative accounts, as well as removing them if need be.</li>
<li>Creating and modifying categories of the items which BuyMe allows users to sell/buy.</li>
<li>View BuyMe reports such as earnings per subcategory and auctioneer, total purchased by users, and best items, sellers,
and buyers.</li>
</ol>
<p>HOW TO ‘Items Editor’: By accessing the ‘Items Editor’ in the navigation bar, the Admin can define an abstract category of item
that BuyMe will offer Users to buy and sell. After declaring the name of the category, click on the category
to create subcategories for the category(required). You may add dynamic fields to the category to properly describe the category.
You also have the option to click on the subcategories to add more dynamic description fields specific to the subcategory.</p>

<%
} else if (request.isUserInRole("customerRep")) {
%>

<p>Customer Representative accounts function as aids to users and their responsibilities include:</p>
<ol>
<li>Managing auctions and their bids: Customer Reps are incharge of all auctions on BuyMe. They have the power to delete
any User created auction, as well as delete bids on that acution.</li>
<li>Answer questions asked by Users.</li>
<li>Reset passwords for Users.</li>
</ol>
<p>The Customer Rep has full access to the messaging system and may send/recieve messages from Users or other Customer Reps.</p>

<%
} else if (request.isUserInRole("user")) {
%>

<p>Users are able to enjoy all the feature of BuyMe when they navigate through the nav bar. These features are:</p>
<ol>
<li>Viewing all auctions posted by the User, and other users in the ‘Auctions’ tab. By clicking on an auction, the User
is able to see information about an item, along with start/end times for the auction, minimum bid price, and bid history.
If the User is viewing their own auction, they have to option of delete it. The User may also place bids on the item.
When biding, the User may choose manual or automatic biding. Manually place a bid by entering the amount you want to bid.
When automatically biding, choose the bid increment you want to bid by, and sit back to relax.</li>
<li>Using the messages feature to message sellers, of Customer Reps. Also, Users recieve notifictions on their auctions and
other auctions they bid on through this feature.</li>
<li>Any question that a User has may be asked through the ‘Questions’ tab. The question will be forwarded to Customer Reps to
answer.</li>
<li>The User may view their posted auction in the ‘My Auctions’ tab.</li>
<li>In the ‘Alerts’ tab, the User may set alerts on auctions of interest. The alert will send the User a message when a
particualar auction has appeared.</li>
<li>In ‘Accounts’ tab, the User may delete their account.</li>
</ol>

<%
}
%>

</body>
</html>