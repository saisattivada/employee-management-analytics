# Employee Management & Analytics System

A beginner-to-intermediate **SQL portfolio project** built with MySQL to demonstrate employee, project, salary, and workload analysis.

This project is designed as a practical portfolio project for GitHub and LinkedIn.

## Project Overview

The database models employees working across multiple projects and uses SQL to answer common management questions such as:

- Who is the highest-paid employee?
- What is the average employee salary?
- How many employees are assigned to each project?
- Which employees work on multiple projects?
- Which project has the largest team?
- Which employees earn above the average salary?
- How are employees distributed across salary ranges?
- What is the salary cost associated with each project?
- What is each employee's workload category?

## Technologies

- MySQL
- MySQL Workbench
- SQL

## Database Structure

### `departments`
Stores department information.

| Column | Description |
|---|---|
| department_id | Unique department ID |
| department_name | Department name |

### `employees`
Stores employee information.

| Column | Description |
|---|---|
| employee_id | Unique employee ID |
| employee_name | Employee name |
| employee_salary | Employee salary |

### `projects`
Stores project information.

| Column | Description |
|---|---|
| project_id | Unique project ID |
| project_name | Project name |
| required_budget | Planned project budget |

### `employee_projects`
A junction table connecting employees and projects.

| Column | Description |
|---|---|
| employee_id | Employee reference |
| project_id | Project reference |

The primary key `(employee_id, project_id)` prevents the same employee from being assigned to the same project more than once.

## SQL Concepts Demonstrated

This project demonstrates:

- Database and table creation
- Primary keys
- Foreign keys
- Composite primary keys
- `INSERT`
- `SELECT`
- `WHERE`
- `ORDER BY`
- `LIMIT`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `HAVING`
- Aggregate functions:
  - `COUNT()`
  - `AVG()`
  - `SUM()`
  - `MAX()`
  - `MIN()`
- `ROUND()`
- `CASE`
- Subqueries
- Window functions with `RANK()`
- `GROUP_CONCAT()`
- SQL Views

## Main Analysis

### Employee Analysis
The project creates employee-level reports showing:

- Salary
- Number of projects
- Projects assigned
- Salary ranking
- Salary category
- Workload category

### Salary Analysis

The project includes:

- Highest salary
- Lowest salary
- Average salary
- Total salary
- Salary ranking
- Employees earning above average
- Salary distribution

### Project Analysis

The project includes:

- Employee count per project
- Average salary per project
- Highest and lowest salary per project
- Total salary cost per project
- Largest project by employee count

### Workload Analysis

Employees are classified based on the number of projects:

- Single Project
- Multi-Project
- High Workload

## SQL Views

Four reusable views are included:

1. `employee_project_details`
2. `employee_analytics`
3. `project_statistics`
4. `high_salary_employees`

Views make frequently used reports easier to access without rewriting the complete query.

## Sample Data

The project currently contains 5 employees and 3 projects.

Employees:

- Sharif
- Karthik
- Rajesh
- Surya
- Uday

Projects:

- Employee Management System
- Analytics Dashboard
- Payroll System

## How to Run

1. Open MySQL Workbench.
2. Open `employee-management-analytics.sql`.
3. Run the script from the beginning.
4. Select the `company_management` database.
5. Execute the analysis queries and views.
6. Review the result sets in MySQL Workbench.

> **Note:** If you run the script more than once, `CREATE DATABASE`, `CREATE TABLE`, and `CREATE VIEW` statements may fail because the objects already exist. For a clean rerun, drop the existing database or add appropriate cleanup statements.

## Repository Structure

```text
employee-management-analytics/
│
├── employee-management-analytics.sql
└── README.md
```

## Learning Outcomes

Through this project, I practiced:

- Designing a relational database
- Creating relationships between tables
- Writing SQL joins
- Performing aggregate analysis
- Filtering grouped data
- Using conditional logic with `CASE`
- Using subqueries
- Ranking data with window functions
- Creating reusable SQL views
- Turning raw employee/project data into management-focused reports

## Future Improvements

Possible future enhancements:

- Connect employees to departments using `department_id`
- Add employee joining dates
- Add project start and end dates
- Populate and analyze project budgets
- Add project status
- Add department-level salary analysis
- Add more realistic sample data
- Connect the database to Power BI or Tableau for visualization

## Portfolio Purpose

This project was created to demonstrate practical SQL skills through a small employee management and analytics system.

It is intended as a personal portfolio project for GitHub and LinkedIn.
