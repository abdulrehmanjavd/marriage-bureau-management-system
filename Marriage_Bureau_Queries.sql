
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
