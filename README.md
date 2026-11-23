# Marriage Bureau Management System

A SQL Server database project for managing marriage bureau operations, including client registration, personal and family profiles, education, occupation, partner preferences, match requests, meetings, payments, document verification, staff users, and feedback.

## Project overview

The database uses a relational design with **13 tables** and includes primary keys, foreign keys, unique constraints, check constraints, sample data, and SQL queries for common reporting and database concepts.

## Database entities

- Roles and Users
- Clients and Profiles
- Families, Education, Occupation, and Preferences
- MatchRequests and Meetings
- Payments, Documents, and Feedback

## Technologies

- Microsoft SQL Server / T-SQL
- Relational database design
- ERD and EERD diagrams

## Repository contents

- `Marriage_Bureau_DB_Project_SQL_Server.sql` — combined SQL Server script
- `Marriage_Bureau_DDL.sql` — database and table definitions
- `Marriage_Bureau_DML.sql` — sample data inserts
- `Marriage_Bureau_Queries.sql` — example queries, joins, subqueries, aggregations, and views
- `Marriage_Bureau_Management_System_DB_Project.docx` — project report and database documentation
- `marriage_bureau_erd.png` — ER diagram
- `marriage_bureau_eerd.png` — enhanced ER diagram

## How to use

1. Open SQL Server Management Studio (SSMS).
2. Review the SQL script before executing it.
3. Run `Marriage_Bureau_DB_Project_SQL_Server.sql` to create and populate the database and execute the included queries.

Alternatively, run the scripts separately in this order:
1. `Marriage_Bureau_DDL.sql`
2. `Marriage_Bureau_DML.sql`
3. `Marriage_Bureau_Queries.sql`

## Important safety note

The combined SQL Server script checks for an existing database named `MarriageBureauDB` and **drops it before recreating it**. Do not run it against a database containing data you need. Review the script and back up any important database first.

The included DML uses demonstration/sample records. Replace them with appropriately authorized, non-sensitive test data before sharing or deploying. Do not commit real client personal information, passwords, credentials, or private documents to a public repository.

## Scope

This is a database design and SQL Server project. The supplied files document the schema, sample data, diagrams, and queries; they do not include a complete web or mobile application interface.
