package tt.autoserve.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tt.autoserve.bean.LoginBean;
import tt.autoserve.bean.UserBean;
import tt.autoserve.dao.LoginDAO;
import tt.autoserve.dao.UserDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	
    private static final long serialVersionUID = 1L;
    private LoginDAO loginDao;
    private UserDAO userDao;

    public void init() {
        loginDao = new LoginDAO();
        userDao = new UserDAO();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        LoginBean loginBean = new LoginBean();
        UserBean userBean = new UserBean();
        
        loginBean.setUsername(username);
        loginBean.setPassword(password);
        
        try {
        	
        	boolean loginResult = loginDao.validate(loginBean);
    		
        	if (loginResult) {
        		
                // DEBUG
                System.out.println("Type: " + loginBean.getUserType() + ", ID: " + loginBean.getId());

    			if (userDao.getUser(userBean, loginBean.getId(), loginBean.getUserType())) {
    				
    				// DEBUG
    				System.out.println(userBean.getFirstName());
    				
            		request.setAttribute("first_name", userBean.getFirstName());
    			}
        		
        		if (loginBean.getUserType() == 1) {
                    	request.getRequestDispatcher("./demo/login/dashboard-admin.jsp").forward(request, response);
            	} else if (loginBean.getUserType() == 2) {
                	request.getRequestDispatcher("./demo/login/dashboard-user.jsp").forward(request, response);
        		}
        		
			} else {
	    		request.setAttribute("errorMsg", "Incorrect username or password.");
				request.getRequestDispatcher("/pages/login/login-form.jsp").forward(request, response);
			}
        	
        	// DEBUG
        	System.out.println("Login result: " + loginResult);
        	
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
        processRequest(request, response); 
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
        processRequest(request, response); 
    } 
}
