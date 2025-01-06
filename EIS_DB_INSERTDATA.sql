
-- Chèn dữ liệu vào bảng JOB_DESCRIPTION
INSERT INTO JOB_DESCRIPTION (JOB_POSITION, DEPARTMENT, CAMPUS, REQUIREMENT, SALARY_RANGE, NUMBER_OF_RECRUITMENT, END_TIME)
VALUES
('Software Engineer', 'IT', 'Campus A', 'Bachelor degree in Computer Science', '8000-10000', 3, '2025-12-31'),
('HR Manager', 'HR', 'Campus B', '5 years of experience in HR', '6000-8000', 1, '2025-12-31'),
('Marketing Specialist', 'Marketing', 'Campus C', 'Bachelor in Marketing', '5000-7000', 2, '2025-12-31'),
('Product Manager', 'Product', 'Campus A', '5 years of product management experience', '7000-9000', 2, '2025-12-31'),
('Sales Executive', 'Sales', 'Campus B', 'Experience in sales', '4000-6000', 4, '2025-12-31');

-- Chèn dữ liệu vào bảng APPLICANT
INSERT INTO APPLICANT (NAME, PHONE_NUMBER, E_MAIL_ADDRESS, GENDER, EDUCATION, CERTIFICATIONS, SKILLS, EXPERIENCE)
VALUES 
('John Nguyen', '0361234567', 'john.nguyen@gmail.com', 'Male', 'Bachelor of Information Technology', 'TOEIC 850; AWS Certification', 'Java programming, SQL, Python', '2 years at FPT Software'),
('Sophia Tran', '0976543210', 'sophia.tran@example.com', 'Female', 'Master of Business Administration', 'PMP Certification; CFA Certification', 'Project management, Leadership skills', '3 years at VinGroup'),
('Michael Le', '0349876543', 'michael.le@example.com', 'Male', 'Engineer in Electronics and Telecommunications', 'CCNA Certification; IoT Certification', 'Circuit design, IoT technology', '5 years at Viettel R&D'),
('David Pham', '0911234567', 'david.pham@example.com', 'Male', 'Bachelor of Marketing', 'Google Ads Certificate, Facebook Blueprint', 'Online advertising, SEO', '2 years at Shopee'),
('Emma Vu', '0839876543', 'emma.vu@example.com', 'Female', 'Bachelor of Finance and Banking', 'ACCA Certification; CFA Certification', 'Financial accounting, Data analysis', '4 years at HSBC');

-- Chèn dữ liệu vào bảng CONTRACT
INSERT INTO CONTRACT (APPLICANT_ID, REPRESENTATIVES_ID, START_DATE, END_DATE, SALARY)
VALUES
(1, 1, '2025-01-01', '2026-01-01', 9000),
(2, 2, '2025-02-01', '2026-02-01', 7500),
(3, 3, '2025-03-01', '2026-03-01', 6500),
(4, 4, '2025-04-01', '2026-04-01', 5500),
(5, 5, '2025-05-01', '2026-05-01', 5000);

-- Chèn dữ liệu vào bảng EMPLOYEE
INSERT INTO EMPLOYEE (NAME, DEPARTMENT_ID, ROLE, PHONE_NUMBER, E_MAIL_ADDRESS, CONTRACT_ID)
VALUES
('Peter Lee', 1, 'Software Engineer', '0404040404', 'peter.lee@example.com', 1),
('Sara Tan', 2, 'HR Manager', '0505050505', 'sara.tan@example.com', 2),
('Tim Wang', 3, 'Marketing Specialist', '0606060606', 'tim.wang@example.com', 3),
('Eva Black', 4, 'Product Manager', '0707070707', 'eva.black@example.com', 4),
('Lily White', 5, 'Sales Executive', '0808080808', 'lily.white@example.com', 5);

-- Chèn dữ liệu vào bảng PERSON_IN_CHARGE
INSERT INTO PERSON_IN_CHARGE (JOB_DESCRIPTION_ID, EMPLOYEE_ID)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Chèn dữ liệu vào bảng APPLICATION
INSERT INTO APPLICATION (APPLICANT_ID, JOB_DESCRIPTION_ID, APPLICATION_STATUS)
VALUES
(1, 1, 'Pending'),
(2, 2, 'Approved'),
(3, 3, 'Pending'),
(4, 4, 'Rejected'),
(5, 5, 'Approved');

-- Chèn dữ liệu vào bảng INTERVIEW
INSERT INTO INTERVIEW (APPLICATION_ID, INTERVIEW_STATUS, EVALUATION, SCHEDULE_DATE, SIDE_NOTE)
VALUES
(1, 'Scheduled', 8, '2025-01-15 09:00:00', 'Initial screening'),
(2, 'Completed', 9, '2025-02-15 10:00:00', 'Final interview'),
(3, 'Scheduled', 7, '2025-03-20 14:00:00', 'Technical interview'),
(4, 'Cancelled', NULL, '2025-04-25 11:00:00', 'Candidate withdrew'),
(5, 'Completed', 8, '2025-05-10 13:00:00', 'Final interview');

-- Chèn dữ liệu vào bảng INTERVIEW_DETAIL
INSERT INTO INTERVIEW_DETAIL (INTERVIEW_ID, INTERVIEWER_ID, PARTIAL_EVALUATION)
VALUES
(1, 1, 46),
(1, 2, 87),
(1, 5, 78),
(2, 2, 88),
(2,4, 12),
(2,3, 65),
(3, 3, 45),
(4, 4, 99),
(5, 5, 70);
