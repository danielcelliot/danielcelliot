<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../include/connect.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
if (session.getAttribute("customer_id") == null) {
	request.getRequestDispatcher("./login.jsp").forward(request, response);
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice - Supreme Cutz Barbershop</title>
    <link rel="stylesheet" href="../css/invoice.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="../favicon.ico" type="image/x-icon">
</head>
<body>
    <div class="logo-container">
        <%-- <svg class="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
        <svg id="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 396.876 251.438">
            <title>brand-logo-name</title>
            <g id="supreme">
                <path d="M114.284,525.527a2.557,2.557,0,0,1-.715,1.875,2.494,2.494,0,0,1-1.863.727h-9.234a2.575,2.575,0,0,1-1.887-.727,2.515,2.515,0,0,1-.738-1.875v-9.3H103.1v9.023h7.922V516.5L100.9,504.27a4.26,4.26,0,0,1-1.054-2.79v-7.429a2.515,2.515,0,0,1,.738-1.875,2.575,2.575,0,0,1,1.887-.727h9.234a2.494,2.494,0,0,1,1.863.727,2.557,2.557,0,0,1,.715,1.875v8.531h-3.258v-8.25H103.1v7.734L113.276,514.3a4.189,4.189,0,0,1,1.008,2.742Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M148.7,525.527a2.512,2.512,0,0,1-.739,1.875,2.574,2.574,0,0,1-1.886.727h-9.985a2.489,2.489,0,0,1-2.6-2.6V491.449h3.258v33.8h8.7v-33.8H148.7Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M182.531,510.949a2.527,2.527,0,0,1-2.625,2.625h-8.648v14.555H168v-36.68h11.906a2.575,2.575,0,0,1,1.887.727,2.515,2.515,0,0,1,.738,1.875Zm-3.258-.281V494.332h-8.015v16.336Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M216.737,528.129h-3.422l-6.82-19.641.445-.656h5.812v-13.5h-8.367v33.8h-3.258v-36.68h12.282a2.489,2.489,0,0,1,2.6,2.6v13.922q0,2.647-3.562,2.648c-.235,0-.578-.012-1.031-.035s-.782-.035-.985-.035Q213.6,519.317,216.737,528.129Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M247.1,528.129H235.052v-36.68h11.906v2.883H238.31V508.02h7.875v2.929H238.31v14.3H247.1Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M283.766,528.129H280.7V504.9q0-.492.328-2.882l-6,22.664h-.656l-6-22.664q.329,2.414.328,2.882v23.227h-3.07v-36.68h3.023l5.954,23.86a8.423,8.423,0,0,1,.093,1.054,8.858,8.858,0,0,1,.094-1.054l5.953-23.86h3.024Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M315.111,528.129H303.064v-36.68h11.907v2.883h-8.649V508.02H314.2v2.929h-7.875v14.3h8.789Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
            </g>
            <g id="cutz">
                <path d="M395.043,524.777q0,3.352-3.352,3.352H380.254q-3.258,0-3.258-3.352V494.824q0-3.375,3.258-3.375h11.437q3.353,0,3.352,3.375V503.4h-5.461V496.16h-7.1v27.258h7.1v-7.711h5.461Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M431.146,524.777q0,3.352-3.375,3.352H416.123q-3.329,0-3.328-3.352V491.449h5.484v31.969h7.383V491.449h5.484Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M464.931,496.3h-6.047v31.828h-5.461V496.3h-6.047v-4.852h17.555Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
                <path d="M496.723,528.129H479.871V525.2l10.266-28.8h-9.446v-4.946h15.985v3.164l-10.242,28.571h10.289Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
            </g>
            <g id="separator">
                <path d="M349.476,535.728h-4.571V480.181h4.571Z" transform="translate(-99.847 -284.29)" style="fill: #ed1c24"/>
            </g>
            <rect id="SC-box" x="104.468" y="6.5" width="187.416" height="153.352" style="fill: none;stroke: #231f20;stroke-miterlimit: 10;stroke-width: 13px"/>
            <g id="s">
                <path d="M291.129,409.079q0,8.939-8.876,8.937l-29.437,0q-8.812,0-8.812-8.938V385.764H258.63V405.7l17.875,0V386.516L247.2,358.764a10.359,10.359,0,0,1-3.187-7.813V329.2q0-9,8.813-9l29.438,0q8.874,0,8.874,8.875v21.875H276.508V332.516H258.634V350.2l29.31,27.627a10.388,10.388,0,0,1,3.187,7.938Z" transform="translate(-99.847 -284.29)" style="fill: #231f20"/>
            </g>
            <g id="c">
                <path d="M352.133,409.077q0,8.938-8.938,8.937H312.7q-8.688,0-8.687-8.937V329.2q0-9,8.687-9h30.5q8.937,0,8.938,9v22.875H337.57V332.764H318.633v72.688H337.57V384.889h14.563Z" transform="translate(-99.847 -284.29)" style="fill: #ed1c24"/>
            </g>
        </svg>
    </div>
    <br>
    
    <%
    String orderId = (String)request.getParameter("orderId");
    String customerId = (String)session.getAttribute("customer_id");
    String query = "SELECT * FROM orders where customer_id =" + customerId + " AND order_id =" + orderId + "";
    
    Statement stat = conn.createStatement();
    ResultSet rs = stat.executeQuery(query);
    
    while (rs.next()) {
    	String date = rs.getString("date");
    %>
    
    <div class="container">
        <h2>Final Details for Order #ORD-<span><%=orderId %></span></h2>
        <a href="#" id="print" onclick="javascript:window.print();">Print this page for your records.</a>
        <br>
        <fmt:parseDate value="<%=date %>" var="parsedDate"  pattern="yyyy-MM-dd" />
        <b>Order Placed: </b><span><fmt:formatDate type="date" dateStyle="long" value="${parsedDate}" /></span>
        <br>
        <b>Order Number: ORD-<span><%=orderId %></span></b>
        <br>
        <br>
        <b>Order Total: $<span><%=String.format("%.2f", Double.parseDouble(rs.getString("total"))) %></span></b>
        <br>
        <br>
        <div class="order-wrapper">
        	<fmt:parseDate value="<%=date %>" var="parsedDate"  pattern="yyyy-MM-dd" />
        	<%
        	String status = rs.getString("status");
        	if (status.equals("Processing")) {
        	%>
       			<h1>Estimated Delivery on 
        	<%	
        	} else {
        	%>
        		<h1>Shipped on 
        	<%
        	}
        	
    		Date parsedDate = new SimpleDateFormat("yyyy-MM-dd").parse(date);
    		Calendar cal = Calendar.getInstance();
    		cal.setTime(parsedDate);
    		cal.add(Calendar.DATE, 5);
    		
            String formattedDate = DateFormat.getDateInstance(DateFormat.LONG).format(cal.getTime());
        	%>
        	<span><%=formattedDate %></span></h1>

            <div class="order-heading">
                <b>Items Ordered</b>
                <b>Price</b>
            </div>
            <br>
            
			<%
			stat = conn.createStatement();        			                
            query = "select order_products.ORDER_ID, product.BRAND, product.NAME, product.WEIGHT, product.UNIT_PRICE, order_products.QTY from (order_products, product) where order_products.PRODUCT_ID = product.PRODUCT_ID and order_products.ORDER_ID=" + orderId + "";
            ResultSet result = stat.executeQuery(query);
            
            Integer costPerLb = 40;
            Double itemsSubtotal = 0.0;
            Double shippingCost = 0.0;
  			                
            while (result.next()) {
			%>

            <div class="item">
                <div class="col-left">
                    <span><%=result.getString("qty") %></span> of: <span><i><%=result.getString("brand") %> <%=result.getString("name") %></i></span>
                </div>
                <div class="col-right">
                	<%
                    /* float unitPrice = Float.parseFloat(result.getString("unit_price")); */
                    Double unitPrice = Double.parseDouble(result.getString("unit_price"));
                    Double weight = Double.parseDouble(result.getString("weight"));
                    int qty = Integer.parseInt((result.getString("qty")));
                    
                    Double subtotal = unitPrice * qty;
                    
                    shippingCost += (costPerLb * (weight * qty));
                    itemsSubtotal += subtotal;
                    %>
                    <span>$<%=String.format("%.2f", subtotal) %></span>
                </div>
            </div>
            <br>
            <%
            }
            %>
        </div>

        <div class="shipping-wrapper">
            <b>Shipping Address:</b>
            <br>
            <span><%=rs.getString("address") %>, <%=rs.getString("city") %></span>
            <br>
            <br>
            <b>Shipping Cost</b>
            <br>
            <span>$<%=String.format("%.2f", shippingCost) %></span>
        </div>

        <div class="payment-wrapper">
            <h1>Payment Information</h1>
            <div>
                <div class="col-left">
                    <b>Payment Method:</b>
                    <br>
                    <span>Credit card, last digits: </span><span><%=rs.getString("card_no").substring(12) %></span>
                    <br>
                    <b>Billing Address</b>
                    <br>
                    <span><%=rs.getString("address") %>, <%=rs.getString("city") %></span>
                </div>
                <div class="col-right">
                    <p>Item(s) subtotal: $<span><%=String.format("%.2f", itemsSubtotal) %></span></p>
                    <p>Shipping cost: $<span><%=String.format("%.2f", shippingCost) %></span></p>
                    <p>-------</p>
                    <b>Grand Total: <span>$<%=rs.getString("total") %></span></b>
                </div>
            </div>
        </div>
    <%
    }
    %>

        <p class="footer">To view the status of your order, return to <a href="./customer-login.jsp">Order Summary</a>.</p>
    </div>
</body>
</html>