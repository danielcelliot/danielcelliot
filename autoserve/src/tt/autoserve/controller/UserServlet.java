package tt.autoserve.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tt.autoserve.bean.UserBean;
import tt.autoserve.dao.UserDAO;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    public void init() {
    	userDao = new UserDAO();
    }
    
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("add-user") != null) {
			putRequest(request, response);
		} else if (request.getParameter("remove-user") != null) {
		    // Perform remove.
		} else {
			getRequest(request, response);
		}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getParameter("add-user") != null) {
			putRequest(request, response);
		} else if (request.getParameter("remove-user") != null) {
		    // Perform remove.
		} else {
			getRequest(request, response);
		}
	}

	protected void getRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {

			ArrayList<UserBean> users = userDao.getUsers();
			request.setAttribute("customerList", users);
			
		} catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

	}
	
	protected void putRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String firstName = request.getParameter("first-name");
		String lastName = request.getParameter("last-name");
		String email = request.getParameter("email");
		int contactNo = Integer.parseInt(request.getParameter("tel1") + request.getParameter("tel2"));

        UserBean userBean = new UserBean();
        userBean.setFirstName(firstName);
        userBean.setLastName(lastName);
        userBean.setEmail(email);
        userBean.setContactNo(contactNo);
        
        try {
        	
        	int createResult = userDao.createUser(userBean);
        	
        	if (createResult == 1) {
        		request.setAttribute("successMsg", "User created successfully!");
				request.getRequestDispatcher("./demo/login/dashboard-admin.jsp").forward(request, response);
        	} else {
        		request.setAttribute("errorMsg", "Error creating new user.");
				request.getRequestDispatcher("./demo/login/dashboard-admin.jsp").forward(request, response);
        	}
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
	}
}
