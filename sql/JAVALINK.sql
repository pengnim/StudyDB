
--테이블 만들기
drop table member1;

create table member1(
id VARCHAR2(15) primary key,
password varchar2(10),
name varchar2(10),
age number,
addr varchar2(50),
email varchar2(30)
);

--테이블에 데이터 넣기
insert into member1 values('hong2','1234','hongkil',20,'서울시','hong@hong.com');
commit;

select * from member1;

INSERT INTO member1 VAlUES('aaa','aaa','홍길동',22,'서울시','a@a.com');
commit;

SELECT * 
FROM member1 
WHERE id = 'aaa' AND password = 'aaa';

-------------------------------------
drop table goodsinfo;

create table goodsinfo(
	code char(5) not null primary key,
	name varchar2(30) not null,
	price number(8) not null,
	maker varchar2(20)
);

--입력
insert into goodsinfo values('10001','디지털 TV',35000,'LG');
insert into goodsinfo values('10002','LCD TV',135000,'삼성');
insert into goodsinfo values('10003','LED TV',235000,'LG');
insert into goodsinfo values('10004','UHD TV',335000,'삼성');
insert into goodsinfo values('10005','OLED TV',435000,'LG');

commit;
--검색
select * from goodsinfo;
--삭제
delete goodsinfo where code='22222';
commit;

--수정
update goodsinfo set maker='samsung' where code='10001';






--
select * from product;


----------------------------Java_PRocedure 연결사용
--1.
--[결과]
--2^3 = 8
--I I   O
--a_exponent가 음수이면 값을 0으로 변경하고,1을 반환

create or replace procedure compute_power(
	a_num In number,
	a_exponent IN OUT number,
	a_power OUT number
)
IS
BEGIN
 IF a_exponent < 0 THEN
 a_exponent := 0;
 END IF;
 a_power := 1;
 
 FOR i IN 1..a_exponent   LOOP
   a_power := a_power*a_num;
 END LOOP;
 
END;


------------------------------------
create or replace procedure javatest(
	p1 in varchar2,
	p2 in out varchar2,
	p3 out varchar2
)
as
BEGIN
	p2 := p1 || p2;
	p3 := p1;
	
END;


-----------------------Java_Procedure2: Java_Procedure_Test.zip
[방과후 학습]
--1. 저장 프로시저 정리
--2. 과제 수행
CREATE TABLE member3 (
	id VARCHAR2(12),
	passwd VARCHAR2(12),
	name VARCHAR2(12),
	age NUMBER,
	addr VARCHAR2(50),
	email VARCHAR2(30)
)

create or replace PROCEDURE user_insert(
    user_id varchar2,
    user_pw varchar2,
    user_name varchar2,
    user_age number,
    user_addr varchar2,
    user_email varchar2
)
IS
BEGIN
 insert into member3 
 values(user_id,user_pw,user_name,user_age,user_addr,user_email);
END;