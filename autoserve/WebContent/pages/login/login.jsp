<%@ include file="../../includes/classes.jsp"%>
<%@ include file="../../includes/connect.jsp"%>
<%
	boolean status = false;
	int id = 0;
	int type = 0;
	
	String query = "select * from login where username = ? and password = ?";
	PreparedStatement stat = conn.prepareStatement(query);

	stat.setString(1, request.getParameter("username"));
	stat.setString(2, request.getParameter("password"));
	
	ResultSet rs = stat.executeQuery();
    
    while (rs.next()) {

    	// Get User Type / ID
        type = Integer.parseInt(rs.getString("login_type"));
        id = Integer.parseInt(rs.getString("login_id"));
    	
    	PreparedStatement ps;
        
    	if (type == 1) {
        	ps = conn.prepareStatement("select * from clerk where login_id = ?");
    	} else {
    		ps = conn.prepareStatement("select * from customer where login_id = ?");
    	}
    	
    	ps.setInt(1, id);
        ResultSet result = ps.executeQuery();
        
        while (result.next()) {
        	status = true;
        	session.setAttribute("first_name", result.getString("fname"));
        	session.setAttribute("id", id);
        	session.setAttribute("user_id", result.getString("id"));
        	session.setAttribute("type", type);
        	
        	// DEBUG
        	//System.out.println("Session ID: " + session.getAttribute("id"));
        }
    	
    }
    
    if (status) {
    	if (type == 1) {
        	request.getRequestDispatcher("/pages/dashboard/admin.jsp").forward(request, response);
		} else if (type == 2) {
	    	request.getRequestDispatcher("/pages/dashboard/user.jsp").forward(request, response);
		}
    } else {
    	request.setAttribute("errorMsg", "Incorrect username or password.");
    	request.getRequestDispatcher("/pages/login/login-form.jsp").forward(request, response);
    }
%>