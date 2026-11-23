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
