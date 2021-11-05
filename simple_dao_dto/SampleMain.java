package date_1029_dao_dto;

import java.util.ArrayList;

public class SampleMain {

	public static void main(String[] args) {
		SampleDAO dao = new SampleDAO();
			
//		방법 1 :
//		for (SampleDTO sample : dao.findAll()) {
//			System.out.println(sample);
//		}
		
		//방법 2 :
		ArrayList<SampleDTO> books = dao.findAll();
		for(int i = 0; i < books.size(); i++) {
			System.out.println(books.get(i));
		}

	}

}
