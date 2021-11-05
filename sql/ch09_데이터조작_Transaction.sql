--ch09-데이터 조작과 transaction


--madang
--1.Insert

--(예) Book테이블에서 새로운 도서 '스포츠 의학' 삽입하시오.
--     출판사 "한솔의학서적",가격은 90000
insert into book values(11,'스포츠 의학','한솔의학서적',90000);
--(예) Book테이블에서 새로운 도서 '스포츠 의학' 삽입하시오.
--     출판사 "한솔의학서적",가격은 미정
insert into book(bookid,bookname,publisher) values(12,'스포츠 의학','한솔의학서적');
insert into book values(13,'스포츠 의학','한솔의학서적',null);
select * from book;

--2.update
--(예)Customer 테이블에서 고객번호가 5 고객의 주소를 '대한민국 부산'으로 변경하시오
update Customer
set address='대한민국 부산'
where custid=5;

--3.delete: 하나의 행 삭제
--(예)customer테이블에서 고객번호가 5인 고객을 삭제하기
delete from customer where custid=5;

delete from orders;
delete from customer;
select * from customer;
rollback;