<ul>
<li><a href="/buyme/">Home</a></li>

<%if (request.isUserInRole("admin")) {%>
<li><a href="/buyme/admin/customerRepAccounts.jsp">Customer Rep Accounts</a></li>
<li><a href="/buyme/admin/itemsEditor.jsp">Items Editor</a></li>
<%}%>

<%if (request.isUserInRole("user")) {%>
<li><a href="/buyme/user/dashboard.jsp">Dashboard</a></li>
<%}%>


<%if (request.isUserInRole("customerRep")) {%>
<li>link1</li>
<li>link2</li>
<%}%>

<li><a href="/buyme/logout">Logout</a></li>
</ul>