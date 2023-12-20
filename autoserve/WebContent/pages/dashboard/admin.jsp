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
    	<div class="row">
            <div class="col-md-6">
				<h1>Hello, <c:out value="${first_name}"/></h1>
            </div>
            <div class="col-md-6">
				<a class="fa fa-sign-out" aria-hidden="true" href="/AutoServe-demo/pages/logout.jsp"> Logout</a>
            </div>
        </div>
    	
    	<p><br/></p>
        <div class="row">
            <div class="col-md-6">
				<a href="../customer/customers.jsp" class="btn btn-primary">View Customers</a>
            </div>
            <div class="col-md-6">
				<a href="../job/jobs.jsp" class="btn btn-primary">View Jobs</a>
            </div>
        </div>
    </div>
    
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>