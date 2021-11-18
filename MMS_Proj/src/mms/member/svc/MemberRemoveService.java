package mms.member.svc;

import java.sql.Connection;

import mms.member.dao.MemberDAO;
import mms.member.db.JdbcUtil;

public class MemberRemoveService {

	public boolean removeMember(String name) {
		boolean	isRemoveSuccess = false;
		
		Connection con = JdbcUtil.getConnection();
		MemberDAO memberDAO = new MemberDAO(con);
		
		int deleteCount = memberDAO.deleteMember(name);
		if(deleteCount > 0) {
			isRemoveSuccess = true;
			JdbcUtil.commit(con);
		}else {
			JdbcUtil.rollback(con);
		}
		JdbcUtil.close(con);
		return isRemoveSuccess;
	}
}

