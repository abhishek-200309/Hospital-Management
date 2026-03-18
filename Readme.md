# Hospital Patient Management and Medical Analytics System

A SQL-based hospital management project that designs a relational database for managing hospital operations and performs analytical reporting using SQL queries.

## Project Overview

This project builds a complete **Hospital Management** database system with support for:

* Patient registration and demographics
* Doctor and department management
* Appointment scheduling
* Patient admissions and discharge tracking
* Treatment records
* Medical test records
* Billing and revenue tracking
* Analytical SQL reporting for hospital insights

The project includes:

* **Database schema creation**
* **Sample data insertion**
* **SQL analytics queries** for reporting and portfolio use

## Database Name

`Hospital_Management`

## Features

### Core Management Modules

* Department management
* Doctor management
* Patient management
* Appointment management
* Admission management
* Treatment management
* Medical test management
* Billing management

### Analytics Covered

* Patient and demographic analysis
* Appointment analysis
* Admission analysis
* Doctor performance analysis
* Treatment analysis
* Medical test analysis
* Billing and revenue analysis
* Advanced SQL analytical questions

## Database Schema

The project contains the following tables:

1. `department`
2. `doctor`
3. `patient`
4. `appointment`
5. `admission`
6. `treatment`
7. `medical_test`
8. `billing`

### Table Relationships

* A **department** can have many doctors.
* A **doctor** belongs to one department.
* A **patient** can have many appointments and admissions.
* An **appointment** connects a patient with a doctor.
* An **admission** connects a patient, doctor, and department.
* A **treatment** is linked to an admission and a doctor.
* A **medical test** is linked to an admission, doctor, and patient.
* A **billing** record is linked to a patient and an admission.

## Files in This Project

* **Schema + Sample Data SQL**: contains database creation, table creation, and sample data insertion
* **Analytics SQL**: contains business questions and reporting queries across hospital operations

Based on the uploaded SQL files, one file defines the schema and sample dataset, while the other focuses on analytics queries and reporting. fileciteturn0file1 fileciteturn0file0

## Tools & Concepts Used

* SQL
* MySQL
* Relational Database Design
* Primary Keys and Foreign Keys
* Joins
* Aggregate Functions
* Group By
* Case Statements
* Window Functions
* Common Table Expressions (CTEs)
* Business/Healthcare Data Analytics

## Sample Analytics Questions

Some of the analysis included in this project:

* How many patients registered each month?
* What is the gender distribution of patients?
* What is the average age of patients?
* Which age group visits the hospital the most?
* Which doctor has the highest number of appointments?
* Which department receives the most appointments?
* What is the average hospital stay duration?
* Which doctor generated the most treatment revenue?
* What is the most common diagnosis?
* Which medical test is ordered most frequently?
* What is the total hospital revenue?
* Which month generated the highest hospital revenue?
* Rank doctors by revenue generated
* Find top departments by patient volume

## How to Run This Project

### 1. Create the database

Run the schema/data SQL file in MySQL to create the database and tables.

### 2. Insert sample data

The same SQL setup file includes sample data insertion for departments, doctors, patients, appointments, admissions, treatments, medical tests, and billing. fileciteturn0file1

### 3. Run analytics queries

Execute the analytics SQL file to generate reports and insights from the database. fileciteturn0file0

## Suggested Project Structure

```text
Hospital-Patient-Management-System/
│
├── hospital_management_schema.sql
├── hospital_analytics_queries.sql
└── README.md
```

You can rename your files to clear names like the ones above before uploading the project to GitHub.

## Example Use Cases

* SQL portfolio project
* Database design practice
* Healthcare analytics learning project
* Practice with joins, aggregations, CTEs, and reporting queries
* Beginner-to-intermediate MySQL project

## Highlights

* Covers both **transactional database design** and **analytical SQL reporting**
* Includes realistic sample hospital workflow entities
* Useful as a **portfolio-ready SQL project**
* Demonstrates practical use of **MySQL reporting queries**

## Possible Improvements

You can improve the project further by adding:

* Views for common reports
* Stored procedures
* Triggers for billing updates
* Indexing for performance optimization
* Dashboard integration using Power BI or Tableau
* ER diagram image
* Data validation constraints

## Conclusion

This project demonstrates how to design a relational hospital database and use SQL for operational reporting and analytics. It is a strong project for showcasing database design, SQL querying, and healthcare data analysis skills.

## Author

Add your name here

---

If you upload this project to GitHub, this README will help recruiters and viewers quickly understand the purpose, structure, and analytical value of your work.
