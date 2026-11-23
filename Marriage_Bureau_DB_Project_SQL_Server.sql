
/* Marriage Bureau Management System - SQL Server Database Project */
IF DB_ID('MarriageBureauDB') IS NOT NULL
BEGIN
    ALTER DATABASE MarriageBureauDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MarriageBureauDB;
END
GO
CREATE DATABASE MarriageBureauDB;
GO
USE MarriageBureauDB;
GO

CREATE TABLE Roles (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255) NULL,
    is_active BIT NOT NULL DEFAULT 1
);
GO
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    role_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id),
    CONSTRAINT CK_Users_Status CHECK (status IN ('Active','Inactive','Blocked'))
);
GO
CREATE TABLE Clients (
    client_id INT IDENTITY(1,1) PRIMARY KEY,
    created_by_user_id INT NOT NULL,
    registration_no VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(120) NULL UNIQUE,
    city VARCHAR(60) NOT NULL,
    country VARCHAR(60) NOT NULL DEFAULT 'Pakistan',
    marital_status VARCHAR(30) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Clients_Users FOREIGN KEY (created_by_user_id) REFERENCES Users(user_id),
    CONSTRAINT CK_Clients_Gender CHECK (gender IN ('Male','Female')),
    CONSTRAINT CK_Clients_Status CHECK (status IN ('Pending','Active','Inactive','Matched','Rejected')),
    CONSTRAINT CK_Clients_Marital CHECK (marital_status IN ('Single','Divorced','Widowed'))
);
GO
CREATE TABLE Profiles (
    profile_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL UNIQUE,
    height_cm INT NOT NULL,
    complexion VARCHAR(30) NULL,
    religion VARCHAR(50) NOT NULL DEFAULT 'Islam',
    sect VARCHAR(50) NULL,
    languages VARCHAR(150) NULL,
    bio VARCHAR(500) NULL,
    CONSTRAINT FK_Profiles_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Profiles_Height CHECK (height_cm BETWEEN 120 AND 220)
);
GO
CREATE TABLE Families (
    family_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL UNIQUE,
    father_occupation VARCHAR(100) NULL,
    mother_occupation VARCHAR(100) NULL,
    siblings_count INT NOT NULL DEFAULT 0,
    family_type VARCHAR(30) NOT NULL,
    family_status VARCHAR(30) NULL,
    residence_status VARCHAR(30) NULL,
    CONSTRAINT FK_Families_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Families_Siblings CHECK (siblings_count >= 0),
    CONSTRAINT CK_Families_Type CHECK (family_type IN ('Nuclear','Joint'))
);
GO
CREATE TABLE Education (
    education_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL UNIQUE,
    degree VARCHAR(100) NOT NULL,
    institute VARCHAR(150) NULL,
    field_of_study VARCHAR(100) NULL,
    graduation_year INT NULL,
    CONSTRAINT FK_Education_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Education_Year CHECK (graduation_year IS NULL OR graduation_year BETWEEN 1980 AND 2030)
);
GO
CREATE TABLE Occupation (
    occupation_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    company VARCHAR(150) NULL,
    employment_type VARCHAR(50) NOT NULL,
    monthly_income DECIMAL(12,2) NOT NULL DEFAULT 0,
    work_city VARCHAR(60) NULL,
    CONSTRAINT FK_Occupation_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Occupation_Income CHECK (monthly_income >= 0),
    CONSTRAINT CK_Occupation_Type CHECK (employment_type IN ('Government','Private','Business','Freelance','Student','Other'))
);
GO
CREATE TABLE Preferences (
    preference_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL UNIQUE,
    min_age INT NOT NULL,
    max_age INT NOT NULL,
    preferred_city VARCHAR(60) NULL,
    preferred_education VARCHAR(100) NULL,
    preferred_income_min DECIMAL(12,2) NOT NULL DEFAULT 0,
    preferred_family_type VARCHAR(30) NULL,
    CONSTRAINT FK_Preferences_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Preferences_Age CHECK (min_age >= 18 AND max_age <= 70 AND min_age <= max_age),
    CONSTRAINT CK_Preferences_Income CHECK (preferred_income_min >= 0)
);
GO
CREATE TABLE MatchRequests (
    match_request_id INT IDENTITY(1,1) PRIMARY KEY,
    requester_client_id INT NOT NULL,
    target_client_id INT NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    request_date DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    decision_date DATE NULL,
    comments VARCHAR(500) NULL,
    CONSTRAINT FK_Match_Requester FOREIGN KEY (requester_client_id) REFERENCES Clients(client_id),
    CONSTRAINT FK_Match_Target FOREIGN KEY (target_client_id) REFERENCES Clients(client_id),
    CONSTRAINT CK_Match_Status CHECK (status IN ('Pending','Accepted','Rejected','Cancelled')),
    CONSTRAINT CK_Match_Different CHECK (requester_client_id <> target_client_id),
    CONSTRAINT UQ_MatchPair UNIQUE (requester_client_id, target_client_id)
);
GO
CREATE TABLE Meetings (
    meeting_id INT IDENTITY(1,1) PRIMARY KEY,
    match_request_id INT NOT NULL,
    meeting_date DATETIME NOT NULL,
    meeting_mode VARCHAR(20) NOT NULL,
    location VARCHAR(150) NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Scheduled',
    notes VARCHAR(500) NULL,
    CONSTRAINT FK_Meetings_Match FOREIGN KEY (match_request_id) REFERENCES MatchRequests(match_request_id) ON DELETE CASCADE,
    CONSTRAINT CK_Meetings_Mode CHECK (meeting_mode IN ('Office','Online','Phone')),
    CONSTRAINT CK_Meetings_Status CHECK (status IN ('Scheduled','Completed','Cancelled'))
);
GO
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL,
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    payment_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    paid_on DATE NULL,
    remarks VARCHAR(255) NULL,
    CONSTRAINT FK_Payments_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    CONSTRAINT CK_Payments_Amount CHECK (amount > 0),
    CONSTRAINT CK_Payments_Method CHECK (payment_method IN ('Cash','Card','Bank Transfer','JazzCash','EasyPaisa')),
    CONSTRAINT CK_Payments_Status CHECK (payment_status IN ('Pending','Paid','Failed','Refunded'))
);
GO
CREATE TABLE Documents (
    document_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL,
    document_type VARCHAR(50) NOT NULL,
    document_number VARCHAR(80) NOT NULL UNIQUE,
    verification_status VARCHAR(20) NOT NULL DEFAULT 'Pending',
    uploaded_on DATE NOT NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT FK_Documents_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id) ON DELETE CASCADE,
    CONSTRAINT CK_Documents_Type CHECK (document_type IN ('CNIC','Passport','Degree','Salary Slip','Photo')),
    CONSTRAINT CK_Documents_Status CHECK (verification_status IN ('Pending','Verified','Rejected'))
);
GO
CREATE TABLE Feedback (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    client_id INT NOT NULL,
    match_request_id INT NULL,
    rating INT NOT NULL,
    comments VARCHAR(500) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Feedback_Clients FOREIGN KEY (client_id) REFERENCES Clients(client_id),
    CONSTRAINT FK_Feedback_Match FOREIGN KEY (match_request_id) REFERENCES MatchRequests(match_request_id),
    CONSTRAINT CK_Feedback_Rating CHECK (rating BETWEEN 1 AND 5)
);
GO

