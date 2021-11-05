--ch15. Procedure & Userdefine Function & Trigger

--1. Stored Procedure
--:일련의 작업들을 하나로 묶어서 저장해 두었다가 호출해서 실행할때 사용
--:복잡한 DML(inserrt,update,delete)을 필요할때마다 간단하게 호출해서 사용
--: 성능향상,호환성 문제해결

drop table emp01;
create table emp01
as
select * from emp;

select * from emp01;

create or replace procedure del_all
IS
BEGIN
   delete from emp01;
END;

exec del_all;

rollback;

--(1)In 매개변수
drop table emp01;
create table emp01
as
select * from emp;

select * from emp01;

create or replace procedure del_ename(
vename  emp01.ename%TYPE

)
IS
BEGIN
   delete from emp01 where ename=vename;
END;

exec del_ename('SMITH');

rollback;

--2)out, IN OUT
create or replace PROCEDURE pro_test(
    meg1 In varchar2,
    meg2 OUT varchar2,
    meg3 IN OUT varchar2
)
IS
BEGIN
    meg2 := meg1 || ' param out';
    meg3 := meg3 || ' return';

END pro_test;

--익명블록
set SERVEROUTPUT on
DECLARE
    in_param VARCHAR2(50) := 'this is the in';
    out_param VARCHAR2(50);
    inout_param VARCHAR2(50) := 'and This is the in out';

BEGIN
   pro_test( in_param,  out_param, inout_param);
   DBMS_OUTPUT.put_line(out_param || ' ' ||inout_param);
END;

--(예)사원번호로 특정 고객을 조회?
create or replace procedure sel_empno(
 vempno in emp.empno%TYPE,
 vename OUT emp.ename%TYPE,
 vsal OUT emp.sal%TYPE,
 vjob OUT emp.job%TYPE
)
IS
BEGIN
select ename,sal,job into vename,vsal,vjob
from emp
where empno = vempno;
END;

variable var_ename varchar2(15);
variable var_sal number;
variable var_job varchar2(9);

exec sel_empno(7788,:var_ename, :var_sal,:var_job);

PRINT var_ename;
