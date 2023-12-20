<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%
	String firstName = request.getParameter("first-name");
	String lastName = request.getParameter("last-name");
	String email = request.getParameter("email");
	Integer contactNo = Integer.parseInt(request.getParameter("phone"));

	String query = "INSERT INTO customer VALUES (null,?,?,?,?,null)";
	PreparedStatement stat = conn.prepareStatement(query);

	stat.setString(1, firstName);
	stat.setString(2, lastName);
	stat.setString(3, email);
	stat.setInt(4, contactNo);
	stat.executeUpdate();
	
	response.sendRedirect("customers.jsp");
%>