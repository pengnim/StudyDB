-- Ch01. Oracle & DataBase
--Relation DataBase: 테이블과 테이블사이의 관계를 통해서 데이터 저장,검색하는것
--DBMS:Oracle,MySQL, MS-SQL

--테이블 만들기
create table employee(
    eno number(4) primary key,
    ename varchar2(10),
    job varchar2(9),
    manager number(4),
    hiredate date,
    salary number(7,2),
    commission number(7,2),
    dno number(2)REFERENCES department
);

create table department(
    dno number(2) PRIMARY KEY,
    dname varchar2(14),
    loc varchar2(13)
);

create table salgrade(
    grade number,
    losal number,
    hisal number
);


insert into employee 
values(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);


insert into department values(20,'RESEARCH','DALLAS');






select * from emp;

select * from dept;



------------------------------------------------------
drop table employee;
drop table department;
drop table salgrade;
-- 테이블 만들때는 부모 테이블을 먼저 만들고 다음에 자식 테이블 만들어야 한다.
-- 테이블을 지울때는 자식 테이블을 먼저 지우고, 다음에 부모를 지운다.


commit;
rollback;--실행취소,철회

select * from employee;
select * from department;
select * from salgrade;

--부모 테이블
create table department
        (dno number(2) primary key,
         dname varchar2(14),
	 loc   varchar2(13)
) ;

--자식테이블
create table employee 
        (eno number(4) primary key ,
	 ename varchar2(10),
 	 job   varchar2(9),
	 manager  number(4),
	 hiredate date,
	 salary number(7,2),
	 commission number(7,2),
	 dno number(2) REFERENCES department(dno)
);

create table salgrade
        (grade number,
	 losal number,
	 hisal number 
);

insert into department values (10,'ACCOUNTING','NEW YORK');
insert into department values (20,'RESEARCH','DALLAS');
insert into department values (30,'SALES','CHICAGO');
insert into department values (40,'OPERATIONS','BOSTON');

insert into employee values (7369,'SMITH','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,null,20);
insert into employee values(7499,'ALLEN','SALESMAN', 7698,to_date('20-2-1981', 'dd-mm-yyyy'),1600,300,30);
insert into employee values(7521,'WARD','SALESMAN',  7698,to_date('22-2-1981', 'dd-mm-yyyy'),1250,500,30);
insert into employee values(7566,'JONES','MANAGER',  7839,to_date('2-4-1981',  'dd-mm-yyyy'),2975, null,20);
insert into employee values(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981', 'dd-mm-yyyy'),1250,1400,30);
insert into employee values(7698,'BLAKE','MANAGER',  7839,to_date('1-5-1981',  'dd-mm-yyyy'),2850, null,30);
insert into employee values(7782,'CLARK','MANAGER',  7839,to_date('9-6-1981',  'dd-mm-yyyy'),2450, null,10);
insert into employee values(7788,'SCOTT','ANALYST',  7566,to_date('13-07-1987', 'dd-mm-yyyy'),3000, null,20);
insert into employee values(7839,'KING','PRESIDENT', NULL,to_date('17-11-1981','dd-mm-yyyy'),5000, null,10);
insert into employee values(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981',  'dd-mm-yyyy'),1500,0,30);
insert into employee values(7876,'ADAMS','CLERK',    7788,to_date('13-07-1987', 'dd-mm-yyyy'),1100, null,20);
insert into employee values(7900,'JAMES','CLERK',    7698,to_date('3-12-1981', 'dd-mm-yyyy'),950, null,30);
insert into employee values(7902,'FORD','ANALYST',   7566,to_date('3-12-1981', 'dd-mm-yyyy'),3000, null,20);
insert into employee values(7934,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300, null,10);

--추가
--primary key 제약조건(eno): not null, 중복값X
--foreign Key 제약조건(dno): 부모 테이블의 기본키(dno)를 하나의 컬럼으로 놓은것
--      :그 컬럼은 domain(10,20,30,40), 중복된값, null
insert into employee values(1000,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300, null,10);
insert into employee values(2000,'MILLER','CLERK',   7782,to_date('23-1-1982', 'dd-mm-yyyy'),1300, null,null);

insert into salgrade values (1, 700,1200);
insert into salgrade values (2,1201,1400);
insert into salgrade values (3,1401,2000);
insert into salgrade values (4,2001,3000);
insert into salgrade values (5,3001,9999);

commit;
--30---------------------------------------------
desc department;--describe

select * from employee;
select eno,ename from employee;
--연봉구하기
select ename,salary,salary*12 from employee;
select ename,salary,salary*12,salary*12+commission
from employee;

-- null+10 =>null, 0+10=>10
select ename,salary,job,dno,nvl(commission,0) 보너스,salary*12,salary*12+nvl(commission,0)"연 봉"
from employee;

--dual table : 가상 테이블
select * from employee;
select sysdate from employee;
select sysdate from dual;


