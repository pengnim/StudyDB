--마당 DataBase 만들기

--I. Madang DB 만들기

--1.DataBase 만들기(sys)
create user madang IDENTIFIED BY madang;
GRANT CONNECT,resource TO madang;

Drop table Book;--부모
Drop table Customer;--부모
Drop table Orders;--자식

--2. 테이블 만들기(madang)
create table Book(
    bookid number(2) primary key,
    bookname varchar2(40),
    publisher varchar2(40),
    price number(8)
);
create table Customer(
    custid number(2) primary key,
    name varchar2(40),
    address varchar2(50),
    phone varchar2(20)
);
create table Orders(
    orderid number(2) primary key,
    custid number(2)REFERENCES Customer(custid),
    bookid number(2)REFERENCES Book(bookid),
    saleprice number(8),
    orderdate DATE
);


--3.데이터 입력하기
-- Book, Customer, Orders 데이터 생성
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

-- 주문(Orders) 테이블의 책값은 할인 판매를 가정함
INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

INSERT INTO Orders VALUES (11, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));
--Transaction처리(Commit,rollback): Create,Alter,Drop 관계없음
rollback;--insert,update,delete했다면 취소 하겠다.(commit 하기전)

commit;--완료: 완전저장

select * from book;
select * from customer;
select * from orders;

--II. 참조 무결성을 위한 삭제
 
 --1.  on delete cascade : 순차적 삭제
create table Orders(--자식
    orderid number(2) primary key,
    custid number(2)REFERENCES Customer(custid) on delete cascade,
    bookid number(2)REFERENCES Book(bookid) on delete cascade,
    saleprice number(8),
    orderdate DATE
);
--table 만들기 : 부모, 자식순
--insert만들기 : 부모, 자식순
--update만들기 :
update orders set custid=20 where custid=2;
--==>ORA-02291: 무결성 제약조건(MADANG.SYS_C0011146)이 위배되었습니다- 부모 키가 없습니다
update customer set custid=20 where custid=2;
--=>ORA-02292: 무결성 제약조건(MADANG.SYS_C0011146)이 위배되었습니다- 자식 레코드가 발견되었습니다

commit;
--drop  실행하기 : 자식,부모
drop table customer;
--=>ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다

--delete: on delete cascade인 경우 부모를 삭제하면 자식도 계단 처림(자동삭제) 삭제
delete from customer;
delete from orders;

select * from customer;
select * from orders;

rollback;

select * from book;
select * from customer;
select * from orders;

delete from customer where custid=1;
select * from customer;
select * from orders;

commit;

--자식 삭제는 부모 테이블은 영향 받지 않습니다.
delete from orders where custid=1;--정상 삭제됨
select * from customer;
select * from orders;

--2. on delete set null : 해당 컬럼만 null 값으로 대체 ,삭제시


create table Orders(
    orderid number(2) primary key,
    custid number(2)REFERENCES Customer(custid)on delete set null,
    bookid number(2)REFERENCES Book(bookid)on delete set null,
    saleprice number(8),
    orderdate DATE
);

commit;

--drop : 자식,부모순으로 삭제
--delete: 
delete from customer;
select * from customer;
select * from orders;



-----------------------Madang 과제--------------------
--1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
  
--(1) 도서번호가 1인 도서의 이름
	  select bookname
      from book
      where bookid=1;
--(2) 가격이 20,000원 이상인 도서의 이름
	  select bookname,price
      from book
      where price >=20000;

--(3) 박지성의 총 구매액
	  select sum(saleprice)
      from Customer, Orders
      where customer.custid = orders.custid and customer.name LIKE '박지성';
      
      select sum(saleprice) 총합
      from Orders
      where orders.custid=1;

--(4) 박지성이 구매한 도서의 수
	  select count(*)
      from Customer, Orders
      where customer.custid = orders.custid and customer.name LIKE '박지성';

      select count(bookid) "구매한 도서의 수"
      from Orders
      where orders.custid=1;


--(5) 박지성이 구매한 도서의 출판사 수
      select count(distinct publisher) "출판사 수"
      from Customer, Orders, book
      where customer.custid = orders.custid and Orders.bookid=Book.bookid and customer.name LIKE '박지성';
	
