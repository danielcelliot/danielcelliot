<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Jobs List - AutoServer</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>
<body>
	<c:import url="/job" />
	<c:set var="myJobs" value="${requestScope.jobList}" />
	
    <div class="container">
    	<p><br/></p>
        <div class="row">
            <div class="col-md-6">
                <h3>Job List</h3>
            </div>
            <div class="col-md-6">
				<a href="job-form.jsp" class="btn btn-primary">Add new job</a>
				<a href="../dashboard/admin.jsp" class="btn btn-default">back</a>
            </div>
        </div>
        <p></p>
        <table class="table table-bordered table-hover">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Date</th>
                    <th>Customer</th>
                    <th>Vehicle</th>
                    <th>License #</th>
                    <th>Issued By</th>
                </tr>
            </thead>
            <tbody>
	            <c:forEach var="job" items= "${myJobs}" varStatus="loop">
	                <tr>
	                    <td>${job.id}</td>
	                    <td>${job.date}</td>
	                    <td>${job.customerName}</td>
	                    <td>${job.vehicle}</td>
	                    <td>${job.licenseNo}</td>
	                    <td>${job.clerkName}</td>
	                </tr>
				</c:forEach>
            </tbody>
        </table>
		
    </div>
    
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>