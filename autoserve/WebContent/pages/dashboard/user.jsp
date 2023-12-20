<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Admin Dashboard - AutoServe</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
	<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div class="container">
    	<p><br/></p>
    	<h1>Hello, <c:out value = "${first_name}"/></h1>
    	<p><br/></p>
        <div class="row">
            <div class="col-md-6">
                <h3>Services List</h3>
            </div>
            <div class="col-md-6">
				<a class="fa fa-sign-out" aria-hidden="true" href="/AutoServe-demo/pages/logout.jsp"> Logout</a>
            </div>
        </div>
        <p></p>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>Service ID</th>
                    <th>Service Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Cost</th>
                </tr>
            </thead>
            <tbody>
                <%
            		String userId = (String)session.getAttribute("user_id");
                
                	String query = "SELECT a.service_id, b.name, a.start_date, a.end_date, a.status, b.cost\r\n" + 
                		"FROM service_tasks a, task b, service c\r\n" + 
                		"WHERE a.task_no = b.task_no AND a.service_id = c.service_id\r\n" + 
                		"AND c.customer_id = ?";
                	
                	PreparedStatement stat = conn.prepareStatement(query);
	                stat.setString(1, userId);
	                ResultSet rs = stat.executeQuery();
	
	                while (rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString("service_id")%></td>
                    <td><%=rs.getString("name")%></td>
                    <td><%=rs.getString("start_date")%></td>
                    <td><%=rs.getString("end_date")%></td>
                    <td><%=rs.getString("status")%></td>
                    <td><%=rs.getString("cost")%></td>
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