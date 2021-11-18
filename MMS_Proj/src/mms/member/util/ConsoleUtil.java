package mms.member.util;

import java.util.ArrayList;
import java.util.Scanner;

import mms.member.vo.Member;

public class ConsoleUtil {
	// 1.회원등록
	public Member getMember(Scanner sc) {
		System.out.println("등록할 회원정보를 입력하세요?");
		System.out.print("이름 : ");
		String name = sc.next();

		System.out.print("주소 : ");
		String addr = sc.next();

		System.out.print("이메일 : ");
		String email = sc.next();

		System.out.print("국가 : ");
		String nation = sc.next();

		System.out.print("나이 : ");
		int age = sc.nextInt();
		return new Member(name, addr, email, nation, age);
	}

	public void printAddSuccessMessage(Member newMember) {
		System.out.println(newMember.getName() + " 회원 정보 추가 성공");
	}

	public void printAddFailMessage(Member newMember) {
		System.out.println(newMember.getName() + " 회원 정보 추가 실패");
	}

	// 2. select all 출력
	public void printMemberLIst(ArrayList<Member> memberList) {
		for (int i = 0; i < memberList.size(); i++)
			System.out.println(memberList.get(i));
	}

	// 3.update
	// 수정할 회원 정보 얻어 오기
	public String getName(String msgKind, Scanner sc) {
		System.out.println(msgKind + "회원이름을 입력하세요.");
		System.out.println("회원이름: ");

		return sc.next();

	}

	// 수정할 회원정보
	public Member getUpdateMember(Scanner sc, Member oldMember) {
		System.out.print("이전 국가 : " + oldMember.getNation());
		System.out.print("수정할 국가 : ");
		String nation = sc.next();

		System.out.print("이전 주소 : " + oldMember.getAddr());
		System.out.print("수정할 주소 : ");
		String addr = sc.next();

		System.out.print("이전 이메일 : " + oldMember.getEmail());
		System.out.print("수정할 이메일 : ");
		String email = sc.next();

		System.out.print("이전 나이 : " + oldMember.getAge());
		System.out.print("수정할 나이 : ");
		int age = sc.nextInt();

		return new Member(oldMember.getName(), addr, nation, email, age);
	}

	public void printModifySuccessMessage(Member updateMember) {
		System.out.println(updateMember.getName() + " 회원 정보 수정 성공.");
	}

	public void printModifyFailMessage(Member updateMember) {
		System.out.println(updateMember.getName() + " 회원 정보 수정 실패.");
	}

	// 4.삭제
	public void printRemoveSuccessMessage(String name) {
		System.out.println(name + " 회원의 정보 삭제 성공.");
	}

	public void printRemoveFailMessage(String name) {
		System.out.println(name + " 회원의 정보 삭제 실패.");
	}

}
