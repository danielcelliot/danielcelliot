package tt.autoserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import tt.autoserve.bean.UserBean;
import tt.autoserve.util.DBConnectionUtil;

public class UserDAO {

	public boolean getUser(UserBean userBean, int id, int type) throws ClassNotFoundException {

		boolean status = false;
		
        try {
        	
        	Connection con = DBConnectionUtil.createConnection();
        	PreparedStatement ps;
        	
        	if (type == 1) {
            	ps = con.prepareStatement("select * from clerk where login_id = ?");
        	} else {
        		ps = con.prepareStatement("select * from customer where login_id = ?");
        	}
        	
        	ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
            	status = true;
            	
                // Get User details
            	userBean.setId(Integer.parseInt(rs.getString("id")));
                userBean.setFirstName(rs.getString("fname"));
                userBean.setLastName(rs.getString("lname"));
                userBean.setEmail(rs.getString("email"));
                userBean.setContactNo(Integer.parseInt(rs.getString("contact_no")));
            }
            
            // DEBUG
            System.out.println("Record found: " + status);
            
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
        return status;
    }
	
	public ArrayList<UserBean> getUsers() throws ClassNotFoundException {
		
		ArrayList<UserBean> items = new ArrayList<UserBean>();
		
        try {
        	
        	String query = "select * from customer";
        	
        	Connection con = DBConnectionUtil.createConnection();
        	PreparedStatement ps = con.prepareStatement(query);
        	
          ResultSet rs = ps.executeQuery();
          
          while (rs.next()) {
            
            UserBean userBean = new UserBean();
            
            // Get job details
            userBean.setId(Integer.parseInt(rs.getString("id")));
            userBean.setFirstName(rs.getString("fname"));
            userBean.setLastName(rs.getString("lname"));
            userBean.setEmail(rs.getString("email"));
            userBean.setContactNo(Integer.parseInt(rs.getString("contact_no")));
            
            // Add job to list
            items.add(userBean);
          }
          
          // DEBUG
          //System.out.println("Record(s) found: " + status);
          //for (JobBean i : items) { System.out.println(i.getCustomerName()); }
            
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
		return items;	
	}
	
	public int createUser(UserBean userBean) throws ClassNotFoundException {
		
		int success = 0;

        try {
        	
        	String query = "INSERT INTO customer VALUES\r\n" + 
        			"(null,?,?,?,?,null)";
        	
        	Connection con = DBConnectionUtil.createConnection();
        	PreparedStatement ps = con.prepareStatement(query);
        	
        	ps.setString(1, userBean.getFirstName());
        	ps.setString(2, userBean.getLastName());
        	ps.setString(3, userBean.getEmail());
        	ps.setInt(4, userBean.getContactNo());
        	
        	success = ps.executeUpdate();
            
          // DEBUG
          System.out.println("Record insert: " + success);
            
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
        return success;
	}
}
