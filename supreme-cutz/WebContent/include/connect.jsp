<%@ include file="../include/classes.jsp"%>
<%
// NOTE: Change these values to match your MySQL Server configuration
String dbName = "supremecutz_demo";	// Your database name
String userName = "root";			// Your MySQL login user-name
String pwd = "root";				// Your MySQL login password
String hostName = "localhost";		// Your hostname. Default is localhost
String portNo = "3306";				// Your MySQL Server Port#. Default is 3306



// NOTE: Do NOT change these values
String connectionString = "jdbc:mysql://" + hostName + ":" + portNo + "/" + dbName;
java.sql.Connection conn;

Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection(connectionString, userName, pwd);
%>