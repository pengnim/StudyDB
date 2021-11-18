package mms.member.action;

import java.util.Scanner;

import mms.member.dao.MemberDAO;
import mms.member.db.JdbcUtil;

public interface Action {
	void execute(Scanner sc) throws Exception;
}
