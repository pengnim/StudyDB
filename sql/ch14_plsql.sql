--ch14.PL/SQL
--: Oracle's Procedural Language extension to SQL)
--: 기존 SQL 문장에 변수를 정의,조건처리,반복처리가 추가된 SQL
--: Block Query,Oracle에서만 존재
--  기존 SQL : ANSI SQL


set timing on
set timing off

set SERVEROUTPUT ON
--1. 익명(anonymous) 블록
Begin
    DBMS_OUTPUT.PUT_LINE('hello');
end;

set SERVEROUTPUT ON
DECLARE
    vempno number(4);
    vename varchar2(10);
BEGIN
    vename := 'scott';
    vempno := 7788;
    DBMS_OUTPUT.PUT_LINE('사번/이름');
    DBMS_OUTPUT.PUT_LINE('-----------');
    DBMS_OUTPUT.PUT_LINE(vempno||'/'||vename);
END;
--파일 내용 실행하기
-- 
@C:/DBSQL/plsql/test1;--반드시 블럭한후 실행
@C:\DBSQL\plsql\test1;

--2.PL/SQL 문법
--(1) scalar 변수/ reference변수
   --스칼라변수: number,varchar2
   --reference변수:
   --       %TYPE: 컬럼에 적용,기존 테이블에 있는 해당 컬럼 타입을 가져다가 사용
   --       %ROWTYPE:행에 있는 컬럼 타입 모두 가져다가 사용
-------test2.sql
set SERVEROUTPUT ON
DECLARE
    vempno emp.empno%TYPE;
    vename emp.ename%TYPE;
BEGIN
     DBMS_OUTPUT.PUT_LINE('사번/이름');
    DBMS_OUTPUT.PUT_LINE('-----------');
    
    select empno,ename into vempno,vename
    from emp
    where ename='SCOTT';

    DBMS_OUTPUT.PUT_LINE(vempno||'/'||vename);
END;

@C:\DBSQL\plsql\test2;

--(2) 테이블  TYPE
--(예)테이블 변수를 사용해서 emp테이블에서 이름과 업무를 출력?
 type ename_table_type is table of  emp.ename%TYPE
 index by BINARY_INTEGER;

----
 set SERVEROUTPUT ON
DECLARE
-- 테이블 타입 정의
   type ename_table_type is table of  emp.ename%TYPE
   index by BINARY_INTEGER;
   type job_table_type is table of  emp.job%TYPE
   index by BINARY_INTEGER;
--------------------------test3.sql
-- 변수 정의
   ename_table  ename_table_type;
   job_table job_table_type;
   i BINARY_INTEGER := 0;
BEGIN
    -- emp에서 사원이름과 직급 얻어오기
    for k in(select ename,job from emp) loop
        i := i+1;
        ename_table(i) := k.ename;
        job_table(i) := k.job;
    end loop;

   for j in  1..i loop
       --DBMS_OUTPUT.PUT_LINE(ename_table(j)||' / '||job_table(j));
       DBMS_OUTPUT.PUT_LINE(RPAD(ename_table(j),12)||' / '|| LPAD(job_table(j), 9));
   end loop; 

END;

@C:\DBSQL\plsql/test3-- 블럭처리후 실행

--(3) RECORD TYPE
---: 여러개의 필드(컬럼)를 묶어서 하나의 레코드 타입으로 변수 선언
--- : 테이블로부터 읽어들인 행의 값을 저장해야 할 경우 사용.
-------------------test4.sql
set SERVEROUTPUT ON
DECLARE
  -- record타입 정의
    TYPE emp_record_type IS RECORD(
     v_empno emp.empno%TYPE,
     v_ename emp.ename%TYPE,
     v_job emp.job%TYPE,
     v_deptno emp.deptno%TYPE
    );
    --레코드로 변수 선언
    emp_record emp_record_type;
BEGIN
     
    select empno,ename, job,deptno into emp_record
    from emp
    where ename= upper('SCOTT');

    DBMS_OUTPUT.PUT_LINE('사원번호: '|| emp_record.v_empno);
    DBMS_OUTPUT.PUT_LINE('이   름: '|| emp_record.v_ename);
    DBMS_OUTPUT.PUT_LINE('담당업무: '|| emp_record.v_job);
    DBMS_OUTPUT.PUT_LINE('부서번호: '|| emp_record.v_deptno);
END;


--(4)조건문
IF~THEN~ENDIF
---------------------test5.sql
--(예)부서 번호로 부서명 알아내기
--   사원번호가 7788인 사원의 부서번호를 얻어와서 부서번호에 따른 부서명 구하기

set SERVEROUTPUT ON
DECLARE
   vempno number(4);
   vename varchar2(20);
   vdeptno emp.deptno%TYPE;
   vdname varchar2(20):= null;
BEGIN
    select empno,ename,deptno into vempno,vename,vdeptno
    from emp
    where empno=7788;
       
    IF(vdeptno=10)THEN
     vdname := 'ACCOUNTING';
    END IF;
    IF(vdeptno=20)THEN
     vdname := 'RESEARCH';
    END IF;
    IF(vdeptno=30)THEN
     vdname := 'SALES';
    END IF;
    IF(vdeptno=40)THEN
     vdname := 'OPERATIONS';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 이름 부서명');
    DBMS_OUTPUT.PUT_LINE(vempno||' '||vename||' '||vdname);
END;

--(예) 연봉 구하기
set SERVEROUTPUT ON
DECLARE
    vemp emp%ROWTYPE;
    annsal number(7,2);
BEGIN
--scott사원의 전체 정보를 row단위로 얻어와서 vemp저장

    select * into vemp
    from emp
    where ename='SCOTT';
    
    if(vemp.comm is null) then
       annsal:=vemp.sal*12;
    else
       annsal:=vemp.sal*12+vemp.comm;
    end if;
    
 DBMS_OUTPUT.PUT_LINE('사번/이름/연봉');
    DBMS_OUTPUT.PUT_LINE('-----------');
    
    DBMS_OUTPUT.PUT_LINE(vemp.epmno||'/'||vemp.ename||' '||annsal);
END;








