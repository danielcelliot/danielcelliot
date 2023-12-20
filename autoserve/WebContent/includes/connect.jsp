<%
// NOTE: Change these values to match your MySQL Server configuration
String dbName = "autoserve_demo";	// Your database name
String userName = "root";			// Your MySQL login user-name
String password = "root";			// Your MySQL login password
String hostName = "localhost";		// Your hostname. Default is localhost
String portNo = "3306";				// Your MySQL Server Port#. Default is 3306

String connectionString = "jdbc:mysql://" + hostName + ":" + portNo + "/" + dbName;
Class.forName("com.mysql.jdbc.Driver").newInstance();
Connection conn = DriverManager.getConnection(connectionString, userName, password);
%>