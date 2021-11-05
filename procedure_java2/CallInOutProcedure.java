package java_stored_procedure;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Types;

public class CallInOutProcedure extends Object {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		// 1. Oracle DB연결

		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";

		// 2. 계정연결
		Connection conn = DriverManager.getConnection(url, "javalink", "javalink");
		CallableStatement cs = conn.prepareCall("{call javatest(?,?,?)}");
		
		//변수 선언
		String p1_value = new String("a");
		String p2_value = new String("b");
		String p3_value;
		
		cs.setString(1, p1_value);
		cs.setString(2, p2_value);
		
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.registerOutParameter(3, Types.VARCHAR);
		cs.execute();
		
		p2_value = cs.getString(2);
		p3_value = cs.getString(3);
		
		System.out.println("p2 : " + p2_value);
		System.out.println("p3 : " + p3_value);
		
		
	}



}
