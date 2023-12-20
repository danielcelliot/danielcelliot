<%@ include file="../include/classes.jsp"%>
<%
String productId = (String)request.getParameter("id");
System.out.println("ProductID: " + productId);
String qty = (String)request.getParameter("qty");
System.out.println("Qty: " + qty);

LinkedHashMap<String, String> orderItems = new LinkedHashMap<String, String>();

if (session.getAttribute("order") != null) {
	orderItems = (LinkedHashMap<String, String>)session.getAttribute("order");
}

orderItems.put(productId, qty);
session.setAttribute("order", orderItems);

response.getWriter().write("success");

// DEBUG
/* Set<String> keys = orderItems.keySet();
for (String k:keys) {
	System.out.println(k + " -- " + orderItems.get(k));
} */
%>