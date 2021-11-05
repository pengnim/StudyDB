--ch06.Join

-- 하나 이상의 테입블을 사용해서 select하는 방식: join, Subquery

--join: 한개이상의 테이블에서 데이터 조회를 하기 위한 사용방식
--    :   결과가 여러 테이블의 컬럼이 나옴.

--subQuery(부속질의어): 특정 테이블에서 검색한 결과를 다른 테이블에 전달하여
--                     새로 결과를 검색하는 질의어

select * from emp;

--=>join 필요성,SubQuery 필요성
select * from emp where ename='SCOTT';
select deptno,dname,loc from dept where deptno=20;

--=>join 작성
select ename,job,dname
from emp ,dept
where emp.deptno = dept.deptno and ename='SCOTT';

--=>SubQuery 작성
select dname,loc 
from dept
where deptno =(select deptno from emp where ename='SCOTT');

ANSI(미국국립표준연구소): DB SQL 공통 표준(Oracle, MySQL)
PL/SQL - 오라클사에서만 사용하는 Query

--1. 조인 종류
 ---ANSI 조인
 -- Oracle 조인
 
 --2.Oracle 조인
 -- Cross Join
 -- Equi Join
 -- Non Equi
 -- Outer Join
 -- self Join
 
 --(1) Cross Join
 -- : 하나 이상의 테이블 결합
 --    (where절에 의해서 컬럼 결합이 발생하지 않는 경우)
 select * from emp, dept;
 
 --(2)Equi Join (동등조인,'='):가장 많이 사용
 -- : 조인 대상이 되는 2개의 테이블에서 공통적으로 존재하는 컬럼값이 
 --    일치되는 행을 연결하여 결과를 생성
 
 select *
 from emp,dept
 where emp.deptno = dept.deptno and ename= 'SCOTT'
 
 
 select ename,dname, deptno
 from emp,dept
 where emp.deptno = dept.deptno and ename= 'SCOTT';
 --=>ORA-00918: 열의 정의가 애매합니다
 select ename,dname, e.deptno
 from emp e,dept d
 where e.deptno = d.deptno and ename= 'SCOTT';
 
 --(예)직급이 manager인 사원의 이름,부서명 출력하기(별칭사용)
 select ename,dname, e.deptno
 from emp e,dept d
 where e.deptno = d.deptno and job='MANAGER';
 
 --(3)Non Equi Join
 -- 상관 관계가 없는 2개이상의 테이블을 사용시
 select * from salgrade;
 --(예) 사원의 급여가 몇등급인지?
 select ename,job,sal,grade
 from emp, salgrade
 where sal between losal and hisal;
 
 --(4)self Join
 -- 자기 자신의 테이블과 조인 맺는것
 select ename,mgr from emp;
 select empno,ename from emp;
 --=> self join
 select e.ename || '의 메니저는 '|| m.ename ||'입니다' 
 from emp e, emp m
 where e.mgr = m.empno and e.ename='SMITH';
 
 --(예)매니저가 king인 사원들의 이름,직급 출력?
 select e.ename,e.job
 from emp e, emp m
 where e.mgr = m.empno and m.ename='KING';
 
 --(4)Outer Join
 --2개 이상의 테이블이 조인될때, 어느 한쪽 테이블에는 존재하는데,
 --다른 테이블에서는 데이터가 존재하지 않는 경우, 그 데이터는 출력되지 않는 문제점을 해결하기 위한 방법
 --정보가 부족한 컬럼(+)
 select e.ename || '의 메니저는 '|| m.ename ||'입니다' 
 from emp e, emp m
 where e.mgr(+) = m.empno;
 
 select e.ename || '의 메니저는 '|| m.ename ||'입니다' 
 from emp e, emp m
 where e.mgr = m.empno(+);
 
 
 --(예) 도서를 구매하지 않은 고객을 포함해서 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
 --madang
 select c.name, saleprice
 from Customer c, Orders o
 where c.custid = o.custid(+);
 
 select c.name, saleprice
 from Customer c, Orders o
 where c.custid(+) = o.custid;
 
 -- 3.ANSI Join
 --Cross Join
 --Inner Join
 --Natural Join
 --Outer Join
 
---(1)Cross Join
select * from emp cross join dept;

--(2) Inner Join
--Oracle join의 equi join과 비슷, On절 추가
select ename,dname, emp.deptno
 from emp Inner join dept
 ON emp.deptno = dept.deptno and ename= 'SCOTT';
 
 --(3)Natural Join
 --inner join 을 축약한 형태
 select ename,dname, deptno
 from emp natural join dept
 where ename= 'SCOTT';
 --=>ORA-25155: NATURAL 조인에 사용된 열은 식별자를 가질 수 없음
 
 --(4)Outer join
 --기존 조인에서 모든 레코드가 반드시 출력 되어야 할때(+) 사용 => LEFT,RIGHT,FULL
 --(예) 도서를 구매하지 않은 고객을 포함해서 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
 --madang
 select c.name, saleprice
 from Customer c Left OUTER JOIN Orders o
 ON c.custid = o.custid;
 
 -----------------교재-----------------
 
 