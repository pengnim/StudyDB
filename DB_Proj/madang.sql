/* 출판사 */
CREATE TABLE NewPublisher (
	pubname VARCHAR2(40) NOT NULL, /* 출판사이름 */
	stname VARCHAR2(40), /* 담당자이름 */
	officephone VARCHAR2(30) /* 전화번호 */
);

CREATE UNIQUE INDEX PK_NewPublisher
	ON NewPublisher (
		pubname ASC
	);

ALTER TABLE NewPublisher
	ADD
		CONSTRAINT PK_NewPublisher
		PRIMARY KEY (
			pubname
		);

/* 도서 */
CREATE TABLE NewBook (
	bookid NUMBER NOT NULL, /* 도서번호 */
	bookname VARCHAR2(40), /* 도서이름 */
	price NUMBER, /* 도서단가 */
	pubname VARCHAR2(40) /* 출판사이름 */
);

CREATE UNIQUE INDEX PK_NewBook
	ON NewBook (
		bookid ASC
	);

ALTER TABLE NewBook
	ADD
		CONSTRAINT PK_NewBook
		PRIMARY KEY (
			bookid
		);

/* 고객 */
CREATE TABLE NewCustomer (
	custid NUMBER NOT NULL, /* 고객번호 */
	name VARCHAR2(40), /* 고객이름 */
	address VARCHAR2(40), /* 주소 */
	phone VARCHAR2(30) /* 전화번호 */
);

CREATE UNIQUE INDEX PK_NewCustomer
	ON NewCustomer (
		custid ASC
	);

ALTER TABLE NewCustomer
	ADD
		CONSTRAINT PK_NewCustomer
		PRIMARY KEY (
			custid
		);

/* 도서_고객 */
CREATE TABLE NewOrder (
	orderid NUMBER NOT NULL, /* 주문번호 */
	orderdate DATE, /* 주문일자 */
	saleprice NUMBER, /* 주문금액 */
	bookid NUMBER, /* 도서번호 */
	custid NUMBER /* 고객번호 */
);

CREATE UNIQUE INDEX PK_NewOrder
	ON NewOrder (
		orderid ASC
	);

ALTER TABLE NewOrder
	ADD
		CONSTRAINT PK_NewOrder
		PRIMARY KEY (
			orderid
		);

ALTER TABLE NewBook
	ADD
		CONSTRAINT FK_NewPublisher_TO_NewBook
		FOREIGN KEY (
			pubname
		)
		REFERENCES NewPublisher (
			pubname
		);

ALTER TABLE NewOrder
	ADD
		CONSTRAINT FK_NewBook_TO_NewOrder
		FOREIGN KEY (
			bookid
		)
		REFERENCES NewBook (
			bookid
		);

ALTER TABLE NewOrder
	ADD
		CONSTRAINT FK_NewCustomer_TO_NewOrder
		FOREIGN KEY (
			custid
		)
		REFERENCES NewCustomer (
			custid
		);