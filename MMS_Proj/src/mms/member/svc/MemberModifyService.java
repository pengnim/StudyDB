package mms.member.svc;

import java.sql.Connection;

import mms.member.dao.MemberDAO;
import mms.member.db.JdbcUtil;
import mms.member.vo.Member;

public class MemberModifyService {

	public boolean modifyMember(Member updatemember) {
		boolean isModifySuccess = false;
		Connection con = JdbcUtil.getConnection();
		MemberDAO memberDAO = new MemberDAO(con);
		int updateCount = memberDAO.updateMember(updatemember);
		if (updateCount > 0) {
			isModifySuccess = true;
			JdbcUtil.commit(con);
		} else {
			JdbcUtil.rollback(con);
		}
		JdbcUtil.close(con);
		return isModifySuccess;

	}

	// 수정할이름을 불러올때 Member 정보 가져오기
	public Member getOldMember(String name) {
		Connection con = JdbcUtil.getConnection();
		MemberDAO memberDAO = new MemberDAO(con);
		Member member = memberDAO.selectOldMember(name);

		JdbcUtil.close(con);
		return member;

	}

}
