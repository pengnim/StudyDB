--ch12. Sequence & Index

--1. sequence
-- 자동 번호 발생기: DB에서 연속적으로 증가하는 값을 표현 ,Primary key에서 사용
--MySQL인 경우:
create table member2(
id number(6) auto_increment  primary key,
name varchar2(20)
);
insert into member2 values('홍길동1');

--Oracle 인 경우:
drop table member2;
create table member2(
id number(6) primary key,
name varchar2(20)
);

drop sequence m_seq;
create sequence m_seq
start with 0
increment by 1
minvalue 0;

insert into member2 values(m_seq.nextval,'홍길동1');
insert into member2 values(m_seq.nextval,'홍길동2');
insert into member2 values(m_seq.nextval,'홍길동3');
insert into member2 values(m_seq.currval,'홍길동3');-- 현재값(새로운 값이 아님)
select * from member2;
select m_seq.currval from member2;

--(예)부서번호를 생성하는 시퀸스 객체(dept_exam_seq)를 생성한뒤
--    이를 이용해서 부서번호를 자동으로 생성하는 테이블 만들기
drop table dept_exam;
create table dept_exam(
 deptno number(4) primary key,
 dname varchar2(16),
 loc varchar2(16)
);

--시퀸스
drop sequence dept_exam_seq;
create sequence dept_exam_seq
start with 0
increment by 10
minvalue 0
;

insert into dept_exam values(dept_exam_seq.nextval,'인사과','서울');
insert into dept_exam values(dept_exam_seq.nextval,'인사과2','서울2');
insert into dept_exam values(dept_exam_seq.nextval,'인사과3','서울3');
insert into dept_exam values(dept_exam_seq.nextval,'인사과3','서울4');

select * from dept_exam;
--결과
10 인사과 서울
20 경리과 서울
30 총무과 대전
40 기술팀 대전


--------------------Index
--2. Index
--: 책의 "차례", "찾아보기"
--:SQL문의 처리 속도를 향상시키기 위해서 컬럼에 생성하는 오라클 객체
--: primary key, unique에 제약조건(이름)을 지정해주면 이것이 인덱스 이름(자동생성)
--: 인덱스 생성시 컬럼에 중복된 값이 있어도 인덱스 생성이 가능

--장점: 검색 속도가 빠르다,시스템에 부하를 줄여서 시스템의 전체 성능향상르 가져온다
--단점: 인덱스 구성을 위한 메모리 추가 공간 필요
--     인덱스 생성하는데 시간 소요, 
--     인덱스 데이터 변경 작업(insert,update,delete)이 자주일어나면 성능저하

select index_name,table_name,column_name
from user_ind_columns
where table_name IN ('EMP','DEPT');

--(1)Index 비교
 -- emp table 복사
 -- 원본 테이블(emp)에는 기본키,인덱스이름 이런 것들이 존재하지만, 복사한 emp01에서 기본키도 인덱스 복사못함.
 drop table emp01;
 create table emp01
 as
 select * from emp;
 
select index_name,table_name,column_name
from user_ind_columns
where table_name IN ('EMP','EMP01');
--=>서브쿼리문으로 복사한 테이블은 구조와 내용만 복사됨,index나 제약조건(이름) 복사가 안됨

insert into emp01(empno) values(1111);
insert into emp01(empno) values(1111);

--(2)컬럼으로 검색하기(index 사용X)
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;
insert into emp01 select * from emp01;

select * from emp01;

insert into emp01(empno,ename) values(4444,'bbbb');

set timing on;
--인덱스를 사용하지 않았을때 검색시간
select distinct empno,ename from emp01 where ename='bbbb';

--(3) 인덱스를 사용한 검색하기
drop index IDX_emp01_ename;
create  index IDX_emp01_ename
on emp01(ename);

select distinct empno,ename from emp01 where ename='bbbb';

select index_name,table_name,column_name
from user_ind_columns
where table_name IN('EMP01');

--(예) emp01의 직급 컬럼을 인덱스로 설정(idx_emp01_job)하고, 확인하기
drop index IDX_emp01_job;
create  index IDX_emp01_job
on emp01(job);

select index_name,table_name,column_name
from user_ind_columns
where table_name IN('EMP01');

--(4)인덱스 재성성(rebuild)
create index idx_emp01_deptno
on emp01(deptno);

alter index idx_emp01_deptno rebuild;

--(5)인덱스 종류
--1) 고유 인덱스/비고유 인덱스
unique index: 유일한 컬럼 값을 갖는 인덱스 설정
non unique index: 중복된 값을 갖는 컬럼에 대해서  인덱스 설정(default: 기본값)
drop table dept01;

create table dept01
as
select * from dept where 1=0;

insert into dept01 values(10,'인사과','서울');
insert into dept01 values(20,'총무과','대전');
insert into dept01 values(30,'교육팀','대전');

select * from dept01;

create unique index idx_dept01_deptno
on dept01(deptno);

create unique index idx_dept01_loc
on dept01(loc);
--=>ORA-01452: 중복 키가 있습니다. 유일한 인덱스를 작성할 수 없습니다
create  index idx_dept01_loc
on dept01(loc);--x: 중복된 컬럼도 인덱스 설정 가능

---2) 결합 인덱스
--    :2개 이상의 컬럼으로 인덱스 구성
create index ide_dept01_com
on dept01(deptno,dname);

select index_name,table_name,column_name
from user_ind_columns
where table_name IN('DEPT01');

---3)함수 인덱스
--  : 수식이나 함수를 적용해서 Index를 만든것
create index idx_emp01_sal
on emp01(sal*12);

select index_name,table_name,column_name
from user_ind_columns
where table_name IN('EMP01');


set timing off;