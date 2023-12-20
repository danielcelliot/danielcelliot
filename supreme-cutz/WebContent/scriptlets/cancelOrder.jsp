<%@ include file="../include/connect.jsp"%>
<%
String status = "Cancelled";
Integer orderId = Integer.parseInt(request.getParameter("order_id"));

String query = "UPDATE orders SET status=? WHERE order_id=?";
PreparedStatement stat = conn.prepareStatement(query);

stat.setString(1, status);
stat.setInt(2, orderId);
stat.executeUpdate();

response.sendRedirect("../pages/customer-login.jsp");
%>