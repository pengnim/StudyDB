--ch07.SubQuery(부속 질의어)\
--: 특정 테이블에서 검색한 결과를 다른 테이블에 전달하여 새로운 검색 결과를 검색하는 경우에 사용

select * from emp where ename='SCOTT';
select deptno,dname,loc from dept where deptno=20;
--=> subquery
select dname
from dept
where deptno=(select deptno from emp where ename='SCOTT');

--단일행 서브쿼리:부속 질의 수행 결과가 오직 하나의 값으로 나오는 경우에 사용
--               비교 연산자(=,<,>,<>) 사용
--다중행 서브쿼리: 부속 질의 수행 결과가 하나 이사의 값으로 나오는 경우에 사용
---- IN:
---- ANY,SOME:
---- ALL:
---- EXISTS:

--단일행 서브쿼리 예
--(예)scott 과 같은 부서에서 근무하는 사원의 이름과 부서번호 출력?
--(예)scott과 동일한 직급을 가진 사원 출력?
select *
from emp
where job = (select job from emp where ename='SCOTT');

--(예)DALLAS에서 근무하는 사원의 이름,부서번호?
select ename,deptno
from emp
where deptno= (select deptno from dept where loc='DALLAS');



--다중행 서브쿼리 예
--
--(1)IN
-- : 메인 쿼리의 비교 조건 중에서 서브쿼리의 출력 결과와 하나라도 일치하면 참.
--(예) 연봉3000이상을 받는 사원이 소속된 부서와 동일한 부서에 근무하는 사원정보 출력?
select ename,sal, deptno
from emp
where sal >= 3000;

select ename,sal, deptno
from emp
where deptno = (select deptno from emp where sal >= 3000);
--=>ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
select ename,sal, deptno
from emp
where deptno IN (select distinct deptno from emp where sal >= 3000);
--(예)부서별로 가장 급여를 많이 받는 사원의 정보?
select empno,ename,sal,deptno
from emp
where sal IN (select max(sal) from emp group by deptno);

select deptno, max(sal) from emp group by deptno;

--(2) ALL
--메인 쿼리의 비교 조건이 서브쿼리와 검색결과와 모든 값이 일치하는 경우 참.
--(예)deptno=30 소속 사원중에서 급여를 가장 많이 받는 사원보다 더 많이 받는 사원의 이름과 급여
----- 기본형식
select max(sal),deptno
from emp
group by deptno
having deptno=30;

---- (단일행 서브쿼리를 통한 결과)
select ename, sal,deptno
from emp
where sal > (select max(sal) from emp group by deptno having deptno=30);

---- (다중행 서브쿼리를 통한 결과)
select ename, sal,deptno
from emp
where sal > all (select max(sal) from emp group by deptno having deptno=30);

select ename, sal,deptno
from emp
where sal > all (select sal from emp where deptno=30);

--(3) ANY,SOME
--: 메인쿼리의 비교 조건이 서브쿼리의 검색결과와 하나 이상이 일치하면 참.
--  (검색한 값중에서 가장 작은값, 최소값 보다 크면 참)

--(예)deptno=30인 사원들의 급여중 가장 낮은값(950)보다 높은 급여를 받는 사원의 이름,급여?
--(기본형)
select min(sal) from emp group by deptno having deptno=30;
select * from emp where deptno=30;
--(단일형 서브쿼리)
select ename,sal,deptno
from emp
where sal > (select min(sal) from emp group by deptno having deptno=30);


--(다중행 서브쿼리)
select ename,sal,deptno
from emp
where sal > any (select sal from emp where deptno=30);


--(4)EXISTS
--: 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도 존재하면 참.
--(예) 주문이 있는 고객의 이름과 주소를 보이시오?
--    (orders테이블에 custid에 이름이 있으면 Customer 테이블에서 내용을 뽑아라)
select name,address
from Customer cs
where EXISTS (select * from orders od where cs.custid = od.custid);

--=>X
select name,address
from Customer 
where EXISTS (select * from Customer  ,orders  where customer.custid = orders.custid);