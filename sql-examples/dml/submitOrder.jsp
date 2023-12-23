<%@ include file="../include/connect.jsp"%>
<%
String customerId = (String)session.getAttribute("customer_id");
String address = (String)request.getParameter("address");
String city = (String)request.getParameter("city");
String contactNo = (String)request.getParameter("contact_no");
String delivery = (String)request.getParameter("delivery_info");
String cardNo = (String)request.getParameter("card_no");
String total = (String)request.getParameter("total");
String status = "Processing";

// DEBUG
System.out.println("CustomerID: " + customerId + ", Address: " + address + ", City: " + city + ", Phone: " + contactNo + ", Del: " + delivery + ", Card#: " + cardNo + ", Total: " + total);

Boolean success = false;

// for inserting a new order
PreparedStatement pstmt = null;

// for assigning products & qty to order
PreparedStatement pstmtAssignment = null;

// for assigning stock amount to product
PreparedStatement pstmtUpdate = null;

// for getting order id
ResultSet rs = null;

try {
	// Set auto commit to false
	conn.setAutoCommit(false);
	
	// Insert order query
	String sqlInsert = "INSERT INTO orders(customer_id,date,address,city,contact_no,delivery_info,card_no,total,status) VALUES(?,now(),?,?,?,?,?,?,?)";

	pstmt = conn.prepareStatement(sqlInsert,Statement.RETURN_GENERATED_KEYS);
	
	Integer id = Integer.parseInt(customerId);
	Float tot = Float.parseFloat(total);

	pstmt.setInt(1, id);
	pstmt.setString(2, address);
	pstmt.setString(3, city);
	pstmt.setString(4, contactNo);
	pstmt.setString(5, delivery);
	pstmt.setString(6, cardNo);
	pstmt.setFloat(7, tot);
	pstmt.setString(8, status);

	int ordersUpdated = pstmt.executeUpdate();

	// Get order id
	int orderId = 0;
	rs = pstmt.getGeneratedKeys();
	if (rs.next()) {
		orderId = rs.getInt(1);
	}
	
	// If the insert operation succeeds, assign products & qty to order
	if (ordersUpdated == 1) {
		// DEBUG
		System.out.println("Success! Orders table updated.");

		String sqlPivot = "INSERT INTO order_products(order_id,product_id,qty) VALUES(?,?,?)";
		
		pstmtAssignment = conn.prepareStatement(sqlPivot);
		
		LinkedHashMap<String, String> orderItems = (LinkedHashMap<String, String>)session.getAttribute("order");
    	Set<String> keys = orderItems.keySet();
    	for (String k:keys) {
    		Integer qty = Integer.parseInt(orderItems.get(k));
            Integer productId = Integer.parseInt(k);
    		
			pstmtAssignment.setInt(1, orderId);
			pstmtAssignment.setInt(2, productId);
			pstmtAssignment.setInt(3, qty);
			
			int orderProductsUpdated = pstmtAssignment.executeUpdate();

			if (orderProductsUpdated == 1) {
				// DEBUG
				System.out.println("Success! Order_products table updated.");

				String query = "select * from product where product_id=" + productId + "";
				Statement stmt = conn.createStatement();
				ResultSet result = stmt.executeQuery(query);
				
				int stockAmt = 0;
				if (result.next()) {
					stockAmt = result.getInt("stock_amt");
				}

				int newStockAmt = stockAmt - qty;
				String sqlUpdate = "update product set stock_amt=? where product_id=?";
				pstmtUpdate = conn.prepareStatement(sqlUpdate);

				pstmtUpdate.setInt(1, newStockAmt);
				pstmtUpdate.setInt(2, productId);

				int productUpdated = pstmtUpdate.executeUpdate();

				if (productUpdated == 1) {
					// DEBUG
					System.out.println("Success! Product table updated.");

					conn.commit();
					success = true;
				} else {
					conn.rollback();
				}
			} else {
				conn.rollback();
			}
    	}

    	if (success) {
    		response.getWriter().write("success");
    	} else {
    		response.sendRedirect("../pages/checkout.jsp");
    	}
	} else {
		conn.rollback();
	}
} catch (SQLException ex) {
	// roll back the transaction
	try {
		if (conn != null) {
			conn.rollback();
		}
	} catch (SQLException e){
		System.out.println(e.getMessage());
	}
	System.out.println(ex.getMessage());
	
} finally {
	try {
		if (rs != null)  rs.close();
		if (pstmt != null) pstmt.close();
		if (pstmtAssignment != null) pstmtAssignment.close();
		if (pstmtUpdate != null) pstmtUpdate.close();
		if (conn != null) conn.close();

	} catch (SQLException e) {
		System.out.println(e.getMessage());
	}
}
%>