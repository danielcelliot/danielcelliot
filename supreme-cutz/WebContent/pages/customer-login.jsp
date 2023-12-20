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
    <title>Your Orders - Supreme Cutz Barbershop</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
    <link rel="stylesheet" href="../css/core.css">
    <link rel="stylesheet" href="../css/customer-login.css">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="../favicon.ico" type="image/x-icon">
</head>
<body>
    <div class="container">
    	<div class="modal-container">
	    	<div class="modal-content">
	    		<div class="modal-header">
	    			<span class=""><i class="fas fa-exclamation-circle"></i></span>
      				<h3 class="modal-header-text" id="error-heading">Error</h3>
	    		</div>
	    		<div class="modal-body">
	    			<p id="error-msg" class="modal-msg">There was an error</p>
	    		</div>
	    		<div class="modal-footer">
	    			<button class="modal-btn" id="yes">yes</button>
	    			<button class="modal-btn" id="no">no</button>
	    		</div>
	    	</div>
		    <div class="spinner-container dialog">
	        	<div class="lds-roller"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>
	        </div>
	    </div>
	    
        <header>
            <div class="menu-logo--wrapper">
                <div class="menu-btn" onclick="show()">
                    <div class="menu-btn--burger"></div>
                </div>
                <div class="logo-container">
                    <a href="../index.jsp">
                        <%-- <svg class="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
                        <svg id="logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 396.876 55.547">
                            <title>brand-name</title>
                            <g id="supreme">
                                <path d="M114.284,525.527a2.557,2.557,0,0,1-.715,1.875,2.494,2.494,0,0,1-1.863.727h-9.234a2.575,2.575,0,0,1-1.887-.727,2.515,2.515,0,0,1-.738-1.875v-9.3H103.1v9.023h7.922V516.5L100.9,504.27a4.26,4.26,0,0,1-1.054-2.79v-7.429a2.515,2.515,0,0,1,.738-1.875,2.575,2.575,0,0,1,1.887-.727h9.234a2.494,2.494,0,0,1,1.863.727,2.557,2.557,0,0,1,.715,1.875v8.531h-3.258v-8.25H103.1v7.734L113.276,514.3a4.189,4.189,0,0,1,1.008,2.742Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M148.7,525.527a2.512,2.512,0,0,1-.739,1.875,2.574,2.574,0,0,1-1.886.727h-9.985a2.489,2.489,0,0,1-2.6-2.6V491.449h3.258v33.8h8.7v-33.8H148.7Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M182.531,510.949a2.527,2.527,0,0,1-2.625,2.625h-8.648v14.555H168v-36.68h11.906a2.575,2.575,0,0,1,1.887.727,2.515,2.515,0,0,1,.738,1.875Zm-3.258-.281V494.332h-8.015v16.336Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M216.737,528.129h-3.422l-6.82-19.641.445-.656h5.812v-13.5h-8.367v33.8h-3.258v-36.68h12.282a2.489,2.489,0,0,1,2.6,2.6v13.922q0,2.647-3.562,2.648c-.235,0-.578-.012-1.031-.035s-.782-.035-.985-.035Q213.6,519.317,216.737,528.129Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M247.1,528.129H235.052v-36.68h11.906v2.883H238.31V508.02h7.875v2.929H238.31v14.3H247.1Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M283.766,528.129H280.7V504.9q0-.492.328-2.882l-6,22.664h-.656l-6-22.664q.329,2.414.328,2.882v23.227h-3.07v-36.68h3.023l5.954,23.86a8.423,8.423,0,0,1,.093,1.054,8.858,8.858,0,0,1,.094-1.054l5.953-23.86h3.024Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M315.111,528.129H303.064v-36.68h11.907v2.883h-8.649V508.02H314.2v2.929h-7.875v14.3h8.789Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                            </g>
                            <g id="cutz">
                                <path d="M395.043,524.777q0,3.352-3.352,3.352H380.254q-3.258,0-3.258-3.352V494.824q0-3.375,3.258-3.375h11.437q3.353,0,3.352,3.375V503.4h-5.461V496.16h-7.1v27.258h7.1v-7.711h5.461Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M431.146,524.777q0,3.352-3.375,3.352H416.123q-3.329,0-3.328-3.352V491.449h5.484v31.969h7.383V491.449h5.484Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M464.931,496.3h-6.047v31.828h-5.461V496.3h-6.047v-4.852h17.555Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                                <path d="M496.723,528.129H479.871V525.2l10.266-28.8h-9.446v-4.946h15.985v3.164l-10.242,28.571h10.289Z" transform="translate(-99.847 -480.181)" style="fill: #231f20"/>
                            </g>
                            <g id="separator">
                                <path d="M349.476,535.728h-4.571V480.181h4.571Z" transform="translate(-99.847 -480.181)" style="fill: #ed1c24"/>
                            </g>
                        </svg>
                    </a>
                </div>
            </div>
            <ul class="nav-pri">
                <li>
                    <a href="mailto:contact@supremecutz.com"><div class="link"><i class="fas fa-calendar-alt"></i>
                        <span>make appointment</span>
                    </div></a>
                </li>
                <li>
                    <a href="callto:1868-555-1234"><div class="link"><i class="fas fa-phone-alt"></i>
                        <span>call now</span>
                    </div></a>
                </li>
                <li>
                    <a target="_blank" href="https://www.google.com/maps/dir//10.6364788,-61.274698/@10.636479,-61.274698,16z?hl=en"><div class="link"><i class="fas fa-directions"></i>
                        <span>get directions</span>
                    </div></a>
                </li>
            </ul>
            <ul class="nav-sec">
                <li>
                    <a href="../pages/cart.jsp" title="View cart">
                        <i class="fas fa-shopping-cart fa-2x is-showing"></i>
                        <i class="fas fa-cart-plus fa-2x"></i>
                    </a>
                </li>
                <li><a href="#" title="Sign in"><i class="fas fa-user-circle fa-2x"></i></a></li>
            </ul>
        </header>

        <nav class="sidebar-nav">
            <div class="nav-wrapper">
                <ul class="nav-vert">
                    <li><a href="../pages/about.jsp" class="page-link">about</a></li>
                    <li><a href="../pages/barbers.jsp" class="page-link">barbers</a></li>
                    <li><a href="../pages/contact-us.jsp" class="page-link">contact us</a></li>
                    <li><a href="../pages/gallery.jsp" class="page-link">gallery</a></li>
                    <li><a href="../pages/prices.jsp" class="page-link">pricing</a></li>
                    <li><a href="../pages/products.jsp" class="page-link">products</a></li>
                </ul>
            </div>
        </nav>

        <main>
            <div class="customer-info-wrapper">
                <div class="customer-img-wrapper">
                    <svg class="customer-img" id="Layer_1" enable-background="new 0 0 480.063 480.063" height="512" viewBox="0 0 480.063 480.063" width="512" xmlns="http://www.w3.org/2000/svg"><path d="m402.032 424.806v47.257c0 4.418-3.582 8-8 8s-8-3.582-8-8v-47.257c0-36.795-29.775-66.572-66.573-66.571-17.411 0-33.208-8.87-42.259-23.728-2.298-3.773-1.103-8.696 2.671-10.994 3.773-2.299 8.695-1.103 10.994 2.671 6.122 10.051 16.811 16.051 28.594 16.051 45.637-.002 82.573 36.93 82.573 82.571zm-139.606-80.193c.941 4.317-1.796 8.579-6.113 9.52-21.054 4.587-42.467-.005-59.516-11.642-16.878 18.087-39.176 15.744-36.191 15.744-36.795-.001-66.573 29.773-66.573 66.571v47.257c0 4.418-3.582 8-8 8s-8-3.582-8-8v-47.257c0-45.636 36.929-82.571 82.571-82.571 18.462 0 33.429-14.875 33.429-33.342v-2.107c-34.919-16.697-59.429-51.784-60.923-92.643-14.37-3.455-25.077-16.317-25.077-31.62v-41.473c-.437-20.3 2.577-71.143 39.648-106.877 45.775-44.126 119.183-41.323 173.161-15.338 5.261 2.535 6.06 9.643 1.691 13.324 27.345 6.67 50.925 23.48 66.074 47.538.782 1.239 2.214 3.184 1.84 6.287-.232 1.931-.807 3.565-2.295 5.075-9.75 9.888-15.119 22.991-15.119 36.896v54.57c0 4.418-3.582 8-8 8s-8-3.582-8-8v-54.57c0-16.037 5.479-31.259 15.542-43.487-15.338-21.936-39.268-36.044-66.332-38.942l-14.061-1.506c-8.222-.88-9.835-12.207-2.194-15.352l6.395-2.633c-83.286-29.035-172.351 3.226-172.351 114.928v41.56c0 6.348 3.656 11.865 9 14.636v-51.863c0-30.878 25.122-56 56-56h102c30.878 0 56 25.12 56 55.997v65.503c0 69.574-67.988 122.42-137.17 102.053-.45 5.708-1.871 11.216-4.186 16.336 13.458 9.242 30.453 12.97 47.23 9.314 4.317-.94 8.579 1.797 9.52 6.114zm-22.394-43.425c50.178 0 91-40.822 91-91v-64.895c0-22.054-17.944-39.997-40-39.997h-102c-22.056 0-40 17.944-40 40v64.892c0 50.178 40.822 91 91 91zm81 137.875h-24c-4.418 0-8 3.582-8 8s3.582 8 8 8h24c4.418 0 8-3.582 8-8s-3.582-8-8-8z"/></svg>
                </div>
                <h2>Hello, <span><c:out value="${firstname}"/></span>!</h2>
                
                <c:set var="date" value="${customer_reg_date}" />
				<fmt:parseDate value="${date}" var="parsedDate"  pattern="yyyy-MM-dd" />  
                
                <h3>Customer since <span><fmt:formatDate type="date" dateStyle="long" value="${parsedDate}" /></span></h3>
                <div class="buttons-wrapper">
                    <div>
                        <button class="log-out-btn">sign out</button>
                        <%-- <button class="change-pass-btn">change password</button> --%>
                    </div>
                </div>
            </div>

            <div class="order-container">
                <h1>Your Orders</h1>
                <%
                String orderId = null;
                Statement stat = conn.createStatement();
                
                String customerId = (String)session.getAttribute("customer_id");
                String query = "SELECT * FROM orders where customer_id =" + customerId + "";
                ResultSet rs = stat.executeQuery(query);

                if (!rs.isBeforeFirst() ) {
               	%>
                	<!-- No orders -->
                    <div class="order empty-order">
                        <p>You don't have any orders yet. Click <a href="../pages/products.jsp">here</a> to start shopping!</p>
                    </div>
                <%
                } else {
                	while (rs.next()) {
             			orderId = rs.getString("order_id");
             			%>
                		<div class="order">
                        <div class="order-title">
                            <h2>Order: #ORD-<span><%=orderId %></span></h2>
                            <div class="order-heading">
                                <div class="order-date">
                                    <h3>order date</h3>
                                	<% String orderDate = rs.getString("date"); %>
									<fmt:parseDate value="<%=orderDate %>" var="parsedDate" pattern="yyyy-MM-dd" /> 
                                    <span><fmt:formatDate type="date" dateStyle="long" value="${parsedDate}" /></span>
                                </div>
                                <div class="order-total">
                                    <h3>total</h3>
                                    <span>$<%=rs.getString("total") %></span>
                                </div>
                                <div class="shipping-address">
                                    <h3>shipping address</h3>
                                    <span><%=rs.getString("address") %>, <%=rs.getString("city") %></span>
                                </div>
                            </div>
                        </div>
        
                        <div class="order-status">
                            <h4>Order Status: 
                            <%
                           	String status = rs.getString("status");
                            if (status.equals("Processing")) {
                            	
                            	Date parsedDate = new SimpleDateFormat("yyyy-MM-dd").parse(orderDate);
                        		Calendar cal = Calendar.getInstance();
                        		cal.setTime(parsedDate);
                        		cal.add(Calendar.DATE, 5);
                        		
                                String formattedDate = DateFormat.getDateInstance(DateFormat.LONG).format(cal.getTime());
                           	%>
                            	<span style="color: yellow;">Processing</span></h4>
                            	<h4>Estimated Delivery Date: <span><%=formattedDate %></span></h4>
                           	<%
                            } else if (status.equals("Complete")) {
                           	%>
                            	<span style="color: green;">Complete</span></h4>
                           	<%
                            } else if (status.equals("Cancelled")) {
                           	%>
                            	<span style="color: red;">Cancelled</span></h4>
                           	<%
                            } else {
                           	%>
                            	<span><%=status%></span></h4>
                           	<%
                            }
                            %>
                        </div>
        
                        <div class="order-items">
                            <div class="order-col-left">
                                <div class="item-wrapper">
        							<%
        							stat = conn.createStatement();        			                
        			                query = "select order_products.ORDER_ID, product.BRAND, product.NAME, product.IMAGE_SMALL, product.UNIT_PRICE, order_products.QTY from (order_products, product) where order_products.PRODUCT_ID = product.PRODUCT_ID and order_products.ORDER_ID=" + orderId + "";
        			                ResultSet result = stat.executeQuery(query);
        			                
        			                while (result.next()) {
									%>
	       			                	<div class="item">
	                                        <div class="image">
	                                        	<%
												Blob imageBlob = result.getBlob("image_small");
												
												if (imageBlob != null) {
													byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());
													String base64 = Base64.getEncoder().encodeToString(imageBytes);
												%>
							                        <img src="<%="data:image/png;base64," + base64 %>" alt="" />
												<%
												}
												%>
	                                        </div>
	                                        <div class="item-description">
	                                            <span><%=result.getString("brand") %></span>
	                                            <span><%=result.getString("name") %></span>
	                                            <%
	                                            float unitPrice = Float.parseFloat(result.getString("unit_price"));
	                                            int qty = Integer.parseInt((result.getString("qty")));
	                                            float subtotal = unitPrice * qty;
	                                            %>
	                                            <div class="item-qty">Qty: <span class="qty"><%=qty %></span>
	                                            </div>
	                                            <div class="item-price">$<%=String.format("%.2f", subtotal) %></div>
	                                        </div>
	                                    </div>
        			                <%
        			                }
        							%>
                                </div>
                            </div>
                            <div class="order-col-right">
                            	<% if (status.equals("Processing") || status.equals("Complete")) { %>
	                                <div>
	                                    <button class="invoice-btn" onclick="location.href='../pages/invoice.jsp?orderId=<%=orderId%>';">view invoice</button>
	                                <% if (status.equals("Processing")) { %>
	                                	<button class="cancel-btn" id="<%=orderId %>">cancel order</button>
	                                <%	
	                                }
	                                %>
	                                </div>
                            	<%	
                            	}
                            	%>
                            </div>
                        </div>
                    </div>
                    <%
                	}
                }
                %>
            </div>
        </main>
        
        <footer>
            <div class="footer-wrapper">
                <div class="footer-heading">
                    <%-- <svg class="footer-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 177.778 100"><path d="M31.941,62.825h25.65V37.175H31.941ZM52.654,47.532h-5.42v-5.42h5.42Zm-15.777-5.42H42.3V52.468H52.654v5.42H36.877Zm37.417-4.937A12.825,12.825,0,1,0,87.119,50,12.84,12.84,0,0,0,74.294,37.175Zm0,20.713A7.888,7.888,0,1,1,82.182,50,7.9,7.9,0,0,1,74.294,57.888Zm58.719-20.713A12.825,12.825,0,1,0,145.837,50,12.84,12.84,0,0,0,133.013,37.175Zm0,20.713A7.888,7.888,0,1,1,140.9,50,7.9,7.9,0,0,1,133.013,57.888Zm-29.36-20.713A12.825,12.825,0,1,0,116.478,50,12.84,12.84,0,0,0,103.653,37.175Zm0,20.713a7.888,7.888,0,1,1,7.488-10.356h-7.488v4.936h7.488A7.9,7.9,0,0,1,103.653,57.888Z" fill="#394149"/></svg> --%>
                    <svg id="footer-logo" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200.416 166.352">
                        <title>brand-logo-alt</title>
                        <rect id="SC-box" x="6.5" y="6.5" width="187.416" height="153.352" style="fill: none;stroke: #231f20;stroke-miterlimit: 10;stroke-width: 13px"/>
                        <g id="s">
                            <path d="M304.129,514.079q0,8.939-8.876,8.937l-29.437,0q-8.812,0-8.812-8.938V490.764H271.63V510.7H289.5V491.516L260.2,463.764a10.359,10.359,0,0,1-3.187-7.813V434.2q0-9,8.813-9l29.438,0q8.874,0,8.874,8.876v21.875H289.508V437.516H271.634V455.2l29.31,27.627a10.388,10.388,0,0,1,3.187,7.938Z" transform="translate(-210.815 -389.29)" style="fill: #231f20"/>
                        </g>
                        <g id="c">
                            <path d="M365.133,514.076q0,8.938-8.938,8.938H325.7q-8.688,0-8.687-8.938V434.2q0-9,8.687-9h30.5q8.937,0,8.938,9v22.875H350.57V437.764H331.633v72.687H350.57V489.889h14.563Z" transform="translate(-210.815 -389.29)" style="fill: #ed1c24"/>
                        </g>
                    </svg>
                </div>
                <div class="footer-links-container">
                    <div class="site-links">
                        <span>Main pages</span>
                        <a href="../pages/about.jsp">About</a>
                        <a href="../pages/barbers.jsp">Barbers</a>
                        <a href="../pages/contact-us.jsp">Contact Us</a>
                        <a href="../pages/gallery.jsp">Gallery</a>
                        <a href="../pages/prices.jsp">Pricing</a>
                        <a href="../pages/products.jsp">Products</a>
                    </div>
                    <div class="site-links">
                        <span>Book Appointment</span>
                        <a href="mailto:contact@supremecutz.com"><i class="fas fa-envelope"></i>contact@supremecutz.com</a>
                        <a href="callto:1868-555-1234"><i class="fas fa-phone-alt"></i>(868)-555-1234</a>
                        <a target="_blank" href="https://www.google.com/maps/dir//10.6364788,-61.274698/@10.636479,-61.274698,16z?hl=en"><i class="fas fa-directions"></i>#22 Fiddlers Dream St., Arima</a>
                    </div>
                    <div class="site-links">
                        <span>Follow us</span>
                        <div class="social-media">
                            <i class="fab fa-instagram"></i>
                            <i class="fab fa-whatsapp"></i>
                            <i class="fab fa-facebook"></i>
                            <i class="fab fa-twitter"></i>
                        </div>
                        <div class="proudtt-logo"><img src="../img/proud-logo.png" alt="" srcset=""></div>
                        <div class="copyright">&copy 2020 Supreme Cutz Barbershop Ltd.</div>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <script src="../js/index.js"></script>
    <script src="../js/customer-login.js"></script>
</body>
</html>