/* Table Comments using SQL Server Extended Properties */
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Role master records used to control staff access.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Roles';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'System staff/admin users who manage clients and records.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Users';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Registered marriage bureau candidates.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Clients';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Personal profile details of each client.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Profiles';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Family background information of each client.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Families';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Highest education information of each client.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Education';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Professional and income information of each client.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Occupation';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Partner preference criteria of each client.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Preferences';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Match proposal/request from one client to another.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'MatchRequests';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Meetings scheduled for a match request.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Meetings';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Membership and service payments from clients.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Payments';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Client identity and verification documents.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Documents';
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Client feedback against service or a match request.', @level0type=N'SCHEMA', @level0name=N'dbo', @level1type=N'TABLE', @level1name=N'Feedback';
GO

USE MarriageBureauDB;
GO

/* DML: At least 15 records in each table */
INSERT INTO Roles (role_name, description, is_active) VALUES
('Admin', 'Admin role for marriage bureau system', 1),
('Manager', 'Manager role for marriage bureau system', 1),
('Consultant', 'Consultant role for marriage bureau system', 1),
('Receptionist', 'Receptionist role for marriage bureau system', 1),
('Finance Officer', 'Finance Officer role for marriage bureau system', 1),
('Verifier', 'Verifier role for marriage bureau system', 1),
('Match Maker', 'Match Maker role for marriage bureau system', 1),
('Data Entry', 'Data Entry role for marriage bureau system', 1),
('Supervisor', 'Supervisor role for marriage bureau system', 1),
('Support Agent', 'Support Agent role for marriage bureau system', 1),
('Auditor', 'Auditor role for marriage bureau system', 1),
('Marketing Officer', 'Marketing Officer role for marriage bureau system', 1),
('Relationship Officer', 'Relationship Officer role for marriage bureau system', 1),
('Branch Head', 'Branch Head role for marriage bureau system', 1),
('Guest Viewer', 'Guest Viewer role for marriage bureau system', 1);
GO

