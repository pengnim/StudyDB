--ch13.사용자 권한

-- 권한 : 시스템권한: connect,resource,dba
--       객체권한: scott.emp를 사용할수 있는 권한

--sys
GRANT CONNECT,resource TO javalink;
GRANT view,SYNONYM TO javalink;
--DBA 권한을 JavaLink에 양도(권한 설정)
GRANT dba TO javalink;
--role:사용자에게 일일이 권한을 설정하는 번거롭기 때문에 여러개의 권한 묶어 놓으것

--sys에서 사용자 계정(=DB) 생성
drop user user043;
create user user04 IDENTIFIED BY u1234;
--=>상태:실패-테스트 실패:ORA-01045:user USER04 lacks CREATE SESSION privilege:logon denied
GRANT CONNECT,resource TO user04;

--user04
select * from dict where table_name like '%ROLE%';
select * from USER_ROLE_PRIVS;




--1. 사용자가 ROLE 정의
--user04
select * from scott.emp;
--=>ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
--sys
create role mrole;
--scott
grant select on emp TO mrole;

--sys
GRANT mrole TO user04;
--user04
select * from USER_ROLE_PRIVS;
--=>결론

--user04
set role mrole;
select * from scott.emp;

--------------과제: 시스템권한_연습.docx
--ROLE을 생성하여 여러 사용자에게 적용하기
--롤 이름: def_role
--테이블 : scott 계정의 emp테이블을 update,delete,select 할수 있게 설계
--사용자: userA1, UserA2, UserA3
--       공통 비번(a1234)

--❶ def_role 생성한후 시스템 권한인 CREATE SESSION, CREATE TABLE 부여(GRANT)
    --sys
    create role def_role;
    GRANT CREATE SESSION, CREATE TABLE TO def_role;

--❷ 생성된 롤 def_role에 scott 사용자로 접속해서 emp테이블을 수정,삭제,조회 할수 있도록 객체 권한 부여 하기
 --scott
 GRANT update,delete,select ON emp to def_role;

--❸ DBA인 system으로 접속해서 사용자 계정을 만들기
--sys
create user userA1 IDENTIFIED BY a1234;
GRANT CONNECT,resource TO userA1;

--❹ 생성된 사용자 계정에 각각 def_role에 대한 권한 설정하기
--sys
GRANT def_role TO userA1;

--❺ role 권한 설정 확인하기
--userA1
select * from role_sys_privs where role='DEF_ROLE';
select * from role_TAB_privs where role='DEF_ROLE';
--❻ 각 사용자에 접속해서 사용자에 def_role롤이 설정 되어 있는지 확인하기
--userA1
select * from USER_ROLE_PRIVS;
--7.결과 확인
--userA1
UPDATE SCOTT.EMP
SET JOB='WORKER'
WHERE EMPNO='7934';

SELECT * FROM SCOTT.EMP;

rollback;