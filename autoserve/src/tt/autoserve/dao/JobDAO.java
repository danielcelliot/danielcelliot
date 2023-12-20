package tt.autoserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tt.autoserve.bean.JobBean;
import tt.autoserve.util.DBConnectionUtil;

public class JobDAO {

	public ArrayList<JobBean> getJobs() throws ClassNotFoundException {

		boolean status = false;
        
        ArrayList<JobBean> items = new ArrayList<JobBean>();
		
        try {
        	
          /*
          * String query =
          * "select a.service_id, a.date, concat(b.fname, ' ', b.lname) as customer, c.START_DATE, c.END_DATE, c.STATUS, concat(d.fname, ' ', d.lname) as mechanic\r\n"
          * + "from service a, customer b, service_tasks c, mechanic d\r\n" +
          * "where a.CUSTOMER_ID = b.ID AND a.SERVICE_ID = c.SERVICE_ID AND c.MECHANIC_ID = d.MECHANIC_ID"
          * ;
          */
        	
        	String query = "SELECT a.SERVICE_ID, a.DATE, concat(d.FNAME, ' ', d.LNAME) AS CLERK_NAME, concat(b.FNAME, ' ', b.LNAME) AS CUSTOMER_NAME, c.LICENSE_NO, concat(c.MAKE, ' ', c.MODEL) AS VEHICLE\r\n" + 
        			"FROM service a, customer b, vehicle c, clerk d\r\n" + 
        			"WHERE a.CUSTOMER_ID = b.ID\r\n" + 
        			"AND a.CLERK_ID = d.ID\r\n" + 
        			"AND a.VEHICLE_NO = c.VEHICLE_NO";
        	
        	Connection con = DBConnectionUtil.createConnection();
        	PreparedStatement ps = con.prepareStatement(query);
        	
          ResultSet rs = ps.executeQuery();
          
          while (rs.next()) {
            
            status = true;
            
            JobBean jobBean = new JobBean();
            
            // Get job details
            jobBean.setId(Integer.parseInt(rs.getString("service_id")));
            jobBean.setDate(rs.getString("date"));
            jobBean.setClerkName(rs.getString("clerk_name"));
            jobBean.setCustomerName(rs.getString("customer_name"));
            jobBean.setLicenseNo(rs.getString("license_no"));
            jobBean.setVehicle(rs.getString("vehicle"));
            
            // Add job to list
            items.add(jobBean);
          }
          
          // DEBUG
          System.out.println("Record(s) found: " + status);
          //for (JobBean i : items) { System.out.println(i.getCustomerName()); }
            
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
        return items;
    }
	
	/*
	 * public JobBean getJob(int id) throws ClassNotFoundException {
	 * 
	 * //boolean status = false;
	 * 
	 * JobBean jobBean = new JobBean();
	 * 
	 * try {
	 * 
	 * String query =
	 * "select a.service_id, a.date, concat(b.fname, ' ', b.lname) as customer, c.START_DATE, c.END_DATE, c.STATUS, concat(d.fname, ' ', d.lname) as mechanic\r\n"
	 * + "from service a, customer b, service_tasks c, mechanic d\r\n" +
	 * "where a.CUSTOMER_ID = b.ID AND a.SERVICE_ID = c.SERVICE_ID AND c.MECHANIC_ID = d.MECHANIC_ID\r\n"
	 * + "AND a.CUSTOMER_ID = ?";
	 * 
	 * Connection con = DBConnectionUtil.createConnection(); PreparedStatement ps =
	 * con.prepareStatement(query);
	 * 
	 * ps.setInt(1, id); ResultSet rs = ps.executeQuery();
	 * 
	 * while (rs.next()) {
	 * 
	 * //status = true;
	 * 
	 * // Get job details jobBean.setId(rs.getString("service_id"));
	 * jobBean.setCustomerName(rs.getString("customer"));
	 * jobBean.setMechanicName(rs.getString("mechanic"));
	 * jobBean.setStartDate(rs.getString("start_date"));
	 * jobBean.setEndDate(rs.getString("end_date"));
	 * jobBean.setJobStatus(rs.getString("status")); }
	 * 
	 * // DEBUG //System.out.println("Record(s) found: " + status);
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); }
	 * 
	 * return jobBean; }
	 */
}