INSERT INTO Users (role_id, full_name, email, password_hash, phone, status) VALUES
(1, 'User 1 Staff', 'user1@marriagebureau.com', 'HASHED_PASSWORD_1', '03000000001', 'Active'),
(2, 'User 2 Staff', 'user2@marriagebureau.com', 'HASHED_PASSWORD_2', '03000000002', 'Active'),
(3, 'User 3 Staff', 'user3@marriagebureau.com', 'HASHED_PASSWORD_3', '03000000003', 'Active'),
(4, 'User 4 Staff', 'user4@marriagebureau.com', 'HASHED_PASSWORD_4', '03000000004', 'Active'),
(5, 'User 5 Staff', 'user5@marriagebureau.com', 'HASHED_PASSWORD_5', '03000000005', 'Active'),
(6, 'User 6 Staff', 'user6@marriagebureau.com', 'HASHED_PASSWORD_6', '03000000006', 'Active'),
(7, 'User 7 Staff', 'user7@marriagebureau.com', 'HASHED_PASSWORD_7', '03000000007', 'Active'),
(8, 'User 8 Staff', 'user8@marriagebureau.com', 'HASHED_PASSWORD_8', '03000000008', 'Active'),
(9, 'User 9 Staff', 'user9@marriagebureau.com', 'HASHED_PASSWORD_9', '03000000009', 'Active'),
(10, 'User 10 Staff', 'user10@marriagebureau.com', 'HASHED_PASSWORD_10', '03000000010', 'Active'),
(11, 'User 11 Staff', 'user11@marriagebureau.com', 'HASHED_PASSWORD_11', '03000000011', 'Active'),
(12, 'User 12 Staff', 'user12@marriagebureau.com', 'HASHED_PASSWORD_12', '03000000012', 'Active'),
(13, 'User 13 Staff', 'user13@marriagebureau.com', 'HASHED_PASSWORD_13', '03000000013', 'Active'),
(14, 'User 14 Staff', 'user14@marriagebureau.com', 'HASHED_PASSWORD_14', '03000000014', 'Active'),
(15, 'User 15 Staff', 'user15@marriagebureau.com', 'HASHED_PASSWORD_15', '03000000015', 'Active');
GO

INSERT INTO Clients (created_by_user_id, registration_no, full_name, gender, dob, phone, email, city, country, marital_status, status) VALUES
(2, 'MB-2026-001', 'Client 1 Male', 'Male', '1991-02-02', '03110000001', 'client1@mail.com', 'Lahore', 'Pakistan', 'Divorced', 'Active'),
(3, 'MB-2026-002', 'Client 2 Female', 'Female', '1992-03-03', '03110000002', 'client2@mail.com', 'Karachi', 'Pakistan', 'Widowed', 'Active'),
(4, 'MB-2026-003', 'Client 3 Male', 'Male', '1993-04-04', '03110000003', 'client3@mail.com', 'Islamabad', 'Pakistan', 'Single', 'Active'),
(5, 'MB-2026-004', 'Client 4 Female', 'Female', '1994-05-05', '03110000004', 'client4@mail.com', 'Rawalpindi', 'Pakistan', 'Divorced', 'Active'),
(6, 'MB-2026-005', 'Client 5 Male', 'Male', '1995-06-06', '03110000005', 'client5@mail.com', 'Faisalabad', 'Pakistan', 'Widowed', 'Active'),
(7, 'MB-2026-006', 'Client 6 Female', 'Female', '1996-07-07', '03110000006', 'client6@mail.com', 'Multan', 'Pakistan', 'Single', 'Active'),
(8, 'MB-2026-007', 'Client 7 Male', 'Male', '1997-08-08', '03110000007', 'client7@mail.com', 'Peshawar', 'Pakistan', 'Divorced', 'Active'),
(9, 'MB-2026-008', 'Client 8 Female', 'Female', '1998-09-09', '03110000008', 'client8@mail.com', 'Quetta', 'Pakistan', 'Widowed', 'Active'),
(10, 'MB-2026-009', 'Client 9 Male', 'Male', '1999-10-10', '03110000009', 'client9@mail.com', 'Sialkot', 'Pakistan', 'Single', 'Active'),
(11, 'MB-2026-010', 'Client 10 Female', 'Female', '2000-11-11', '03110000010', 'client10@mail.com', 'Gujranwala', 'Pakistan', 'Divorced', 'Active'),
(12, 'MB-2026-011', 'Client 11 Male', 'Male', '2001-12-12', '03110000011', 'client11@mail.com', 'Hyderabad', 'Pakistan', 'Widowed', 'Active'),
(13, 'MB-2026-012', 'Client 12 Female', 'Female', '1990-01-13', '03110000012', 'client12@mail.com', 'Bahawalpur', 'Pakistan', 'Single', 'Active'),
(14, 'MB-2026-013', 'Client 13 Male', 'Male', '1991-02-14', '03110000013', 'client13@mail.com', 'Sargodha', 'Pakistan', 'Divorced', 'Active'),
(15, 'MB-2026-014', 'Client 14 Female', 'Female', '1992-03-15', '03110000014', 'client14@mail.com', 'Abbottabad', 'Pakistan', 'Widowed', 'Active'),
(1, 'MB-2026-015', 'Client 15 Male', 'Male', '1993-04-16', '03110000015', 'client15@mail.com', 'Murree', 'Pakistan', 'Single', 'Active');
GO

