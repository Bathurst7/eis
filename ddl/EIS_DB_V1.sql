-- 1. CREATE TABLE JOB_DESCRIPTION
CREATE TABLE
  "JOB_DESCRIPTION" ( "JOB_DESCRIPTION_ID" integer
  PRIMARY KEY
    ,
    "JOB_POSITION" varchar(50),
    "DEPARTMENT" varchar(50),
    "CAMPUS" varchar(50),
    "REQUIREMENT" text,
    "SALARY_RANGE" varchar(50),
    "NUMBER_OF_RECRUITMENT" integer,
    "END_TIME" timestamp );
  -- 2. CREATE TABLE EMPLOYEE
CREATE TABLE
  "EMPLOYEE" ( "EMPLOYEE_ID" integer
  PRIMARY KEY
    ,
    "NAME" varchar(50),
    "DEPARTMENT_ID" integer,
    "ROLE" varchar(50),
    "PHONE_NUMBER" char(10),
    "E_MAIL_ADDRESS" varchar(50),
    "CONTRACT_ID" integer );
  -- 3. CREATE TABLE PERSON IN CHARGE
CREATE TABLE
  "PERSON_IN_CHARGE" ( "PIC_ID" integer
  PRIMARY KEY
    ,
    "JOB_DESCRIPTION_ID" integer,
    "EMPLOYEE_ID" integer );
  -- 4. CREATE TABLE APPLICANT
CREATE TABLE
  "APPLICANT" ( "APPLICANT_ID" integer
  PRIMARY KEY
    ,
    "NAME" varchar(50),
    "PHONE_NUMBER" char(10),
    "E_MAIL_ADDRESS" varchar(50),
    "CURRICULUM_VITAE" text );
  -- 5. CREATE TABLE APPLICATION
CREATE TABLE
  "APPLICATION" ( "APPLICATION_ID" integer
  PRIMARY KEY
    ,
    "APPLICANT_ID" integer,
    "JOB_DESCRIPTION_ID" integer,
    "APPLICATION_STATUS" varchar(30) );
  -- 6. CREATE TABLE INTERVIEW
CREATE TABLE
  "INTERVIEW" ( "INTERVIEW_ID" integer
  PRIMARY KEY
    ,
    "APPLICATION_ID" integer,
    "INTERVIEW_STATUS" varchar(30),
    "EVALUATION" integer,
    "SCHEDULE_DATE" timestamp,
    "SIDE_NOTE" text );
  -- 7. CREATE TABLE INTERVIEW DETAIL
CREATE TABLE
  "INTERVIEW_DETAIL" ( "INTERVIEW_DETAIL_ID" integer
  PRIMARY KEY
    ,
    "INTERVIEW_ID" integer,
    "INTERVIEWER_ID" integer );
  -- 8. CREATE TABLE CONTRACT
CREATE TABLE
  "CONTRACT" ( "CONTRACT_ID" integer
  PRIMARY KEY
    ,
    "APPLICANT_ID" integer,
    "REPRESENTATIVES_ID" integer,
    "START_DATE" timestamp,
    "END_DATE" timestamp,
    "SALARY" decimal(10,
      2) );
  -- 1. Add foreign key constraint for PERSON_IN_CHARGE on JOB_DESCRIPTION_ID
ALTER TABLE
  "PERSON_IN_CHARGE"
ADD CONSTRAINT
  fk_person_in_charge_job_description
FOREIGN KEY
  ("JOB_DESCRIPTION_ID")
REFERENCES
  "JOB_DESCRIPTION" ("JOB_DESCRIPTION_ID");
  -- 2. Add foreign key constraint for PERSON_IN_CHARGE on EMPLOYEE_ID
ALTER TABLE
  "PERSON_IN_CHARGE"
ADD CONSTRAINT
  fk_person_in_charge_employee
FOREIGN KEY
  ("EMPLOYEE_ID")
REFERENCES
  "EMPLOYEE" ("EMPLOYEE_ID");
  -- 3. Add foreign key constraint for APPLICATION on JOB_DESCRIPTION_ID
ALTER TABLE
  "APPLICATION"
ADD CONSTRAINT
  fk_application_job_description
FOREIGN KEY
  ("JOB_DESCRIPTION_ID")
REFERENCES
  "JOB_DESCRIPTION" ("JOB_DESCRIPTION_ID");
  -- 4. Add foreign key constraint for APPLICATION on APPLICANT_ID
ALTER TABLE
  "APPLICATION"
ADD CONSTRAINT
  fk_application_applicant
FOREIGN KEY
  ("APPLICANT_ID")
REFERENCES
  "APPLICANT" ("APPLICANT_ID");
  -- 5. Add foreign key constraint for INTERVIEW on APPLICATION_ID
ALTER TABLE
  "INTERVIEW"
ADD CONSTRAINT
  fk_interview_application
FOREIGN KEY
  ("APPLICATION_ID")
REFERENCES
  "APPLICATION" ("APPLICATION_ID");
  -- 6. Add foreign key constraint for INTERVIEW_DETAIL on INTERVIEW_ID
ALTER TABLE
  "INTERVIEW_DETAIL"
ADD CONSTRAINT
  fk_interview_detail_interview
FOREIGN KEY
  ("INTERVIEW_ID")
REFERENCES
  "INTERVIEW" ("INTERVIEW_ID");
  -- 7. Add foreign key constraint for INTERVIEW_DETAIL on INTERVIEWER_ID
ALTER TABLE
  "INTERVIEW_DETAIL"
ADD CONSTRAINT
  fk_interview_detail_interviewer
FOREIGN KEY
  ("INTERVIEWER_ID")
REFERENCES
  "EMPLOYEE" ("EMPLOYEE_ID");
  -- 8. Add foreign key constraint for CONTRACT on APPLICANT_ID
ALTER TABLE
  "CONTRACT"
ADD CONSTRAINT
  fk_contract_applicant
FOREIGN KEY
  ("APPLICANT_ID")
REFERENCES
  "APPLICANT" ("APPLICANT_ID");
  -- 9. Add foreign key constraint for EMPLOYEE on CONTRACT_ID
ALTER TABLE
  "EMPLOYEE"
ADD CONSTRAINT
  fk_employee_contract
FOREIGN KEY
  ("CONTRACT_ID")
REFERENCES
  "CONTRACT" ("CONTRACT_ID");