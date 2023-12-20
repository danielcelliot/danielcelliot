<%@ include file="../include/connect.jsp"%>
<%
String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
Pattern pattern = Pattern.compile(regex);

String email = request.getParameter("email");
Matcher matcher = pattern.matcher(email);

if (matcher.matches()) {	
	String query = "select * from customer where email ='" + email + "'";
	Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(query);
    
    if (rs.isBeforeFirst() ) {
    	response.getWriter().write("email_exists");
	} else {
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String password = request.getParameter("password");

		query = "INSERT INTO customer (customer_id,fname,lname,email,password,reg_date) VALUES (null,?,?,?,?,now())";
		PreparedStatement stat = conn.prepareStatement(query);

		stat.setString(1, firstname);
		stat.setString(2, lastname);
		stat.setString(3, email);
		stat.setString(4, password);
		stat.executeUpdate();

		response.getWriter().write("../pages/login.jsp?signup=success");
	}
} else {
	response.getWriter().write("email_error");
}
%>