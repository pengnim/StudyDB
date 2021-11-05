-- scott/scott에서 작업하기

--Ch08.테이블 생성 수정 제거
--1.테이블
--(1)테이블 만들기
CREATE table emp01(
emptno number(4),
ename varchar2(20),
sal number(7,2) --전체7자리 소수점2자리
);

select * from emp01;
desc emp01;


--(2) SubQuery로 테이블 만들기
CREATE table emp02
as
select * from emp; --복사본뜨는방법

select * from emp02;
desc emp02;


--(3)원하는 컬럼으로 구성된 복제 테이블 만들기
CREATE table emp03
as
select empno,ename,sal from emp; 

select * from emp03;
desc emp03;


--(4)원하는 행으로 구성된 복제 테이블 만들기
create table emp04 
as
select * from emp where deptno=10;

select * from emp04;


--(5)테이블 구조만 복사
create table emp05
as
select * from emp where 1=0; --같으냐, 조건에 안맞으니 껍데기만 갖고옴

select * from emp05;
desc emp05;



------------------
--2.Alter
--Alter Table:테이블의 구조를 변경하는 것
--ADD COLIUMN;
--MODIFY COLUMN;
--DROP;

--(1) ADD COLUMN
desc emp01;
alter table emp01 ADD(job varchar2(9));--컬럼증가!

--(예) dept03 테이블 생성 후 문자타입의 부서장(dmgr)만들기
create table dept03
as
select * from dept;

alter table dept03 ADD(dmgr varchar(20));

desc dept03;
select * from dept03;


--(2)MODIFY COLUMN;
desc emp01;
alter table emp01 modify (job varchar2(20));

--(3)DROP COLUMN
alter table emp01 drop column job;



----------------
--3. DROP TABLE:완전삭제
drop table emp01;


--4.TRUNCATE TABLE:모든 행만 삭제(구조는 남아있음)
TRUNCATE table emp02;
desc emp02; --데이터만 삭제됨



--6.DATA DICTIONARY(DD):데이터 사전
-- : DB에서 자원을 효율적으로 관리하기 위해서 다양한정보를 저장하는 시스템 테이블
-- DBA_XXX: DB관리자만 접근 가능한 테이블
-- ALL_XXX: 권한을 부여받은 사용자까지 사용가능한 테이블
-- USER_XXX: 일반 사용자 계정

desc user_tables;
show user

desc all_tables;
select owner,table_name from all_tables;

select owner,table_name from dba_tables;--sys 계정에서 작업
