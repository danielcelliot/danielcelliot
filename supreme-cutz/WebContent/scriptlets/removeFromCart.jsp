<%@ include file="../include/classes.jsp"%>
<%
String productId = (String)request.getParameter("param1");

List<String> cartItems = (ArrayList<String>)session.getAttribute("cart");

cartItems.remove(productId);
session.setAttribute("cart", cartItems);

// DEBUG
System.out.println("Updated cart.");
%>