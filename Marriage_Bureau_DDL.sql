
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