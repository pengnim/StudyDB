-- 교재 프로젝트:: 병원관리
DROP USER hospital CASCADE;
CREATE USER hospital IDENTIFIED BY hospital;
GRANT CONNECT, RESOURCE TO hospital;

-- ============
CREATE TABLE Doctors(
	doc_id               NUMBER(10) NOT NULL ,
	major_treat          VARCHAR2(25) NOT NULL ,
	doc_name             VARCHAR(20) NOT NULL ,
	doc_gen              CHAR(1) NOT NULL ,
	doc_phone            VARCHAR2(15) NULL ,
	doc_email            VARCHAR2(50) UNIQUE ,
	doc_position         VARCHAR(20) NOT NULL 
);

ALTER TABLE Doctors
	ADD CONSTRAINT  doc_id_pk PRIMARY KEY (doc_id);

CREATE TABLE Nurses(
	nur_id               NUMBER(10) NOT NULL ,
	major_job            VARCHAR2(25) NOT NULL ,
	nur_name             VARCHAR(20) NOT NULL ,
	nur_gen              CHAR(1) NULL ,
	nur_phone            VARCHAR2(15) NULL ,
	nur_email            VARCHAR2(50) UNIQUE ,
	nur_position         VARCHAR(20) NOT NULL 
);

ALTER TABLE Nurses	ADD CONSTRAINT  nur_id_pk PRIMARY KEY (nur_id);

CREATE TABLE Patients(
	pat_id               NUMBER(10) NOT NULL ,
	nur_id               NUMBER(10) NOT NULL ,
	doc_id               NUMBER(10) NOT NULL ,
	pat_name             VARCHAR(20) NOT NULL ,
	pat_gen              CHAR(1) NOT NULL ,
	pat_jumin            VARCHAR2(14) NOT NULL ,
	pat_addr             VARCHAR2(100) NOT NULL ,
	pat_phone            VARCHAR2(15) NULL ,
	pat_email            VARCHAR2(50) UNIQUE ,
	pat_job              VARCHAR(20) NOT NULL 
);

ALTER TABLE Patients	ADD CONSTRAINT  pat_id_pk PRIMARY KEY (pat_id);

CREATE TABLE Treatments(
	treat_id             NUMBER(15) NOT NULL ,
	pat_id               NUMBER(10) NOT NULL ,
	doc_id               NUMBER(10) NOT NULL ,
	treat_contents       VARCHAR2(1000) NOT NULL ,
	treat_date           DATE NOT NULL 
);

ALTER TABLE Treatments	ADD CONSTRAINT  treat_pat_doc_id_pk PRIMARY KEY (treat_id,pat_id,doc_id);

CREATE TABLE Charts(
	chart_id             VARCHAR2(20) NOT NULL ,
	treat_id             NUMBER(15) NOT NULL ,
	doc_id               NUMBER(10) NOT NULL ,
	pat_id               NUMBER(10) NOT NULL ,
	nur_id               NUMBER(10) NOT NULL ,
	chart_contents       VARCHAR2(1000) NOT NULL 
);

ALTER TABLE Charts
	ADD CONSTRAINT  chart_treat_doc_pat_id_pk PRIMARY KEY (chart_id,treat_id,doc_id,pat_id);

ALTER TABLE Patients	ADD (CONSTRAINT R_1 FOREIGN KEY (doc_id) REFERENCES Doctors (doc_id));

ALTER TABLE Patients	ADD (CONSTRAINT R_2 FOREIGN KEY (nur_id) REFERENCES Nurses (nur_id));

ALTER TABLE Treatments	ADD (CONSTRAINT R_4 FOREIGN KEY (doc_id) REFERENCES Doctors (doc_id));

ALTER TABLE Treatments	ADD (CONSTRAINT R_5 FOREIGN KEY (pat_id) REFERENCES Patients (pat_id));

ALTER TABLE Charts	ADD (CONSTRAINT R_7 FOREIGN KEY (treat_id, pat_id, doc_id) REFERENCES Treatments (treat_id, pat_id, doc_id));

