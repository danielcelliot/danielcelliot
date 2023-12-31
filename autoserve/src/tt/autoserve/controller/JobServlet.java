package tt.autoserve.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tt.autoserve.bean.JobBean;
import tt.autoserve.dao.JobDAO;

@WebServlet("/job")
public class JobServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
    private JobDAO jobDao;

    public void init() {
        jobDao = new JobDAO();
    }
	
	protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try {
			
			ArrayList<JobBean> jobs = jobDao.getJobs();			
			request.setAttribute("jobList", jobs);
			
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