INSERT INTO Profiles (client_id, height_cm, complexion, religion, sect, languages, bio) VALUES
(1, 156, 'Wheatish', 'Islam', 'Shia', 'Urdu, English', 'Profile bio for client 1.'),
(2, 157, 'Medium', 'Islam', 'Other', 'Urdu, English', 'Profile bio for client 2.'),
(3, 158, 'Olive', 'Islam', 'Sunni', 'Urdu, English', 'Profile bio for client 3.'),
(4, 159, 'Dark', 'Islam', 'Shia', 'Urdu, English', 'Profile bio for client 4.'),
(5, 160, 'Fair', 'Islam', 'Other', 'Urdu, English', 'Profile bio for client 5.'),
(6, 161, 'Wheatish', 'Islam', 'Sunni', 'Urdu, English', 'Profile bio for client 6.'),
(7, 162, 'Medium', 'Islam', 'Shia', 'Urdu, English', 'Profile bio for client 7.'),
(8, 163, 'Olive', 'Islam', 'Other', 'Urdu, English', 'Profile bio for client 8.'),
(9, 164, 'Dark', 'Islam', 'Sunni', 'Urdu, English', 'Profile bio for client 9.'),
(10, 165, 'Fair', 'Islam', 'Shia', 'Urdu, English', 'Profile bio for client 10.'),
(11, 166, 'Wheatish', 'Islam', 'Other', 'Urdu, English', 'Profile bio for client 11.'),
(12, 167, 'Medium', 'Islam', 'Sunni', 'Urdu, English', 'Profile bio for client 12.'),
(13, 168, 'Olive', 'Islam', 'Shia', 'Urdu, English', 'Profile bio for client 13.'),
(14, 169, 'Dark', 'Islam', 'Other', 'Urdu, English', 'Profile bio for client 14.'),
(15, 170, 'Fair', 'Islam', 'Sunni', 'Urdu, English', 'Profile bio for client 15.');
GO

