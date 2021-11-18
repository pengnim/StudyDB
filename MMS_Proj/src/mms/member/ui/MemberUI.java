package mms.member.ui;

import java.util.Scanner;

import mms.member.action.Action;
import mms.member.action.MemberAddAction;
import mms.member.action.MemberListAction;
import mms.member.action.MemberModifyAction;
import mms.member.action.MemberRemoveAction;
import mms.member.controller.MemberController;

public class MemberUI {

	public static void main(String[] args) {

		System.out.print("Pull 연습");

		System.out.print("commit-push 연습1");

		System.out.print("slave branch 연습1");

		boolean isStop = false;
		MemberController memberController = new MemberController();
		Scanner sc = new Scanner(System.in);
		do {
			System.out.println("=====회원관리 프로그램=====");
			System.out.println("1.회원등록");
			System.out.println("2.회원목록보기");
			System.out.println("3.회원정보수정");
			System.out.println("4.회원정보삭제");
			System.out.println("5.프로그램종료");
			System.out.print("메뉴번호 : ");
			int menu = sc.nextInt();// 1
			Action action = null;
			switch (menu) {
			case 1:
				action = new MemberAddAction();// 1.회원등록
				break;
			case 2:
				action = new MemberListAction();// 2.테이이블 전체 회원 보기
				break;
			case 3:
				action = new MemberModifyAction();// 3.회원정보 수정
				break;
			case 4:
				action = new MemberRemoveAction();// 4.회원삭제
				break;
			case 5:
				System.out.println("프로그램 종료!");
				;// 5.종료
				isStop = true;
				break;
			default:
				break;
			}

			if (action != null) {
				memberController.processRequest(action, sc);
			}
		} while (!isStop);

	}

}
