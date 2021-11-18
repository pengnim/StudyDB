package mms.member.action;

import java.util.Scanner;

import mms.member.svc.MemberModifyService;
import mms.member.util.ConsoleUtil;
import mms.member.vo.Member;

public class MemberModifyAction implements Action {

	@Override
	public void execute(Scanner sc) throws Exception {

		ConsoleUtil cu = new ConsoleUtil();
		String name = cu.getName("수정할", sc);
		MemberModifyService memberModifyService = new MemberModifyService();
		Member oldMember = memberModifyService.getOldMember(name);// 기존 회원정보
		Member updateMember = cu.getUpdateMember(sc, oldMember); // 수정할 회원정보
		boolean isModifySuccess = memberModifyService.modifyMember(updateMember);
		if (isModifySuccess)
			cu.printModifySuccessMessage(updateMember);
		else
			cu.printModifyFailMessage(updateMember);

	}

}
