--SYSTEM 계정에서 설정


-- 최초 환경설정:[도구][환경설정][Environment]Encoding: UTF-8
--              [코드 편집기]글자크기 변경
--사용자계정=DataBase
-오라클은 대소문자 구분하지 않음(단,비밀번호, 영문자 검색 대소문자 구분)
- 오라클은 index가 0이 아닌 1부터 시작(오라클: Pointer X)

--기존의 사용자 계정 보기
select * from dba_users;

--사용자 계정의 암호 설정후 사용
alter user oe IDENTIFIED BY oe ACCOUNT UNLOCK;
alter user scott IDENTIFIED BY scott ACCOUNT UNLOCK;

-- 우리가 DB만들기
create user javalink IDENTIFIED BY javalink;
GRANT CONNECT,resource TO javalink;


-- 교재 DB만들기
create user textbook IDENTIFIED BY textbook;
GRANT CONNECT,resource TO textbook;
Grant Create View To SCOTT; 








