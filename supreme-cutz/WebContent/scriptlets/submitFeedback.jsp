<%@ include file="../../include/connect.jsp"%>
<%
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	Integer contactNo = Integer.parseInt(request.getParameter("phone"));
	String message = request.getParameter("message");
	
	PreparedStatement stat = null;

	String query = "INSERT INTO message_form VALUES (null,?,?,?,?)";
	stat = conn.prepareStatement(query);

	stat.setString(1, name);
	stat.setString(2, email);
	stat.setInt(3, contactNo);
	stat.setString(4, message);
	
	stat.executeUpdate();
	response.sendRedirect("../pages/contact-us.jsp?feedback=success");
%>