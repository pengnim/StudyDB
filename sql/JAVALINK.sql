
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