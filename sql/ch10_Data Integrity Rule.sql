--ch10.Data Integrity Rule(데이터 무결성 제약조건)
--: 테이블에 부적절한 자료가 입력 되는 것을 방지 하기 위해서
--           테이블을 생성할때 컬럼에 대해서 정의 여러규칙.
--1. 무결성 제약조건 6가지
-- not null:반드시 값이 존재
-- unique: 중복된값 불가, null불허
-- primary key : 중복불가,null X
-- foreign key : 중복가능,null O, 범위(domain)이내의 값만 존재
-- check:  범위, 조건값
-- default :  기본값

--무결성 제약조건 확인방법: 
desc user_constraints;

select * from dept;
desc dept;

select constraint_name, constraint_type, table_name from user_constraints;
--R:References key = Foreign key
--P:Primary key
--U:Unique
--C: Check not null

drop table dept_second;
create table dept_second(
    dno number(2) CONSTRAINT pk_dept_second primary key,
    dname varchar2(14),
    loc varchar2(13)
);

--2. not null
drop table emp01;
create table emp01(
    empno number(4) not null,
    ename varchar2(10),
    job varchar2(9),
    deptno number(2)
);
insert into emp01 values(null,null,'saleman',30);
insert into emp01 values(0,0,'saleman',30);
insert into emp01 values(0,'0','saleman',30);
select * from emp01;


--3.Unique
--:유일한 값만 허용(중복된 값 불가, null O)
drop table emp02;
create table emp02(
    empno number(4) unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp02 values(1234,'hong','saleman',30);
insert into emp02 values(1234,'h2','saleman',30);
--=>ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011096)에 위배됩니다
insert into emp02 values(null,'h2','saleman',30);

select * from emp02;

 --(예) unique 속성에 null 값이 들어오지 못하게 설정하기
 drop table emp022;
create table emp022(
    empno number(4) unique not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2)
);

insert into emp022(empno,ename,deptno) values(2222,'hong',30);
select * from emp022;

--4.Primary key
-- unique+not null : 중복X, null X
-- 하나의 테이블에 기본키는 한개 까지만 가능
 drop table emp03;
create table emp03(
    empno number(4) constraint emp03_empno_pk primary key,--컬럼 레벨
    ename varchar2(10) constraint emp03_ename_nn not null,
    job varchar2(9),
    deptno number(2)
    --constraint emp03_empno_pk primary key--테이블 레벨
);

insert into emp03 values(2222,'hong','SALESMAN',30);
insert into emp03 values(2222,'hong',null,NULL);
--=>ORA-00001: 무결성 제약 조건(SCOTT.EMP03_EMPNO_PK)에 위배됩니다
insert into emp03 values(null,'hong',null,NULL);
--=>ORA-01400: NULL을 ("SCOTT"."EMP03"."EMPNO") 안에 삽입할 수 없습니다
select * from emp03;


--5.Foreign Key(=References Key)
--:다른 테이블의 기본키를 가져다가 컬럼으로 사용하는 것
--:중복값 허용,범위내 값(domain),null허용
drop table emp04;
create table emp04(
    empno number(4) constraint emp04_empno_pk primary key,
    ename varchar2(10) constraint emp04_ename_nn not null,
    job varchar2(9),
    deptno number(2) constraint emp04_deptno_fk REFERENCES dept(deptno)--컬럼 레벨
    --constraint emp04_deptno_fk REFERENCES dept(deptno)
);

