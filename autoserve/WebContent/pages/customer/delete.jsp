<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%
	String id = request.getParameter("d");

	String query = "DELETE FROM customer WHERE id='" + id + "'";
	Statement stat = conn.createStatement();

	stat.executeUpdate(query);
	
	response.sendRedirect("customers.jsp");
%>