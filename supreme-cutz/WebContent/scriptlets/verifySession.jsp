<%
String href = (String)request.getParameter("param1");

if (session.getAttribute("customer_id") == null) {
	if (request.getParameter("checkout") != null) {
		session.setAttribute("checkout", "ready");
	}
	request.getRequestDispatcher("../pages/login.jsp").forward(request, response);
} else {
	request.getRequestDispatcher(href).forward(request, response);
}
%>