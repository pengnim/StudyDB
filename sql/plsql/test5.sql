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

