Student Summer Camp SQL Project
Overview

This SQL script simulates a student registration system for summer camps. It:
Defines relational tables for students, summer camps, and registrations.
Generates synthetic student data (5,000 rows) with realistic distributions of gender, age groups, names, DOB, phone numbers, and emails.
Produces a demographic analysis of the dataset by generation and gender breakdown.
The project is useful for learning data modeling, data generation, and analytics in SQL.

Database Schema (Task 1)
Three main tables are declared:

Students
student_id: Primary key
first_name, middle_name, last_name: Student’s name parts
gender: Male/Female
DOB: Date of birth
personal_phone: Synthetic 10-digit number
email: Unique email address

SummerCamp
camp_id: Primary key
camp_title: Name of camp
start_date, end_date: Duration
capacity: Maximum seats
price: Camp fee

Registrations
registration_id: Primary key
student_id: Linked to Students
camp_id: Linked to SummerCamp

Synthetic Data Generation (Task 2)
Population: 5,000 students
Gender Distribution:
Female: 65% (3,250 students)
Male: 35% (1,750 students)

Age Distribution:
7–12 years → 18%
13–14 years → 27%
15–17 years → 20%
18–19 years → 35%

Name Generation:
Separate name pools for Male and Female (first, middle, last).
Names are assigned using modulo-based indexing to ensure coverage.
DOB Generation:
Randomized within age range using DATEADD and RAND().
Phone Number:
Synthetic numbers starting with 9, ensuring 10 digits.
Email Address:
Constructed as:
firstname + middlename + lastname + student_id + domain
Domains randomly assigned: @gmail.com, @yahoo.com, @outlook.com, @hotmail.com.

Generational Analysis (Task 3)
Students are grouped into generations using age at current date:
Gen Alpha: 0–12 years
Gen Z: 13–26 years
Millennials: 27–44 years
Gen X: 45–60 years
Other: 60+ years
The script calculates:
Count of students per generation & gender
Percentage distribution across combinations

This uses CTEs (Common Table Expressions) for clarity:
generations: Defines generation labels
gender: Defines gender categories
combinations: Cross join for all possibilities
temp: Counts students per generation/gender
totalCountPerGeneration: Aggregates totals for percentages

Key Learnings
SQL can be used not only for querying but also for data generation & simulation.
CTEs simplify multi-step aggregations (generations → gender → percentages).
Controlled randomness (RAND()) ensures reproducible but varied synthetic datasets.
