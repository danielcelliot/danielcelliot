<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Add New Customer - AutoServer</title>
	<link href="../../css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
</head>

<body>
	<div class="container">
		<p><br/></p>
		<form action="add.jsp" method="post">
		    <div class="form-group">
		        <label for="">First name</label>
		        <input type="text" class="form-control" name="first-name" placeholder="" required>
		    </div>
		    <div class="form-group">
		        <label for="">Last name</label>
		        <input type="text" class="form-control" name="last-name" placeholder="" required>
		    </div>
		    <div class="form-group">
		        <label for="">Email address</label>
		        <input type="email" class="form-control" name="email" placeholder="name@abc.com">
		    </div>
		    <div class="form-group">
		        <label for="">Contact #</label>
		        <input type="tel" class="form-control" name="phone" pattern="[0-9]{7}" placeholder="#######" aria-label="3-digit prefix" size="2" required/>
		    </div>
			<button type="submit" class="btn btn-primary">Submit</button>
			<a href="customers.jsp" class="btn btn-default">back</a>
		</form>
	</div>
	<script type="text/javascript" src="../../js/bootstrap.min.js"></script>
</body>
</html>