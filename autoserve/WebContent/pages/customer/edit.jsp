<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>Edit Customer - AutoServer</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>

<body>
	<div class="container">
		<p><br/></p>
		<form action="update.jsp" method="post">
			<%
				String u = request.getParameter("u");
				int num = Integer.parseInt(u);
				
				String query = "SELECT * FROM customer WHERE id='" + num + "'";
				Statement stat = conn.createStatement();
				ResultSet rs = stat.executeQuery(query);
	
				while(rs.next()) {
			%>
			<input type="hidden" name="id" value="<%=rs.getString("id") %>">
		    <div class="form-group">
		        <label for="">First name</label>
		        <input type="text" class="form-control" name="first-name" value="<%=rs.getString("fname") %>" required>
		    </div>
		    <div class="form-group">
		        <label for="">Last name</label>
		        <input type="text" class="form-control" name="last-name" value="<%=rs.getString("lname") %>" required>
		    </div>
		    <div class="form-group">
		        <label for="">Email address</label>
		        <input type="email" class="form-control" name="email" placeholder="name@abc.com" value="<%=rs.getString("email") %>">
		    </div>
		    <div class="form-group">
		        <label for="">Contact #</label>
				<input type="tel" class="form-control" name="phone" pattern="[0-9]{7}" placeholder="#######" value="<%=rs.getString("contact_no") %>" aria-label="3-digit prefix" size="2" required/>
		    </div>
		    <%
				}
		    %>
			<button type="submit" class="btn btn-warning">Update</button>
			<a href="customers.jsp" class="btn btn-default">back</a>
		</form>
	</div>
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>