INSERT INTO Families (client_id, father_occupation, mother_occupation, siblings_count, family_type, family_status, residence_status) VALUES
(1, 'Father Occupation 1', 'Mother Occupation 1', 1, 'Nuclear', 'Upper Middle', 'Rented'),
(2, 'Father Occupation 2', 'Mother Occupation 2', 2, 'Joint', 'Elite', 'Owned'),
(3, 'Father Occupation 3', 'Mother Occupation 3', 3, 'Nuclear', 'Middle', 'Rented'),
(4, 'Father Occupation 4', 'Mother Occupation 4', 4, 'Joint', 'Upper Middle', 'Owned'),
(5, 'Father Occupation 5', 'Mother Occupation 5', 5, 'Nuclear', 'Elite', 'Rented'),
(6, 'Father Occupation 6', 'Mother Occupation 6', 0, 'Joint', 'Middle', 'Owned'),
(7, 'Father Occupation 7', 'Mother Occupation 7', 1, 'Nuclear', 'Upper Middle', 'Rented'),
(8, 'Father Occupation 8', 'Mother Occupation 8', 2, 'Joint', 'Elite', 'Owned'),
(9, 'Father Occupation 9', 'Mother Occupation 9', 3, 'Nuclear', 'Middle', 'Rented'),
(10, 'Father Occupation 10', 'Mother Occupation 10', 4, 'Joint', 'Upper Middle', 'Owned'),
(11, 'Father Occupation 11', 'Mother Occupation 11', 5, 'Nuclear', 'Elite', 'Rented'),
(12, 'Father Occupation 12', 'Mother Occupation 12', 0, 'Joint', 'Middle', 'Owned'),
(13, 'Father Occupation 13', 'Mother Occupation 13', 1, 'Nuclear', 'Upper Middle', 'Rented'),
(14, 'Father Occupation 14', 'Mother Occupation 14', 2, 'Joint', 'Elite', 'Owned'),
(15, 'Father Occupation 15', 'Mother Occupation 15', 3, 'Nuclear', 'Middle', 'Rented');
GO

INSERT INTO Education (client_id, degree, institute, field_of_study, graduation_year) VALUES
(1, 'BS Computer Science', 'Institute 1', 'Field 1', 2011),
(2, 'MBA', 'Institute 2', 'Field 2', 2012),
(3, 'MBBS', 'Institute 3', 'Field 3', 2013),
(4, 'BBA', 'Institute 4', 'Field 4', 2014),
(5, 'MS Data Science', 'Institute 5', 'Field 5', 2015),
(6, 'B.Com', 'Institute 6', 'Field 6', 2016),
(7, 'M.A English', 'Institute 7', 'Field 7', 2017),
(8, 'BSc Engineering', 'Institute 8', 'Field 8', 2018),
(9, 'LLB', 'Institute 9', 'Field 9', 2019),
(10, 'Pharm-D', 'Institute 10', 'Field 10', 2020),
(11, 'BS Psychology', 'Institute 11', 'Field 11', 2021),
(12, 'MSc Mathematics', 'Institute 12', 'Field 12', 2022),
(13, 'ACCA', 'Institute 13', 'Field 13', 2023),
(14, 'BS IT', 'Institute 14', 'Field 14', 2024),
(15, 'M.Phil', 'Institute 15', 'Field 15', 2025);
GO

INSERT INTO Occupation (client_id, job_title, company, employment_type, monthly_income, work_city) VALUES
(1, 'Software Engineer', 'Company 1', 'Private', 60000.00, 'Rawalpindi'),
(2, 'Teacher', 'Company 2', 'Government', 70000.00, 'Faisalabad'),
(3, 'Doctor', 'Company 3', 'Private', 80000.00, 'Multan'),
(4, 'Business Owner', 'Company 4', 'Business', 90000.00, 'Peshawar'),
(5, 'Bank Officer', 'Company 5', 'Private', 100000.00, 'Quetta'),
(6, 'Accountant', 'Company 6', 'Private', 110000.00, 'Sialkot'),
(7, 'Designer', 'Company 7', 'Freelance', 120000.00, 'Gujranwala'),
(8, 'Engineer', 'Company 8', 'Private', 130000.00, 'Hyderabad'),
(9, 'Lawyer', 'Company 9', 'Private', 140000.00, 'Bahawalpur'),
(10, 'Pharmacist', 'Company 10', 'Private', 150000.00, 'Sargodha'),
(11, 'Psychologist', 'Company 11', 'Private', 160000.00, 'Abbottabad'),
(12, 'Lecturer', 'Company 12', 'Government', 170000.00, 'Murree'),
(13, 'Finance Analyst', 'Company 13', 'Private', 180000.00, 'Lahore'),
(14, 'Web Developer', 'Company 14', 'Private', 190000.00, 'Karachi'),
(15, 'Researcher', 'Company 15', 'Other', 200000.00, 'Islamabad');
GO

