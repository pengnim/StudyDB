--ch04.Built-in Function(내장 함수)
-- 만들어진 함수
-- 사용자 정의함수: PL/SQL

--1. 문자 함수
-- (1)대문자 :UPPER(), 소문자:LOWER(), 이니셜만 대문자로 변환 : initcap()
select 'Welcome to Oracle', 
       upper('Welcome to Oracle'),
       lower('Welcome to Oracle'),
       initcap('Welcome to Oracle')   
from dual;

--(예)직급이 매니저인 사원을 검색하기
select empno, ename
from emp
where job='manager';--x

select empno, ename
from emp
where job='MANAGER';--O
--=>lower() 사용
select empno, ename
from emp
where lower(job)='manager';--O
--=>upper() 사용
select empno, ename
from emp
where job=upper('manager');--O

select empno, ename
from emp
where job=upper('manaGER');--O

select empno, ename
from emp
where upper(job)='MANAGER';--O

--(2) length:문자길이, lengthb:바이트 수
select length('Oracle'),length('오라클') from dual;
select lengthb('Oracle'),lengthb('오라클') from dual;


--(3)substr(대상,시작위치,추출할갯수), substrb():문자열 일부 byte출력
select substr('Welcome to Oracle',4,3) from dual;
select substr('Welcome to Oracle',-4,3) from dual;

--(예) 사원들의 입사년도만 출력
select substr(hiredate,1,2) 년도,substr(hiredate,4,2) 월
from emp;

--(예) 9월에 입사한 사원 출력
select *
from emp
where substr(hiredate,4,2) ='09';

--(예) 1987 입사한 사원 출력
select *
from emp
where substr(hiredate,1,2) ='87';

--(예) 이름이 " E"로 끝나는 사원 출력(like, substr)
select *
from emp
where substr(ename,-1,1) ='E';

select *
from emp
where ename like '%E';

--(4)INSTR(대상,찾을글자,시작위치,몇번째발견)
select INSTR('WELCOME TO ORACLE','O') FROM DUAL;
select INSTR('WELCOME TO ORACLE','O',6,2) FROM DUAL;
select INSTR('데이터베이스','이',3,1),INSTRb('데이터베이스','이',3,1) FROM DUAL;

--(예)EMP테이블에 이름에 3번째 자리가 R로 끝나는 직원 조회?(LIKE,INSTR,SUBSTR)
select * from emp where ename like '__R%';
select * from emp where INSTR(ENAME,'R',3,1)=3;
select * from emp where substr(ENAME,3,1)='R';

--(5)LPAD/RPAD: 특정 기호로 채우기
select LPAD('Oracle',20,'#'),RPAD('Oracle',20,'#') from dual;
--(6) LTRIM/RTRIM : 공백문자 삭제
select RTRIM('     Oracle         ') from dual;


--2. 날짜 함수
--(1)현재 날짜:sysdate
select sysdate, sysdate-1 어제, sysdate+1 내일 from dual;
 select sysdate-hiredate as 근무일수 from emp;
 select hiredate, round(hiredate,'MONTH') from emp;
 
--3.형변환 함수
--to_char(날짜데이터,'출력형식'): 날짜, 숫자   => 문자형
--to_date('문자','format'): 문자형 => 날짜형
--to_number:문자형 => 숫자형

--(예)현재 날짜 출력
select sysdate,to_char(sysdate,'YYYY-MM-DD') from dual;
--(예) 사원들의 입사일(요일 포함)
select hiredate, to_char(hiredate,'YYYY/MM/DD DAY') from emp;

--(예) 1981년 2월 20일에 입사한 사원검색?
select ename,hiredate from emp where hiredate=19810220;
--=>ORA-00932: 일관성 없는 데이터 유형: DATE이(가) 필요하지만 NUMBER임
select ename,hiredate from emp where hiredate='19810220';
select ename,hiredate from emp where hiredate=to_char('19810220');
select ename,hiredate from emp where hiredate=to_date('19810220','YYYYMMDD');
select ename,hiredate from emp where hiredate=to_date(19810220,'YYYYMMDD');