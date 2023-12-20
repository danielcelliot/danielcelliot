package tt.autoserve.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import tt.autoserve.bean.LoginBean;
import tt.autoserve.util.DBConnectionUtil;

public class LoginDAO {
    public boolean validate(LoginBean loginBean) throws ClassNotFoundException {
    	
    	boolean status = false;
        String query = "select * from login where username = ? and password = ?";
        
        try {
        	
        	Connection con = DBConnectionUtil.createConnection();
        	
        	PreparedStatement ps = con.prepareStatement(query);
        	
        	ps.setString(1, loginBean.getUsername());
            ps.setString(2, loginBean.getPassword());
            
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {

            	status = true;
            	
                // Get User Type / ID
                loginBean.setUserType(Integer.parseInt(rs.getString("login_type")));
                loginBean.setId(Integer.parseInt(rs.getString("login_id")));
            }
            
            // DEBUG
            // System.out.println(status);
            
            
        } catch (SQLException e) {
        	e.printStackTrace();
        }
        
        return status;
    }
}