ALTER TABLE Charts	ADD (CONSTRAINT R_8 FOREIGN KEY (nur_id) REFERENCES Nurses (nur_id));

--SQL 입력하기==========================================================================================
insert into Doctors values(980312,'소아과','이태정','M','010-333-1340','ltj@hanbh.com','과장');
insert into Doctors values(000601,'내과','안성기','M','011-222-0987','ask@hanbh.com','과장');
insert into Doctors values(001208,'외과','김민종','M','010-333-8743','kmj@hanbh.com','과장');
insert into Doctors values(020403,'피부과','이태서','M','019-777-3764','lts@hanbh.com','과장');
insert into Doctors values(050900,'소아과','김연아','F','010-555-3746','kya@hanbh.com','전문의');
insert into Doctors values(050101,'내과','차태현','M','011-222-7643','cth@hanbh.com','전문의');
insert into Doctors values(062019,'소아과','전지현','F','010-999-1265','jjh@hanbh.com','전문의');
insert into Doctors values(070576,'피부과','홍길동','M','016-333-7263','hgd@hanbh.com','전문의');
insert into Doctors values(080543,'방사선과','유재석','M','010-222-1263','yjs@hanbh.com','과장');
insert into Doctors values(091001,'외과','김병만','M','010-555-3542','kbm@hanbh.com','전문의');
select * from DOCTORS;

insert into NURSES values(050302,'소아과','김영은','F','010-555-8751','key@hanbh.com','수간호사');
insert into NURSES values(050021,'내과','윤성애','F','016-333-8745','ysa@hanbh.com','수간호사');
insert into NURSES values(040089,'피부과','신지원','M','010-666-7646','sjw@hanbh.com','주임');
insert into NURSES values(070605,'방사선과','유정화','F','010-333-4588','yjh@hanbh.com','주임');
insert into NURSES values(070804,'내과','리하나','F','010-222-1340','nhn@hanbh.com','주임');
insert into NURSES values(071018,'소아과','김화경','F','019-888-4116','khk@hanbh.com','주임');
insert into NURSES values(100356,'소아과','이선용','M','010-777-1234','lsy@hanbh.com','간호사');
insert into NURSES values(104145,'외과','김현','M','010-999-8520','kh@hanbh.com','간호사');
insert into NURSES values(120309,'피부과','박성완','M','010-777-4996','psw@hanbh.com','간호사');
insert into NURSES values(130211,'외과','이서언','F','010-222-3214','lsy2@hanbh.com','간호사');
select * from NURSES;

insert into patients values(2345,050302,980312,'안상건','M','232345','서울','010-555-7845','ask@ab.com','회사원');
insert into patients values(3545,040089,020403,'김성룡','M','543545','서울','010-333-7812','ksr@bb.com','자영업');
insert into patients values(3424,070605,080543,'이종진','M','433424','부산','010-888-4859','ljj@ab.com','회사원');
insert into patients values(7675,100356,050900,'최광석','M','677675','당진','010-222-4847','cks@cc.com','회사원');
insert into patients values(4533,070804,000601,'정한경','M','744533','강릉','010-777-9630','jhk@ab.com','교수');
insert into patients values(5546,120309,070576,'유원현','M','765546','대구','016-777-0214','ywh@cc.com','자영업');
insert into patients values(4543,070804,050101,'최재정','M','454543','부산','010-555-4187','cjj@bb.com','회사원');
insert into patients values(9768,130211,091001,'이진희','F','119768','서울','010-888-3675','ljh@ab.com','교수');
insert into patients values(4234,130211,091001,'오나미','F','234234','속초','010-999-6541','onm@cc.com','학생');
insert into patients values(7643,071018,062019,'송성묵','M','987643','서울','010-222-5874','ssm@bb.com','학생');
select * from patients;

