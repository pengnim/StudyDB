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


---2. Userdefine Fuction
-- : Built-in함수: 제조사에서 만든 함수
---: 저장프로시저와 유사하지만, return있다.

--(예) 특별 보너스(200%)를 지급하기 위한 저장함수 작성
create or replace FUNCTION cal_bonus(
    vempno IN emp.empno%TYPE
) RETURN number
IS
 vsal number(7,2);
BEGIN
  select  sal     into vsal
  from emp
  where empno = vempno;
  
  RETURN vsal*2;
END;

variable var_res number;
execute :var_res := cal_bonus(7788);
print var_res;


---3.Trigger
--: 방아쇠, 제동기
--: 이벤트 발생하면 자동으로 방아쇠가 당겨지는것
--: 특정 테이블이 변경이 되면, 이를 이벤트로 다른 테이블이 자동으로 변경하도록 설정하는 것
--BEFOR TRIGGER: DML(INSERT,UPDATE,DELETE)문이 실행되기 전에 트리거가 먼저 실행
--AFTER TRIGGER;
--트리거의 유형: FOR EACH ROW;
   -- 문장 레벨 트리거: DML문을 수행시 단 한번만 트리거가 발생
   --                (FOR EACH ROW가 생략 되었을때)
   -- 행레벌 트리거 :DML문에 의해서 여러 행이 변경 된다면, 각 변경될 때마다 트리거가 발생
   --                (FOR EAH ROW를 반드시 사용)
   --                (예) 5개 행이 변경되면 트리거 5번 발생
   --              컬럼의 실제값을 제어 연산자: 변경전값인경우(:OLD), 변경후의 값(:NEW)

drop table emp11;
create table emp11(
 empno number(4) primary key,
 ename varchar2(20),
 job varchar2(20)
);

insert into emp11 values(111,'miller','painter');
insert into emp11 values(222,'miller','painter');
insert into emp11 values(333,'miller','painter');

select * from emp11;

set SERVEROUTPUT ON
create or replace TRIGGER trg_11
AFTER  INSERT
ON emp11
BEGIN
 DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다');
END;

EXEC trg_11;

INSERT INTO emp11 values(555,'scott','salesman');

--(예)급여 정보를 자동으로 추가하는 트리거 만들기
-- 사원 테이블(emp11)에  새로운 데이터가 들어오면, 급여 테이블(sal01)에 새로운 데이터를 자동 생성하는 트리거
create table sal01(
    salno number(4) primary key,--sequence 사용하기
    sal number(7,2),
    empno number(4) REFERENCES emp11(empno)
);

create sequence sal01_salno_seq;

create or replace TRIGGER trg_02
AFTER insert
on emp11
FOR EACH ROW
BEGIN
 INSERT INTO  sal01 values(sal01_salno_seq.nextval,100, :new.empno );
END;

--사원 테이블에 입력하고 실행해서 트리거 적용확인하기
insert into emp11 values(666,'aaa','programmer');


select * from emp11;
select * from sal01;