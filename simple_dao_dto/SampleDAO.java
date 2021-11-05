package date_1029_dao_dto;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class SampleDAO {
	Connection con;

	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버가 없습니다.");
		}
	}

	public void connect() {
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		try {
			con = DriverManager.getConnection(url, "javalink", "javalink");
			System.out.println("Connection Success!!!");
		} catch (SQLException e) {
			System.out.println("주소,id,pw가 다릅니다.");
		}
	}

	public ArrayList<SampleDTO> findAll() {
		connect();
		ArrayList<SampleDTO> sampleDTOs = new ArrayList<SampleDTO>();
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = con.createStatement();
			String sql = "SELECT * FROM book";
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				String id = rs.getString(1);
				String name = rs.getString(2);
				int price = rs.getInt(3);

				sampleDTOs.add(new SampleDTO(id, name, price));

			}
			
//			  방법2 : 
//			  
//			  while (rs.next()) { 
//			  
//			  SampleDTO dto = new SampleDTO(); //<- 생성자 파라메터 없어야함
//			  dto.setId(rs.getString(1)); 
//			  dto.setName(rs.getString(2)); 
//			  dto.setPrice(rs.getInt(3));
//			  sampleDTOs.add(dto);
//			  
//			  }
			 
			

		} catch (SQLException se) {
			se.printStackTrace();
		} finally {
			try {
				stmt.close();
				con.close();
				rs.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return sampleDTOs;
	}
}
