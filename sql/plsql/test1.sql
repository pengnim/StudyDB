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
/