INSERT INTO Preferences (client_id, min_age, max_age, preferred_city, preferred_education, preferred_income_min, preferred_family_type) VALUES
(1, 23, 31, 'Faisalabad', 'B.Com', 45000.00, 'Joint'),
(2, 24, 32, 'Multan', 'M.A English', 50000.00, 'Nuclear'),
(3, 25, 33, 'Peshawar', 'BSc Engineering', 55000.00, 'Joint'),
(4, 26, 34, 'Quetta', 'LLB', 60000.00, 'Nuclear'),
(5, 22, 35, 'Sialkot', 'Pharm-D', 65000.00, 'Joint'),
(6, 23, 36, 'Gujranwala', 'BS Psychology', 70000.00, 'Nuclear'),
(7, 24, 37, 'Hyderabad', 'MSc Mathematics', 75000.00, 'Joint'),
(8, 25, 30, 'Bahawalpur', 'ACCA', 80000.00, 'Nuclear'),
(9, 26, 31, 'Sargodha', 'BS IT', 85000.00, 'Joint'),
(10, 22, 32, 'Abbottabad', 'M.Phil', 90000.00, 'Nuclear'),
(11, 23, 33, 'Murree', 'BS Computer Science', 95000.00, 'Joint'),
(12, 24, 34, 'Lahore', 'MBA', 100000.00, 'Nuclear'),
(13, 25, 35, 'Karachi', 'MBBS', 105000.00, 'Joint'),
(14, 26, 36, 'Islamabad', 'BBA', 110000.00, 'Nuclear'),
(15, 22, 37, 'Rawalpindi', 'MS Data Science', 115000.00, 'Joint');
GO

INSERT INTO MatchRequests (requester_client_id, target_client_id, status, request_date, decision_date, comments) VALUES
(1, 8, 'Accepted', '2026-02-02', '2026-03-02', 'Match request comment 1'),
(2, 9, 'Rejected', '2026-02-03', '2026-03-03', 'Match request comment 2'),
(3, 10, 'Cancelled', '2026-02-04', '2026-03-04', 'Match request comment 3'),
(4, 11, 'Pending', '2026-02-05', NULL, 'Match request comment 4'),
(5, 12, 'Accepted', '2026-02-06', '2026-03-06', 'Match request comment 5'),
(6, 13, 'Rejected', '2026-02-07', '2026-03-07', 'Match request comment 6'),
(7, 14, 'Cancelled', '2026-02-08', '2026-03-08', 'Match request comment 7'),
(8, 15, 'Pending', '2026-02-09', NULL, 'Match request comment 8'),
(9, 1, 'Accepted', '2026-02-10', '2026-03-10', 'Match request comment 9'),
(10, 2, 'Rejected', '2026-02-11', '2026-03-11', 'Match request comment 10'),
(11, 3, 'Cancelled', '2026-02-12', '2026-03-12', 'Match request comment 11'),
(12, 4, 'Pending', '2026-02-13', NULL, 'Match request comment 12'),
(13, 5, 'Accepted', '2026-02-14', '2026-03-14', 'Match request comment 13'),
(14, 6, 'Rejected', '2026-02-15', '2026-03-15', 'Match request comment 14'),
(15, 7, 'Cancelled', '2026-02-16', '2026-03-16', 'Match request comment 15');
GO

INSERT INTO Meetings (match_request_id, meeting_date, meeting_mode, location, status, notes) VALUES
(1, '2026-04-02 15:00:00', 'Online', 'Main Office Lahore', 'Completed', 'Meeting notes 1'),
(2, '2026-04-03 15:00:00', 'Phone', 'Online/Phone', 'Cancelled', 'Meeting notes 2'),
(3, '2026-04-04 15:00:00', 'Office', 'Online/Phone', 'Scheduled', 'Meeting notes 3'),
(4, '2026-04-05 15:00:00', 'Online', 'Main Office Lahore', 'Completed', 'Meeting notes 4'),
(5, '2026-04-06 15:00:00', 'Phone', 'Online/Phone', 'Cancelled', 'Meeting notes 5'),
(6, '2026-04-07 15:00:00', 'Office', 'Online/Phone', 'Scheduled', 'Meeting notes 6'),
(7, '2026-04-08 15:00:00', 'Online', 'Main Office Lahore', 'Completed', 'Meeting notes 7'),
(8, '2026-04-09 15:00:00', 'Phone', 'Online/Phone', 'Cancelled', 'Meeting notes 8'),
(9, '2026-04-10 15:00:00', 'Office', 'Online/Phone', 'Scheduled', 'Meeting notes 9'),
(10, '2026-04-11 15:00:00', 'Online', 'Main Office Lahore', 'Completed', 'Meeting notes 10'),
(11, '2026-04-12 15:00:00', 'Phone', 'Online/Phone', 'Cancelled', 'Meeting notes 11'),
(12, '2026-04-13 15:00:00', 'Office', 'Online/Phone', 'Scheduled', 'Meeting notes 12'),
(13, '2026-04-14 15:00:00', 'Online', 'Main Office Lahore', 'Completed', 'Meeting notes 13'),
(14, '2026-04-15 15:00:00', 'Phone', 'Online/Phone', 'Cancelled', 'Meeting notes 14'),
(15, '2026-04-16 15:00:00', 'Office', 'Online/Phone', 'Scheduled', 'Meeting notes 15');
GO

