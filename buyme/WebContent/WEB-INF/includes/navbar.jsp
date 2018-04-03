<ul>
<li>Home</li>
<li><a href="/buyme/user/dashboard.jsp">Dashboard</a></li>
<%if (request.isUserInRole("admin")) { %>
<li>Customer Rep Accounts</li>
<%}%>
<li>link1</li>
<li>link2</li>
<li><a href="/buyme/logout">Logout</a></li>
</ul>