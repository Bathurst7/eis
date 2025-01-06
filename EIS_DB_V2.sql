-- CREATE TABLES WITH "IF NOT EXISTS" 

CREATE TABLE IF NOT EXISTS JOB_DESCRIPTION (
    JOB_DESCRIPTION_ID SERIAL PRIMARY KEY,
    JOB_POSITION VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    CAMPUS VARCHAR(50),
    REQUIREMENT TEXT,
    SALARY_RANGE VARCHAR(50),
    NUMBER_OF_RECRUITMENT INTEGER,
    END_TIME TIMESTAMP
);

CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EMPLOYEE_ID SERIAL PRIMARY KEY, 
    NAME VARCHAR(50),
    DEPARTMENT_ID INTEGER,
    ROLE VARCHAR(50),
    PHONE_NUMBER CHAR(10) UNIQUE,
    E_MAIL_ADDRESS VARCHAR(50) UNIQUE,
    CONTRACT_ID INTEGER
);

CREATE TABLE IF NOT EXISTS PERSON_IN_CHARGE (
    PIC_ID SERIAL PRIMARY KEY, 
    JOB_DESCRIPTION_ID INTEGER,
    EMPLOYEE_ID INTEGER
);

CREATE TABLE IF NOT EXISTS APPLICANT (
    APPLICANT_ID SERIAL PRIMARY KEY, 
    NAME VARCHAR(50),
    PHONE_NUMBER CHAR(10) UNIQUE,
    E_MAIL_ADDRESS VARCHAR(50) UNIQUE,
    GENDER VARCHAR(10), 
    EDUCATION VARCHAR(100), 
    CERTIFICATIONS VARCHAR(255), 
    SKILLS TEXT,
    EXPERIENCE TEXT, 
);

CREATE TABLE IF NOT EXISTS APPLICATION (
    APPLICATION_ID SERIAL PRIMARY KEY,
    APPLICANT_ID INTEGER,
    JOB_DESCRIPTION_ID INTEGER,
    APPLICATION_STATUS VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS INTERVIEW (
    INTERVIEW_ID SERIAL PRIMARY KEY, 
    APPLICATION_ID INTEGER,
    INTERVIEW_STATUS VARCHAR(30),
    EVALUATION INTEGER,
    SCHEDULE_DATE TIMESTAMP,
    SIDE_NOTE TEXT
);

CREATE TABLE IF NOT EXISTS INTERVIEW_DETAIL (
    INTERVIEW_DETAIL_ID SERIAL PRIMARY KEY, 
    INTERVIEW_ID INTEGER,
    INTERVIEWER_ID INTEGER,
	PARTIAL_EVALUATION INTEGER
);


CREATE TABLE IF NOT EXISTS CONTRACT (
    CONTRACT_ID SERIAL PRIMARY KEY, 
    APPLICANT_ID INTEGER,
    REPRESENTATIVES_ID INTEGER,
    START_DATE TIMESTAMP,
    END_DATE TIMESTAMP,
    SALARY DECIMAL(10, 2)
);

-- ADD FOREIGN KEY FOR TABLES
ALTER TABLE EMPLOYEE 
    ADD CONSTRAINT fk_contract
    FOREIGN KEY (CONTRACT_ID) REFERENCES CONTRACT (CONTRACT_ID);

ALTER TABLE PERSON_IN_CHARGE 
    ADD CONSTRAINT fk_job_description
    FOREIGN KEY (JOB_DESCRIPTION_ID) REFERENCES JOB_DESCRIPTION (JOB_DESCRIPTION_ID),
    ADD CONSTRAINT fk_employee
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID);

ALTER TABLE APPLICATION 
    ADD CONSTRAINT fk_applicant
    FOREIGN KEY (APPLICANT_ID) REFERENCES APPLICANT (APPLICANT_ID),
    ADD CONSTRAINT fk_job_description
    FOREIGN KEY (JOB_DESCRIPTION_ID) REFERENCES JOB_DESCRIPTION (JOB_DESCRIPTION_ID);

ALTER TABLE INTERVIEW 
    ADD CONSTRAINT fk_application
    FOREIGN KEY (APPLICATION_ID) REFERENCES APPLICATION (APPLICATION_ID);

ALTER TABLE INTERVIEW_DETAIL 
    ADD CONSTRAINT fk_interview
    FOREIGN KEY (INTERVIEW_ID) REFERENCES INTERVIEW (INTERVIEW_ID),
    ADD CONSTRAINT fk_interviewer
    FOREIGN KEY (INTERVIEWER_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID);

ALTER TABLE CONTRACT 
    ADD CONSTRAINT fk_applicant
    FOREIGN KEY (APPLICANT_ID) REFERENCES APPLICANT (APPLICANT_ID);
