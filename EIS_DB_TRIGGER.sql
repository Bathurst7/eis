-- TRIGGER TO VALIDATE UNIQUE AND VALID EMAIL 
CREATE OR REPLACE FUNCTION validate_email()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiểm tra cú pháp email hợp lệ
    IF NOT (NEW.E_MAIL_ADDRESS ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') THEN
        RAISE EXCEPTION 'Email không hợp lệ: %', NEW.E_MAIL_ADDRESS;
    END IF;

    -- Kiểm tra trùng lặp email trong bảng tương ứng
    IF TG_TABLE_NAME = 'applicant' THEN
        IF EXISTS (
            SELECT 1 
            FROM PUBLIC.APPLICANT 
            WHERE E_MAIL_ADDRESS = NEW.E_MAIL_ADDRESS
              AND APPLICANT_ID != NEW.APPLICANT_ID -- Đảm bảo không tự so sánh
        ) THEN
            RAISE EXCEPTION 'Email đã tồn tại trong bảng APPLICANT: %', NEW.E_MAIL_ADDRESS;
        END IF;
    ELSIF TG_TABLE_NAME = 'employee' THEN
        IF EXISTS (
            SELECT 1 
            FROM PUBLIC.EMPLOYEE 
            WHERE E_MAIL_ADDRESS = NEW.E_MAIL_ADDRESS
              AND EMPLOYEE_ID != NEW.EMPLOYEE_ID -- Đảm bảo không tự so sánh
        ) THEN
            RAISE EXCEPTION 'Email đã tồn tại trong bảng EMPLOYEE: %', NEW.E_MAIL_ADDRESS;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---CREATE TRIGGER FOR APLLICANT TABLE 
CREATE TRIGGER trigger_validate_applicant_email
BEFORE INSERT OR UPDATE ON APPLICANT
FOR EACH ROW
EXECUTE FUNCTION validate_email();

---CREATE TRIGGER FOR EMPLOYEE TABLE
CREATE TRIGGER trg_validate_employee_email
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
EXECUTE FUNCTION validate_email();

-------------------------------------------------------------
---TRIGGER TO VALIDATE PHONE_NUMBER
CREATE OR REPLACE FUNCTION validate_phone_number()
RETURNS TRIGGER AS $$
BEGIN
    -- Regex kiểm tra số điện thoại hợp lệ
    IF NOT (NEW.PHONE_NUMBER ~ '^0(32|33|34|35|36|37|38|39|96|97|98|86|83|84|85|81|82|88|91|94|70|79|77|76|78|90|93|89|56|58|92|59|99)[0-9]{7}$') THEN
        RAISE EXCEPTION 'Invalid phone number format: %', NEW.PHONE_NUMBER;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---CREATE TRIGGER FOR EMPLOYEE TABLE
CREATE TRIGGER check_employee_phone_number
BEFORE INSERT OR UPDATE ON EMPLOYEE
FOR EACH ROW
EXECUTE FUNCTION validate_phone_number();

---CREATE TRIGGER FOR APPLICANT TABLE
CREATE TRIGGER check_apllicant_phone_number
BEFORE INSERT OR UPDATE ON APPLICANT
FOR EACH ROW
EXECUTE FUNCTION validate_phone_number();

--------------------------------------------------------
---TRIGGER TO VALIDATE TIME
CREATE OR REPLACE FUNCTION validate_timestamps()
RETURNS TRIGGER AS $$
BEGIN
    -- Kiểm tra thời gian kết thúc trong JOB_DESCRIPTION
    IF TG_TABLE_NAME = 'job_description' AND NEW.END_TIME < NOW() THEN
        RAISE EXCEPTION 'END_TIME must be in the future: %', NEW.END_TIME;
    END IF;

    -- Kiểm tra lịch phỏng vấn trong INTERVIEW
    IF TG_TABLE_NAME = 'interview' AND NEW.SCHEDULE_DATE < NOW() THEN
        RAISE EXCEPTION 'SCHEDULE_DATE must be in the future: %', NEW.SCHEDULE_DATE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---CREATE TRIGGER FOR JOB_DESCRIPTION
CREATE TRIGGER check_job_description_end_time
BEFORE INSERT OR UPDATE ON JOB_DESCRIPTION
FOR EACH ROW
EXECUTE FUNCTION validate_timestamps();

----------------------------------------------
---TRIGGER VALIDATE PARTIAL_EVALUATION VALUE
CREATE OR REPLACE FUNCTION validate_partial_evaluation()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.partial_evaluation < 0 OR NEW.partial_evaluation > 10 THEN
        RAISE EXCEPTION 'Partial evaluation must be between 0 and 10: %', NEW.partial_evaluation;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_partial_evaluation
BEFORE INSERT OR UPDATE ON INTERVIEW_DETAIL
FOR EACH ROW
EXECUTE FUNCTION validate_partial_evaluation();

--------------------------------
---TRIGGER CALCULATE AVERAGE EVALUATION VALUE
CREATE OR REPLACE FUNCTION update_interview_evaluation()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE INTERVIEW
    SET EVALUATION = (
        SELECT AVG(partial_evaluation)
        FROM interview_detail
        WHERE interview_id = NEW.interview_id
    )
    WHERE INTERVIEW_ID = NEW.interview_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

---CREATE TRIGGER UPDATE EVALUATION
CREATE TRIGGER update_evaluation_trigger
AFTER INSERT OR UPDATE OR DELETE
ON interview_detail
FOR EACH ROW
EXECUTE FUNCTION update_interview_evaluation();



--------------------------------------
---FUNCTION VALIDATE INTERVIEW SCHEDULE
--FOR APPLICANT
CREATE OR REPLACE FUNCTION check_interview_schedule()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INTERVIEW
        WHERE APPLICATION_ID IN (
            SELECT APPLICATION_ID
            FROM APPLICATION
            WHERE APPLICANT_ID = (
                SELECT APPLICANT_ID
                FROM APPLICATION
                WHERE APPLICATION_ID = NEW.APPLICATION_ID
            )
        )
        AND SCHEDULE_DATE = NEW.SCHEDULE_DATE
    ) THEN
        RAISE EXCEPTION 'Applicant already has an interview scheduled at this time: %', NEW.SCHEDULE_DATE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_interview_schedule
BEFORE INSERT OR UPDATE ON INTERVIEW
FOR EACH ROW
EXECUTE FUNCTION check_interview_schedule();

--FOR INTERVIEWER
CREATE OR REPLACE FUNCTION check_interviewer_schedule()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INTERVIEW_DETAIL id
        JOIN INTERVIEW i ON id.INTERVIEW_ID = i.INTERVIEW_ID
        WHERE id.INTERVIEWER_ID IN (
            SELECT INTERVIEWER_ID
            FROM INTERVIEW_DETAIL
            WHERE INTERVIEW_ID = NEW.INTERVIEW_ID
        )
        AND i.SCHEDULE_DATE = NEW.SCHEDULE_DATE
    ) THEN
        RAISE EXCEPTION 'Interviewer already has an interview scheduled at this time: %', NEW.SCHEDULE_DATE;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_interviewer_schedule
BEFORE INSERT OR UPDATE ON INTERVIEW
FOR EACH ROW
EXECUTE FUNCTION check_interviewer_schedule();
