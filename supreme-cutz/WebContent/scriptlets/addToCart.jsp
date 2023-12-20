<%@ include file="../include/classes.jsp"%>
<%
String productId = (String)request.getParameter("id");

if (session.getAttribute("cart") == null) {
	List<String> cartItems = new ArrayList<>();
	cartItems.add(productId);
	
	session.setAttribute("cart", cartItems);

	// DEBUG
	/* System.out.println("Added cart items to session."); */
} else {
	List<String> cartItems = (ArrayList<String>)session.getAttribute("cart");
	
	if (!cartItems.contains(productId)) {
    	cartItems.add(productId);
    	
    	session.setAttribute("cart", cartItems);

		// DEBUG
    	/* System.out.println("Updated cart."); */
	}
}
%>