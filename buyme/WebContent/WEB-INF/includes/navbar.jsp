<ul>
<li><a href="/buyme/">Home</a></li>

<%if (request.isUserInRole("admin")) {%>
<li><a href="/buyme/admin/customerRepAccounts.jsp">Customer Rep Accounts</a></li>
<li><a href="/buyme/admin/itemsEditor.jsp">Items Editor</a></li>
<%}%>

<%if (request.isUserInRole("user") || request.isUserInRole("customerRep")) {%>
<li><a href="/buyme/6/auctions.jsp">Auctions</a></li>
<li><a href="/buyme/6/messages.jsp">Messages</a></li>
<%}%>

<%if (request.isUserInRole("user")) {%>
<li><a href="/buyme/user/myAuctions.jsp">My Auctions</a></li>
<li><a href="/buyme/user/account.jsp">Account</a></li>
<li><a href="/buyme/user/alerts.jsp">Alerts</a></li>
<%}%>


<%if (request.isUserInRole("customerRep")) {%>
<li><a href="/buyme/customerRep/users.jsp">Users</a></li>
<%}%>

<li><a href="/buyme/logout">Logout</a></li>
</ul>