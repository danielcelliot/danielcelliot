<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Dashboard</title>
<style type="text/css">
	.modal {
	  display: none; /* Hidden by default */
	  position: fixed; /* Stay in place */
	  z-index: 1; /* Sit on top */
	  padding-top: 100px; /* Location of the box */
	  left: 0;
	  top: 0;
	  width: 100%; /* Full width */
	  height: 100%; /* Full height */
	  overflow: auto; /* Enable scroll if needed */
	  background-color: rgb(0,0,0); /* Fallback color */
	  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
	}
	
	/* Modal Content */
	.modal-content {
	  background-color: #fefefe;
	  margin: auto;
	  padding: 20px;
	  border: 1px solid #888;
	  width: 80%;
	}
	
	/* The Close Button */
	.close {
	  color: #aaaaaa;
	  float: right;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	  color: #000;
	  text-decoration: none;
	  cursor: pointer;
	}
</style>
</head>
<body>
	<c:import url="/job" />
	<c:set var="myJobs" value="${requestScope.jobList}" />
	
	<c:import url="/user" />
	<c:set var="myCustomers" value="${requestScope.customerList}" />
	
	<p style="color:red"><c:out value="${errorMsg}"></c:out></p>
	<p style="color:green"><c:out value="${successMsg}"></c:out></p>
	

	<h1>Hello, <c:out value = "${first_name}"/></h1>
	<br>

	<h1>Customer List</h1>
	<button id="new-user" onclick="displayUserModal()">Add new customer</button><br>
	<c:forEach var="customer" items= "${myCustomers}" varStatus="loop">
		${loop.count}<br>
		ID: ${customer.id}<br>
		Name: ${customer.firstName} ${customer.lastName}<br>
		Email: ${customer.email}<br>
		Contact: ${customer.contactNo}<br>
		<button>Edit</button>
		<button>Delete</button><br>
		<br>
	</c:forEach>
	
	<h1>Job List</h1>
	<button id="new-job" onclick="displayJobModal()">Add new job</button><br>
	<c:forEach var="job" items= "${myJobs}" varStatus="loop">
		${loop.count}<br>
		Job ID: ${job.id}<br>
		Customer: ${job.customerName}<br>
		Start: ${job.startDate}<br>
		End: ${job.endDate}<br>
		Status: ${job.jobStatus}<br>
		Mechanic: ${job.mechanicName}<br>
		<button>Edit</button>
		<button>Delete</button><br>
		<br>
	</c:forEach>
	
	<!-- Job Modal -->
	<div id="jobModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span id="close-job" class="close">&times;</span>
			<p>This is the Job Modal...</p>
		</div>
	</div>
	
	<!-- User Modal -->
	<div id="userModal" class="modal">
		<!-- Modal content -->
		<div class="modal-content">
			<span id="close-user" class="close">&times;</span>
			<!-- <p>This is the User Modal...</p> -->
			<h1>Add New Customer</h1>  
			<form action="<%=request.getContextPath()%>/user" method="post">
				<table>
					<tr><td>First Name:</td><td><input type="text" name="first-name" required/></td></tr>  
					<tr><td>Last Name:</td><td><input type="text" name="last-name" required/></td></tr>  
					<tr><td>Email:</td><td><input type="email" name="email"/></td></tr>  
					<tr>
						<td>Contact No.:</td>
						<td>
							<input name="tel1" type="tel" pattern="[0-9]{3}" placeholder="###" aria-label="3-digit prefix" size="2" required/>
							 - 
   							<input name="tel2" type="tel" pattern="[0-9]{4}" placeholder="####" aria-label="4-digit number" size="3" required/>
  						</td>
 					</tr>
					<tr><td colspan="2"><input type="submit" name="add-user" value="Add"/></td></tr>
				</table> 
			</form>
		</div>
	</div>

<script>
	// Get the modal
	var jobModal = document.getElementById("jobModal");
	var userModal = document.getElementById("userModal");
	
	// Get the link that opens the modal
	var jobLink = document.getElementById("new-job");
	var userLink = document.getElementById("new-user");
	
	// Get the <span> element that closes the modal
	var closeUser = document.getElementById("close-user");
	var closerJob = document.getElementById("close-job");
	
	// When the user clicks the button, open the modal 
	function displayJobModal() {
		jobModal.style.display = "block";
	}
	function displayUserModal() {
		userModal.style.display = "block";
	}
	
	// When the user clicks on <span> (x), close the modal
	closeUser.onclick = function() {
		userModal.style.display = "none";
	}
	closerJob.onclick = function() {
		jobModal.style.display = "none";
	}
	
	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
	  if (event.target == jobModal) {
	  	jobModal.style.display = "none";
	  }
	  if (event.target == userModal) {
	  	userModal.style.display = "none";
	  }
	}
</script>

</body>
</html>