INSERT INTO Payments (client_id, amount, payment_method, payment_status, paid_on, remarks) VALUES
(1, 11000.00, 'Card', 'Paid', '2026-01-02', 'Payment remarks 1'),
(2, 12000.00, 'Bank Transfer', 'Paid', '2026-01-03', 'Payment remarks 2'),
(3, 13000.00, 'JazzCash', 'Paid', '2026-01-04', 'Payment remarks 3'),
(4, 14000.00, 'EasyPaisa', 'Pending', NULL, 'Payment remarks 4'),
(5, 15000.00, 'Cash', 'Paid', '2026-01-06', 'Payment remarks 5'),
(6, 16000.00, 'Card', 'Paid', '2026-01-07', 'Payment remarks 6'),
(7, 17000.00, 'Bank Transfer', 'Paid', '2026-01-08', 'Payment remarks 7'),
(8, 18000.00, 'JazzCash', 'Pending', NULL, 'Payment remarks 8'),
(9, 19000.00, 'EasyPaisa', 'Paid', '2026-01-10', 'Payment remarks 9'),
(10, 20000.00, 'Cash', 'Paid', '2026-01-11', 'Payment remarks 10'),
(11, 21000.00, 'Card', 'Paid', '2026-01-12', 'Payment remarks 11'),
(12, 22000.00, 'Bank Transfer', 'Pending', NULL, 'Payment remarks 12'),
(13, 23000.00, 'JazzCash', 'Paid', '2026-01-14', 'Payment remarks 13'),
(14, 24000.00, 'EasyPaisa', 'Paid', '2026-01-15', 'Payment remarks 14'),
(15, 25000.00, 'Cash', 'Paid', '2026-01-16', 'Payment remarks 15');
GO

INSERT INTO Documents (client_id, document_type, document_number, verification_status, uploaded_on) VALUES
(1, 'Passport', 'DOC-0001-1001', 'Verified', '2026-01-02'),
(2, 'Degree', 'DOC-0002-1002', 'Rejected', '2026-01-03'),
(3, 'Salary Slip', 'DOC-0003-1003', 'Pending', '2026-01-04'),
(4, 'Photo', 'DOC-0004-1004', 'Verified', '2026-01-05'),
(5, 'CNIC', 'DOC-0005-1005', 'Rejected', '2026-01-06'),
(6, 'Passport', 'DOC-0006-1006', 'Pending', '2026-01-07'),
(7, 'Degree', 'DOC-0007-1007', 'Verified', '2026-01-08'),
(8, 'Salary Slip', 'DOC-0008-1008', 'Rejected', '2026-01-09'),
(9, 'Photo', 'DOC-0009-1009', 'Pending', '2026-01-10'),
(10, 'CNIC', 'DOC-0010-1010', 'Verified', '2026-01-11'),
(11, 'Passport', 'DOC-0011-1011', 'Rejected', '2026-01-12'),
(12, 'Degree', 'DOC-0012-1012', 'Pending', '2026-01-13'),
(13, 'Salary Slip', 'DOC-0013-1013', 'Verified', '2026-01-14'),
(14, 'Photo', 'DOC-0014-1014', 'Rejected', '2026-01-15'),
(15, 'CNIC', 'DOC-0015-1015', 'Pending', '2026-01-16');
GO

INSERT INTO Feedback (client_id, match_request_id, rating, comments) VALUES
(1, 1, 2, 'Feedback comments for record 1'),
(2, 2, 3, 'Feedback comments for record 2'),
(3, 3, 4, 'Feedback comments for record 3'),
(4, 4, 5, 'Feedback comments for record 4'),
(5, 5, 1, 'Feedback comments for record 5'),
(6, 6, 2, 'Feedback comments for record 6'),
(7, 7, 3, 'Feedback comments for record 7'),
(8, 8, 4, 'Feedback comments for record 8'),
(9, 9, 5, 'Feedback comments for record 9'),
(10, 10, 1, 'Feedback comments for record 10'),
(11, 11, 2, 'Feedback comments for record 11'),
(12, 12, 3, 'Feedback comments for record 12'),
(13, 13, 4, 'Feedback comments for record 13'),
(14, 14, 5, 'Feedback comments for record 14'),
(15, 15, 1, 'Feedback comments for record 15');
GO



