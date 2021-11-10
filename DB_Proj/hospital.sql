/* �ǻ� */
CREATE TABLE Doctors (
	doc_id NUMBER NOT NULL, /* �ǻ�ID */
	major_treat VARCHAR2(255) NOT NULL, /* ���������� */
	doc_name VARCHAR2(50) NOT NULL, /* ���� */
	doc_gen CHAR(1) NOT NULL, /* ���� */
	doc_phone VARCHAR2(30), /* ��ȭ��ȣ */
	doc_email VARCHAR2(40), /* �̸��� */
	doc_position VARCHAR2(255) NOT NULL /* ���� */
);

CREATE UNIQUE INDEX PK_Doctors
	ON Doctors (
		doc_id ASC
	);

CREATE UNIQUE INDEX UIX_Doctors
	ON Doctors (
		doc_email ASC,
		doc_id ASC
	);

ALTER TABLE Doctors
	ADD
		CONSTRAINT PK_Doctors
		PRIMARY KEY (
			doc_id
		);

ALTER TABLE Doctors
	ADD
		CONSTRAINT UK_Doctors
		UNIQUE (
			doc_email,
			doc_id
		);

/* ��ȣ�� */
CREATE TABLE Nurses (
	nur_id NUMBER NOT NULL, /* ��ȣ��ID */
	major_job VARCHAR2(255) NOT NULL, /* ������ */
	nur_name VARCHAR2(50) NOT NULL, /* ���� */
	nur_gen CHAR(1) NOT NULL, /* ���� */
	nur_phone VARCHAR2(30), /* ��ȭ��ȣ */
	nur_email VARCHAR2(40), /* �̸��� */
	nur_position VARCHAR2(255) NOT NULL /* ���� */
);

CREATE UNIQUE INDEX PK_Nurses
	ON Nurses (
		nur_id ASC
	);

CREATE UNIQUE INDEX UIX_Nurses
	ON Nurses (
		nur_id ASC,
		nur_email ASC
	);

ALTER TABLE Nurses
	ADD
		CONSTRAINT PK_Nurses
		PRIMARY KEY (
			nur_id
		);

ALTER TABLE Nurses
	ADD
		CONSTRAINT UK_Nurses
		UNIQUE (
			nur_id,
			nur_email
		);

/* ȯ�� */
CREATE TABLE Patients (
	pat_id NUMBER NOT NULL, /* ȯ��ID */
	nur_id NUMBER NOT NULL, /* ��ȣ��ID */
	doc_id NUMBER NOT NULL, /* �ǻ�ID */
	pat_name VARCHAR2(50) NOT NULL, /* ȯ�ڼ��� */
	pat_gen CHAR(1) NOT NULL, /* ȯ�ڼ��� */
	pat_jumin VARCHAR2(13) NOT NULL, /* �ֹι�ȣ */
	pat_addr VARCHAR2(255) NOT NULL, /* �ּ� */
	pat_phone VARCHAR2(30), /* ��ȭ��ȣ */
	pat_email VARCHAR2(40), /* �̸��� */
	pat_job VARCHAR2(255) NOT NULL /* ���� */
);

CREATE UNIQUE INDEX PK_Patients
	ON Patients (
		pat_id ASC
	);

CREATE UNIQUE INDEX UIX_Patients
	ON Patients (
		pat_id ASC,
		pat_email ASC
	);

ALTER TABLE Patients
	ADD
		CONSTRAINT PK_Patients
		PRIMARY KEY (
			pat_id
		);

ALTER TABLE Patients
	ADD
		CONSTRAINT UK_Patients
		UNIQUE (
			pat_id,
			pat_email
		);

/* ���� */
CREATE TABLE Treatments (
	traet_id NUMBER NOT NULL, /* ����ID */
	pat_id NUMBER NOT NULL, /* ȯ��ID */
	doc_id NUMBER NOT NULL, /* �ǻ�ID */
	traet_contents VARCHAR2(255) NOT NULL, /* ���᳻�� */
	traet_date DATE NOT NULL /* ���ᳯ¥ */
);

CREATE UNIQUE INDEX PK_Treatments
	ON Treatments (
		traet_id ASC,
		pat_id ASC,
		doc_id ASC
	);

ALTER TABLE Treatments
	ADD
		CONSTRAINT PK_Treatments
		PRIMARY KEY (
			traet_id,
			pat_id,
			doc_id
		);

/* ��Ʈ */
CREATE TABLE Charts (
	chart_id NUMBER NOT NULL, /* ��Ʈ��ȣ */
	traet_id NUMBER NOT NULL, /* ����ID */
	doc_id NUMBER NOT NULL, /* �ǻ�ID */
	pat_id NUMBER NOT NULL, /* ȯ��ID */
	nur_id NUMBER NOT NULL, /* ��ȣ��ID */
	chart_contents VARCHAR2(255) NOT NULL /* ��Ʈ���� */
);

CREATE UNIQUE INDEX PK_Charts
	ON Charts (
		chart_id ASC,
		traet_id ASC,
		doc_id ASC,
		pat_id ASC
	);

ALTER TABLE Charts
	ADD
		CONSTRAINT PK_Charts
		PRIMARY KEY (
			chart_id,
			traet_id,
			doc_id,
			pat_id
		);

ALTER TABLE Patients
	ADD
		CONSTRAINT FK_Doctors_TO_Patients
		FOREIGN KEY (
			doc_id
		)
		REFERENCES Doctors (
			doc_id
		);

ALTER TABLE Patients
	ADD
		CONSTRAINT FK_Nurses_TO_Patients
		FOREIGN KEY (
			nur_id
		)
		REFERENCES Nurses (
			nur_id
		);

ALTER TABLE Treatments
	ADD
		CONSTRAINT FK_Doctors_TO_Treatments
		FOREIGN KEY (
			doc_id
		)
		REFERENCES Doctors (
			doc_id
		);

ALTER TABLE Treatments
	ADD
		CONSTRAINT FK_Patients_TO_Treatments
		FOREIGN KEY (
			pat_id
		)
		REFERENCES Patients (
			pat_id
		);

ALTER TABLE Charts
	ADD
		CONSTRAINT FK_Treatments_TO_Charts
		FOREIGN KEY (
			traet_id,
			pat_id,
			doc_id
		)
		REFERENCES Treatments (
			traet_id,
			pat_id,
			doc_id
		);

ALTER TABLE Charts
	ADD
		CONSTRAINT FK_Nurses_TO_Charts
		FOREIGN KEY (
			nur_id
		)
		REFERENCES Nurses (
			nur_id
		);