insert into emp04 values(1111,'hong','SALESMAN',30);
insert into emp04 values(2222,'hong','SALESMAN',50);--x
--=>ORA-02291: 무결성 제약조건(SCOTT.EMP04_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
insert into emp04 values(3333,'hong','SALESMAN',null);--o
insert into emp04 values(4444,'hong','SALESMAN',0);--x
--=>ORA-02291: 무결성 제약조건(SCOTT.EMP04_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
insert into emp04 values(5555,'hong','SALESMAN',30);--o
select * from emp04;

--6.Check

drop table emp05;
create table emp05(
    empno number(4) constraint emp05_empno_pk primary key,
    ename varchar2(10) constraint emp05_ename_nn not null,
    sal number(7,2)  check(sal between 500 and 5000),
    gender varchar2(1)  check(gender in ('M','F'))
);

insert into emp05 values(1111,'hong',2000,'F');--o
insert into emp05 values(1111,'hong',2000,'여');--x
--=>ORA-12899: "SCOTT"."EMP05"."GENDER" 열에 대한 값이 너무 큼(실제: 2, 최대값: 1)
select * from emp05;

select constraint_name,constraint_type,table_name, SEARCH_CONDITION
from user_constraints
where table_name='EMP05';

--7.default

drop table dept01;
create table dept01(
    deptno number(2) primary key,
    dname varchar2(14),
    loc varchar2(13) default 'SEOUL'
);
insert into dept01 values(11,'sales','dallas');
insert into dept01(deptno,dname) values(21,'sales');
insert into dept01 values(13,'sales',null);--o
select * from dept01;

--8.제약조건 변경(258)
drop table emp06;
create table emp06(
    empno number(4),
    ename varchar2(10) constraint emp06_ename_nn not null,
    sal number(7,2)  check(sal between 500 and 5000),
    gender varchar2(1)  check(gender in ('M','F'))
);

insert into emp06 values(1111,'hong',2000,'F');--o
insert into emp06 values(1111,'hong',2000,'여');--x

select * from emp06;

--제약조건 추가
Alter table emp06 ADD Constraint emp06_empno_pk PRIMARY KEY(empno);

--외래키 제약조건 추가하기
drop table emp07;
create table emp07(
    empno number(4) constraint emp07_empno_pk primary key,
    ename varchar2(10) constraint emp07_ename_nn not null,
    job varchar2(9),
    deptno number(2)
);
alter table emp07 ADD constraint epm07_deptno_fk foreign key(deptno) references dept(deptno);
--기본키 제약조건 제거하기
alter table emp07 DRop primary key;


--9.제약조건 활성화(enable)/비활성화(disable)
drop table dept01;
create table dept01(
    deptno number(2) constraint dept01_deptno_pk primary key,
    dname varchar2(14),
    loc varchar2(13)
);
insert into dept01 values(10,'accounting','new york');
insert into dept01 values(20,'accounting','new york');

drop table emp01;
create table emp01(
 empno number(4),
 ename varchar2(10) constraint emp01_ename_nn not null,--컬럼 레벨만 가능
 job varchar2(9) ,
 deptno number(4),
 constraint emp01_empno_pk primary key(empno),--테이블 레벨도 가능
 constraint emp01_job_unique Unique(job),--테이블 레벨도 가능
 Constraint emp01_deptno_fk Foreign Key(deptno) References dept01(deptno)--테이블 레벨도 가능
);
insert into emp01 values(7793,'allen','salesman1',10);
insert into emp01 values(7123,'allen','salesman2',20);

commit;

delete from dept01 where deptno=10;
--=>ORA-02292: 무결성 제약조건(SCOTT.EMP01_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
--제약조건을 비활성화
--=>
alter table emp01 DISABLE constraint emp01_deptno_fk;

delete from dept01 where deptno=10;

alter table emp01 ENABLE constraint emp01_deptno_fk;
--=>ORA-02298: 제약 (SCOTT.EMP01_DEPTNO_FK)을 사용 가능하게 할 수 없음 - 부모 키가 없습니다
rollback;
select * from dept01;

--10. Composite Key(복합키)
--: 2개의 이상의 컬럼이 모여서 기본키를 이루는 것
--복합키는 반드시 테이블 레벨로 작성
drop table member01;
create table member01(
    name varchar2(10),
    address varchar2(30),
    phone varchar2(16),
    constraint member01_compo_pk primary key(name,address)--테이블 레벨
);

select constraint_name, constraint_type,table_name
from user_constraintS
where table_name='MEMBER01';

----------------------교재-----------------------

select substr('오라클메니아',3,4),substrb('오라클메니아',3,4)from dual;




