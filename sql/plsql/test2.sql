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