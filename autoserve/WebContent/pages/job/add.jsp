<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%
	String date = request.getParameter("date");
	String customerId = request.getParameter("customer");
	//String clerkId = (String)request.getAttribute("clerk_id");
	String clerkId = request.getParameter("clerk");
	String vehicle_no = request.getParameter("vehicle");

	String query = "INSERT INTO service (service_id,date,customer_id,clerk_id,vehicle_no) VALUES (null,?,?,?,?)";
	PreparedStatement stat = conn.prepareStatement(query);

	stat.setString(1, date);
	stat.setString(2, customerId);
	stat.setString(3, clerkId);
	stat.setString(4, vehicle_no);
	stat.executeUpdate();
	
	response.sendRedirect("jobs.jsp");
%>