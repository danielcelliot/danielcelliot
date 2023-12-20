<%@ include file="../include/connect.jsp"%>
<%
boolean status = false;

String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
Pattern pattern = Pattern.compile(regex);

String email = request.getParameter("email");
Matcher matcher = pattern.matcher(email);

if (matcher.matches()) {
	String query = "select * from customer where email = ? and password = ?";
	PreparedStatement stat = conn.prepareStatement(query);

	stat.setString(1, email);
	stat.setString(2, request.getParameter("password"));

	ResultSet rs = stat.executeQuery();
	   
	while (rs.next()) {
	   	status = true;
	   	session.setAttribute("customer_id", rs.getString("customer_id"));
	   	session.setAttribute("customer_reg_date", rs.getString("reg_date"));
	   	session.setAttribute("firstname", rs.getString("fname"));
	   	session.setAttribute("lastname", rs.getString("lname"));
	   	session.setAttribute("contact_no", rs.getString("contact_no"));
	}

	if (status) {
		if (session.getAttribute("checkout") == null) {
			response.getWriter().write("../pages/customer-login.jsp");
		} else {
			session.removeAttribute("checkout");
			response.getWriter().write("../pages/checkout.jsp");
		}
	} else {
		response.getWriter().write("login_error");
	}
} else {
	response.getWriter().write("email_error");
}
%>