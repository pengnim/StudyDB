create table mms_member(
	id number primary key,
	name varchar2(12) unique not null,
	addr varchar2(50) not null,
	nation varchar2(12) not null,
	email varchar2(30) not null,
	age number
);

create sequence member_seq;