package dbServer;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConn {
	public Connection getConnection() throws Exception{
		try{
			String driver="com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/npd";//ip address+database name
			String username = "root";
			String password = "ian_19920924";
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url,username,password);
			System.out.println("Connected");
			return conn;
		}catch(Exception e)
		{
			System.out.println(e);
		}
		return null;
	}
}