USE MarriageBureauDB;
GO
/* 15 Project Queries covering DDL, DML, DQL, Joins, Subqueries, Aggregation, Views */

-- Q1 DQL: Show all active clients
SELECT client_id, registration_no, full_name, gender, city, marital_status
FROM Clients
WHERE status = 'Active';

-- Q2 INNER JOIN: Client with education and occupation
SELECT c.full_name, e.degree, o.job_title, o.monthly_income
FROM Clients c
INNER JOIN Education e ON c.client_id = e.client_id
INNER JOIN Occupation o ON c.client_id = o.client_id;

-- Q3 LEFT JOIN: Clients and their payments
SELECT c.full_name, p.amount, p.payment_status, p.paid_on
FROM Clients c
LEFT JOIN Payments p ON c.client_id = p.client_id;

-- Q4 SELF-style join through MatchRequests
SELECT r.full_name AS requester, t.full_name AS target, mr.status
FROM MatchRequests mr
JOIN Clients r ON mr.requester_client_id = r.client_id
JOIN Clients t ON mr.target_client_id = t.client_id;

-- Q5 Aggregation: Count clients by city
SELECT city, COUNT(*) AS total_clients
FROM Clients
GROUP BY city
ORDER BY total_clients DESC;

-- Q6 Aggregation with HAVING: cities having at least 1 client
SELECT city, COUNT(*) AS total_clients
FROM Clients
GROUP BY city
HAVING COUNT(*) >= 1;

-- Q7 Nested Query: clients with income above average
SELECT c.full_name, o.monthly_income
FROM Clients c
JOIN Occupation o ON c.client_id = o.client_id
WHERE o.monthly_income > (SELECT AVG(monthly_income) FROM Occupation);

-- Q8 Nested IN: clients who have verified documents
SELECT full_name
FROM Clients
WHERE client_id IN (SELECT client_id FROM Documents WHERE verification_status = 'Verified');

-- Q9 EXISTS: clients who submitted feedback
SELECT c.full_name
FROM Clients c
WHERE EXISTS (SELECT 1 FROM Feedback f WHERE f.client_id = c.client_id);

-- Q10 DML UPDATE: mark pending payment as paid for one client
UPDATE Payments
SET payment_status = 'Paid', paid_on = CAST(GETDATE() AS DATE)
WHERE payment_id = 4;

-- Q11 DML DELETE: remove cancelled meetings only
DELETE FROM Meetings
WHERE status = 'Cancelled' AND meeting_id = 3;

-- Q12 DDL ALTER: add optional last_login column
ALTER TABLE Users ADD last_login DATETIME NULL;

-- Q13 VIEW: client complete profile view
CREATE OR ALTER VIEW vw_ClientCompleteProfile AS
SELECT c.client_id, c.registration_no, c.full_name, c.gender, c.city, e.degree,
       o.job_title, o.monthly_income, p.height_cm, f.family_type
FROM Clients c
JOIN Profiles p ON c.client_id = p.client_id
JOIN Families f ON c.client_id = f.client_id
JOIN Education e ON c.client_id = e.client_id
JOIN Occupation o ON c.client_id = o.client_id;
GO
SELECT * FROM vw_ClientCompleteProfile;

-- Q14 VIEW: successful matches
CREATE OR ALTER VIEW vw_AcceptedMatches AS
SELECT mr.match_request_id, r.full_name AS requester, t.full_name AS target, mr.request_date, mr.decision_date
FROM MatchRequests mr
JOIN Clients r ON mr.requester_client_id = r.client_id
JOIN Clients t ON mr.target_client_id = t.client_id
WHERE mr.status = 'Accepted';
GO
SELECT * FROM vw_AcceptedMatches;

-- Q15 Join + aggregation: revenue per city
SELECT c.city, SUM(p.amount) AS total_revenue
FROM Clients c
JOIN Payments p ON c.client_id = p.client_id
WHERE p.payment_status = 'Paid'
GROUP BY c.city;
GO
