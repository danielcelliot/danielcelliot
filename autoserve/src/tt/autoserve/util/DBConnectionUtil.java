package tt.autoserve.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnectionUtil {
	public static Connection createConnection() throws ClassNotFoundException, SQLException {
		
	     // NOTE: Change these values to match your MySQL Server configuration
       String dbName = "autoserve_demo";	// Your database name
	     String userName = "root";				  // Your MySQL login user-name
	     String password = "root";				  // Your MySQL login password
	     String hostName = "localhost";			// Your hostname. Default is localhost
	     String portNo = "3306";				    // Your MySQL Server Port#. Default is 3306
	     	     
	     return createConnection(hostName, dbName, userName, password, portNo);
	}
	  
	public static Connection createConnection(String host, String db, String user, String pass, String port) throws SQLException,
	         ClassNotFoundException {
	    
	     Class.forName("com.mysql.jdbc.Driver");
	     String connectionURL = "jdbc:mysql://" + host + ":" + port + "/" + db;
	     
	     Connection con = DriverManager.getConnection(connectionURL, user, pass);
	     return con;
	}
}