insert into TREATMENTS values(130516023, 2345, 980312,'감기몸살',TO_DATE('2013-05-16','yyyy-mm-dd'));
insert into TREATMENTS values(130628100, 3545, 020403,'피부 트러블 치료',TO_DATE('2013-06-28','yyyy-mm-dd'));
insert into TREATMENTS values(131205056, 3424, 080543,'목 디스크로 MRI 촬영',TO_DATE('2013-12-05','yyyy-mm-dd'));
insert into TREATMENTS values(131218024, 7675, 050900,'중이염',TO_DATE('2013-12-18','yyyy-mm-dd'));
insert into TREATMENTS values(131224012, 4533, 000601,'장염',TO_DATE('2013-12-24','yyyy-mm-dd'));
insert into TREATMENTS values(140103001, 5546, 070576,'여드름 치료',TO_DATE('2014-01-13','yyyy-mm-dd'));
insert into TREATMENTS values(140109026, 4543, 050101,'위염',TO_DATE('2014-01-09','yyyy-mm-dd'));
insert into TREATMENTS values(140226102, 9768, 091001,'화상치료',TO_DATE('2014-02-26','yyyy-mm-dd'));
insert into TREATMENTS values(140303003, 4234, 091001,'교통사고 오상치료',TO_DATE('2014-03-03','yyyy-mm-dd'));
insert into TREATMENTS values(140308087, 7643, 062019,'장염',TO_DATE('2014-03-08','yyyy-mm-dd'));
select * from TREATMENTS;

insert into charts values('p_130516023',130516023,980312,2345,050302,'감기 주사 및 약 처방');
insert into charts values('d_130628100',130628100,020403,3545,040089,'피부 감염 방지 주사');
insert into charts values('r_131205056',131205056,080543,3424,070605,'주사 처방');
insert into charts values('p_131218024',131218024,050900,7675,100356,'귓속청소 및 약 처방');
insert into charts values('i_131224012',131224012,000601,4533,070804,'장염 입원치료');
insert into charts values('d_140103001',140103001,070576,5546,120309,'여드름 치료약 처방');
insert into charts values('i_140109026',140109026,050101,4543,070804,'위내시경');
insert into charts values('s_140226102',140226102,091001,9768,130211,'화상 크림약 처방');
insert into charts values('s_140303003',140303003,091001,4234,130211,'입원치료');
insert into charts values('p_140308087',140308087,062019,7643,071018,'장염 입원치료');
select * from charts;

COMMIT;

-- 테스트 하기 ==========================================================================
update doctors
set major_treat ='소아과'
where doc_name = '홍길동';


delete from Nurses
where nur_name='김영은' ;

Alter table patients Drop Constraint R_2;
Alter table patients 
Add (FOREIGN KEY (nur_id) REFERences Nurses(nur_id) ON DELETE CASCADE);

Alter table charts Drop constraint R_8;
Alter table charts
ADD (FOREIGN KEY (nur_id) REFERENCES nurses(nur_id) ON DELETE CASCADE);

Alter table Treatments Drop constraint R_5;
Alter table Treatments
ADD (FOREIGN KEY(pat_id) REFERENCES Patients(pat_id)ON DELETE CASCADE);

select *
from doctors
where major_treat='소아과';

select p.*,d.doc_name
from Doctors d JOIN patients p on (d.doc_id = p.doc_id)
where d.doc_name = '홍길동';

select p.*,t.treat_date
from Treatments t join patients p on (t.pat_id = p.pat_id)
where t.treat_date BETWEEN '2013-12-01' AND '2013-12-31'
order by t.treat_date Asc;

select *
from nurses
where nur_id like '5%';






-- on delete cascade를 기존 참조키르 삭제후 설정하기 (R_1은 제약조건 이름)
ALTER TABLE Patients DROP CONSTRAINT R_1;
ALTER TABLE Charts DROP CONSTRAINT R_2;
ALTER TABLE Treatments  DROP CONSTRAINT R_3;

ALTER TABLE Patients
	ADD (FOREIGN KEY (nur_id) REFERENCES Nurses (nur_id) ON DELETE CASCADE);
ALTER TABLE Charts
	ADD (FOREIGN KEY (nur_id) REFERENCES Nurses (nur_id) ON DELETE CASCADE);
ALTER TABLE Treatments
	ADD (FOREIGN KEY (pat_id) REFERENCES Patients (pat_id) ON DELETE CASCADE);
