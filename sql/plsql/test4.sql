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

