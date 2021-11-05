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
    
    DBMS_OUTPUT.PUT_LINE(vemp.empno||'/'||vemp.ename||' '||annsal);
END;

