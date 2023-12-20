<%@ include file="../include/classes.jsp"%>
<%
if (session.getAttribute("order") != null) {
	session.removeAttribute("order");
}

if (session.getAttribute("cart") != null) {
	session.removeAttribute("cart");
}

response.sendRedirect("../index.jsp");
%>