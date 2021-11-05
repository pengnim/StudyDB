--ch11.View
--:하나 이상의 테이블이나 다른 뷰를 이용해서 생성되는 가상 테이블(Virtual table)
--:뷰를 통해서 원본(기본)테이블 변경 가능
-- 뷰를 사용하는 목적:보안(데이터를 보호),반복질의 하는 경우

-- 기본테이블 : 실제 테이블(dept,emp,,)
-- 가상테이블 : select loc from dept;
create table dept_copy
as
select * from dept;

select loc from dept;
select * from dept_copy;

--1. View 생성
create view dept_copy30
as
select deptno,dname,loc
from dept_copy
where deptno=30;
--=>ORA-01031: 권한이 불충분합니다
Grant Create View To SCOTT; --sys


create table emp_copy
as
select * from emp;

create view emp_copy30
as select empno,ename,deptno
from emp_copy
where deptno=30;

select * from emp_copy;
select * from emp_copy30;

desc USER_VIEWS;
select view_name,text from user_views;


--2.view에 insert문으로 데이터 추가
--=> 기본테이블(emp_copy)에 실제 내용 삽입됨,update,delete도 동일
insert into emp_copy30 values(1111,'AAA',30);

select * from emp_copy;
select * from emp_copy30;
select * from emp;--관계없음

--3.단순뷰
--:기본테이블이 하나인 뷰
drop view emp_view;
create or replace view emp_view(사원번호,사원명,급여,부서번호)
as
select empno,ename,sal,deptno
from emp_copy;

select * from emp_view where deptno=30;--x
select * from emp_view where 부서번호=30;--o

--그룹함수(sum,avg,min,max,count)를 사용한 단순뷰 만들기
create or replace view view_sal
as
select  deptno,sum(sal) "SalSum", avg(sal) "SalAvg"
from emp_copy
group by deptno;

--컬럼명을 설정하지 않은 경우 : 에러 발생
create or replace view view_sal
as
select  deptno,sum(sal), avg(sal)
from emp_copy
group by deptno;
--=>ORA-00998: 이 식은 열의 별명과 함께 지정해야 합니다

--4.복합뷰
--2개이상의 기본 테이블에 의해서 정의된 뷰:join
create or replace view emp_view_dept
as
select empno,sal,e.deptno, dname,loc
from emp e, dept d
where e.deptno = d.deptno
order by empno desc;

select * from emp_view_dept;

--(예) 각 부서별 최대 급여와 최소 급여를 출력하는 뷰 만들기
--뷰이름:sal_view
create or replace view sal_view
as
select dname, max(sal) Max_Sal, min(sal) Min_Sal
from emp e, dept d
where e.deptno = d.deptno
group by dname;


select * from sal_view;

--5.옵션
--(1) or replace
   create view ~ : 생성되면 재실행 불가(삭제후 재실행 가능)
   create or replace~: 실행시 덮었기(항상 재실행 가능)
--(2)force : 기본 테이블 없이 뷰 생성 용도
  -- default : noforce 또는 ()
   desc employees;

create or replace view employees_view
as
select emptno,ename,deptno
from employees
where deptno=30;
--=>ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
create or replace FORCE view employees_view
as
select emptno,ename,deptno
from employees
where deptno=30;
--=>경고: 컴파일 오류와 함께 뷰가 생성되었습니다.
select view_name,text from user_views;

--(3) with check option : 조건값 변경 못하게 하는 옵션
create or replace view view_chk
as
select empno,ename,sal,deptno
from emp_copy
where deptno=30 with check option;

update view_chk set deptno=20 where sal >= 900;
--=>ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다

--(4)with read only : 기본 테이블 변경 막기
create or replace view view_chk30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno=30 with check option;

select * from view_chk30;
update view_chk30 set comm=1000;--o
update view_chk30 set deptno=20 where sal >= 950;--x

create or replace view view_read30
as
select empno,ename,sal,comm,deptno
from emp_copy
where deptno=30 with read only;

select * from view_read30;
update view_read30 set comm=2000;
--=>SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.


