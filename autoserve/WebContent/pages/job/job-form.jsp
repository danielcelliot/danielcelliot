<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Add New Job - AutoServer</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>

<body>
	<div class="container">
		<p><br/></p>
		<form action="add.jsp" method="post">
		
		    <div class="form-group">
		        <label for="">Clerk</label>
		        <%
					int loginId = (Integer)session.getAttribute("id");
					String clerkId;
		        	
					try	{
						
						PreparedStatement pst = conn.prepareStatement("select id from clerk where login_id=?");
						pst.setInt(1, loginId);
						
						ResultSet rs = pst.executeQuery();
						
						while(rs.next())
						{
							clerkId = rs.getString("id");
							//request.setAttribute("clerk_id", clerkId);
				%>
       				<input type="text" class="form-control" name="clerk" placeholder="" value="<%=clerkId%>" readonly required>
       			<%
						}
						
					} catch(Exception e) {
						out.print(e);
					}
				%>
		    </div>
		    <div class="form-group">
		        <label for="">Date</label>
		        <input type="date" class="form-control" name="date" placeholder="" required>
		    </div>
		    <div class="form-group">
		        <label for="">Customer</label>
		        <select name="customer">
		        	<%
		        		HashMap<String, Integer> customers = new HashMap<String, Integer>();
		        		
						try	{
							
							PreparedStatement pst = conn.prepareStatement("select id, concat(fname, ' ', lname) as name from customer");
							ResultSet rs = pst.executeQuery();
							
							while(rs.next())
							{
								customers.put(rs.getString("name"), Integer.parseInt(rs.getString("id")));
							}
							
							//request.setAttribute("customers", customers);
							
						} catch(Exception e) {
							out.print(e);
						}
						
						for (Map.Entry<String, Integer> entry : customers.entrySet()) {
					%>
						<option value="<%= entry.getValue()%>"><%= entry.getKey()%></option>
					<%
						}
					%>
				</select>
		    </div>
		    <div class="form-group">
		        <label for="">Vehicle</label>
				<select name="vehicle">
		        	<%
		        		//String licenseNo;
		        		HashMap<String, Integer> vehicles = new HashMap<String, Integer>();
		        		
						try	{
							
							PreparedStatement pst = conn.prepareStatement("select vehicle_no, license_no from vehicle");
							ResultSet rs = pst.executeQuery();
							
							while(rs.next())
							{
								vehicles.put(rs.getString("license_no"), Integer.parseInt(rs.getString("vehicle_no")));
							}
							
							//request.setAttribute("vehicles", vehicles);
							
						} catch(Exception e) {
							out.print(e);
						}
						
						for (Map.Entry<String, Integer> entry : vehicles.entrySet()) {
					%>
						<option value="<%= entry.getValue()%>"><%= entry.getKey()%></option>
					<%
						}
					%>
				</select>
		    </div>
			<button type="submit" class="btn btn-primary">Submit</button>
			<a href="jobs.jsp" class="btn btn-default">back</a>
			
		</form>
	</div>
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>