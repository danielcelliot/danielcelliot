<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Customer List - AutoServer</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div class="container">
    	<p><br/></p>
        <div class="row">
            <div class="col-md-6">
                <h3>Customer List</h3>
            </div>
            <div class="col-md-6">
				<a href="customer-form.jsp" class="btn btn-primary">Add new customer</a>
				<a href="../dashboard/admin.jsp" class="btn btn-default">back</a>
            </div>
        </div>
        <p></p>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact #</th>
                    <th class="text-center">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
	                Statement stat = conn.createStatement();
	                String query = "select * from customer";
	                ResultSet rs = stat.executeQuery(query);
	
	                while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("id")%></td>
                    <td><%=rs.getString("fname")%> <%=rs.getString("lname")%></td>
                    <td><%=rs.getString("email")%></td>
                    <td><%=rs.getString("contact_no")%></td>
                    <td class="text-center">
                    	<a href='edit.jsp?u=<%=rs.getString("id")%>' class="btn btn-warning">Edit</a>
                    	<a href='delete.jsp?d=<%=rs.getString("id")%>' class="btn btn-danger">Delete</a>
                   	</td>
                </tr>
                <%
                	}
                %>
            </tbody>
        </table>
    </div>
    
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>