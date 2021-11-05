package plsql;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Types;

public class PlsqlProcedure {

	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		// 1. Oracle DB연결

		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";

		// 2. 계정연결
		Connection conn = DriverManager.getConnection(url, "javalink", "javalink");
		CallableStatement cs = conn.prepareCall("{call compute_power(?,?,?)}");
		
		// 3. 변수 선언 - run as - run configure에서 변수 설정하기
		int p1_InValue = Integer.parseInt(args[0]);
		int p2_InOutValue = Integer.parseInt(args[1]);
		int p3_OutValue;
		cs.setInt(1, p1_InValue);
		cs.setInt(2, p2_InOutValue);

//		cs.registerOutParameter(2, p2_InOutValue); 아래와 같은 방식
		cs.registerOutParameter(2, Types.INTEGER);
		
		cs.registerOutParameter(3, Types.INTEGER);
		cs.execute();
		
		p2_InOutValue = cs.getInt(2);
		p3_OutValue = cs.getInt(3);
		
		System.out.println(p1_InValue + " " + p2_InOutValue +" " + p3_OutValue);
		
		
	}

}
