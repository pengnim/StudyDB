--ch05.Group Function
--: sum(), avg(), count(), max(), min()
--: 결과는 단 하나 <--> 단일행 함수(여러행 결과)
--(1)
select deptno,round(sal,3) from emp;--O:단일행 함수
select sum(sal) from emp;--O:그룹 함수
select deptno, sum(sal) from emp;--X
--=>ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
select deptno, sum(sal) from emp group by deptno;--O

select round(avg(sal), 3),max(sal),min(sal) from emp;
select ename,max(sal) from emp;--X

--(2)COUNT
-- *인 경우: null포함, 컬럼값이 들어 있는 경우: null제외
select count(*),count(comm) from emp;
select count(*),count(distinct job) from emp;

--(예) 30번 부서 소속의 사원중에서 커미션을 받은 사원의 수?
select count(comm) 커미션사원수
from emp
where deptno=30;

--(3)Group by
--   그룹함수와 컬럼이름,단일행 함수를 같이 사용하기 위해서
 
 --(예) 소속 부서별 급여 총액과 평균 급여 구하기
select deptno,sum(sal), avg(sal)
from emp
group by deptno;


--(4)having 조건
-- 그룹의 결과를 제한할때
select deptno,sum(sal), avg(sal)
from emp
group by deptno
having avg(sal) >= 2000;

--(예)부서의 최대값과 최소값을 구하되,최대급여 2900이상인 부서만 출력?
select deptno,max(sal), min(sal)
from emp
group by deptno
having max(sal) >= 2900;

--(예)madang
--(예)가격이 8000이상인 도서를 구매한 고객에 대해서 고객별 주문도서의 총 수량을 구하시오.
--   (단, 2권이상 구매한 고객만 구하시오)
select custid, count(*) "도서수량"--5
from orders                     --1
where saleprice >= 8000         --2
group by custid                 --3
having count(*)> 1              --4
order by custid;                --6