--(6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
	  select bookname,price,price-saleprice
      from Customer, Orders, book
      where customer.custid = orders.custid and Orders.bookid=Book.bookid and customer.name LIKE '박지성';

--(7) 박지성이 구매하지 않은 도서의 이름
      select bookname
      from  book b1
      where not EXISTS (select bookname 
             from Customer, Orders 
             where customer.custid = orders.custid and Orders.bookid=b1.bookid and customer.name LIKE '박지성'
             );
             
      select bookname
      from  book 
      minus (select bookname from book where bookid IN (select bookid from orders where custid=1));
    

--------------------------------회사DB 설계 (회사DB설계_test.zip)------------------

--(1) 테이블을 생성하는 CREATE 문과 데이터를 삽입하는 INSERT 문을 작성하시오. 테이블의
--    데이터 타입은 임의로 정하고, 데이터는 아래 질의의 결과가 나오도록 삽입한다.


drop table department;
drop table employee;
drop table project;
drop table works;


--1. 테이블 만들고 ,데이터 넣기
create table department(
    deptno number not null,
    deptname varchar2(30),
    manager varchar2(30),
    primary key(deptno)
);
create table employee(
    empno number not null,
    name varchar2(30),
    phoneno number,
    address varchar2(30),
    sex varchar2(10),
    position varchar2(30),
    deptno number,
    primary key(empno),
    foreign key(deptno) references department(deptno)
);

create table project(
    projno number not null,
    projname varchar2(30),
    deptno number,
    primary key(projno),
    foreign key(deptno) references department(deptno)
);

create table works(
    projno number not null,
    empno number not null,
    hours_worked number,
    primary key(projno,empno),
    foreign key(projno) references project(projno),
    foreign key(empno) references employee(empno)
);

insert into department values(1,'IT','알파고');
insert into department values(2,'Marketing','홍길동');

insert into employee values(1,'홍길동1','01012345678','서울1','여','Programmer',1);
insert into employee values(2,'홍길동2','01044345678','서울2','남','Programmer',1);
insert into employee values(3,'홍길동3','01012345678','서울3','여','Salesperson',2);
insert into employee values(4,'홍길동','01012345678','서울4','남','Manager',2);
insert into employee values(5,'알파고','01012345678','서울5','여','Manager',1);

insert into project values(1,'데이터베이스 구축',1);
insert into project values(2,'시장 조사',2);

insert into works values(1,1,3);
insert into works values(1,2,1);
insert into works values(2,3,1);
insert into works values(2,4,5);
insert into works values(1,5,1);

commit;

select * from department;
select * from employee;
select * from project;
select * from works;

--(2) 모든 사원의 이름을 보이시오.
	select name from employee;
--(3) 여자 사원의 이름을 보이시오.
    select name from employee where sex LIKE '여';
--(4) 팀장(manager)의 이름을 보이시오.
	select manager from department;
--(5) ‘IT’ 부서에서 일하는 사원의 이름과 주소를 보이시오.
	select name,address
    from employee e, department d
    where e.deptno=d.deptno and deptname LIKE 'IT';
--(6) ‘홍길동’ 팀장(manager) 부서에서 일하는 사원의 수를 보이시오.
	select count(name)
    from employee e,(select deptno from  department where manager LIKE '홍길동') dn 
    where e.deptno =dn.deptno;
--(7) 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오.
	select deptno,name,sum(hours_worked)--4
    from employee e, works w  --1
    where e.empno = w.empno   --2
    group by deptno,name      --3
    order by deptno;          --5
    
--(8) 두 명 이상의 사원이 참여한 프로젝트의 번호, 이름, 사원의 수를 보이시오.
	select p.projno,p.projname,count(name)
    from employee e, project p
    where p.deptno = e.deptno
    Group by p.projno,p.projname
    having count(*) >=2;
--(9) 세 명  이상의 사원이 있는 부서의 사원 이름을 보이시오.
	select name
    from employee e,department d
    where e.deptno = d.deptno and deptname = (
     select deptname 
     from employee e, department d
     where e.deptno= d.deptno
     Group by deptname
     having count(name) >= 3
    );
    

