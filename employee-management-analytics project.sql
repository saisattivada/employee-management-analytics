-- ============================================================
-- Employee Management & Analytics System
-- Portfolio SQL Project | MySQL / MySQL Workbench
-- ============================================================

-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE company_management;

USE company_management;

-- ============================================================
-- 2. TABLE CREATION
-- ============================================================

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50) NOT NULL,
    employee_salary DECIMAL(10,2)
);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    required_budget DECIMAL(10,2)
);

CREATE TABLE employee_projects (
    employee_id INT,
    project_id INT,
    PRIMARY KEY (employee_id, project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

-- Check database structure
SHOW TABLES;

DESC departments;
DESC employees;
DESC projects;
DESC employee_projects;

-- ============================================================
-- 3. SAMPLE DATA
-- ============================================================

INSERT INTO employees (employee_id, employee_name, employee_salary)
VALUES
(1, 'Sharif', 45000),
(2, 'Karthik', 55000),
(3, 'Rajesh', 60000),
(4, 'Surya', 50000),
(5, 'Uday', 75000);

INSERT INTO projects (project_id, project_name)
VALUES
(101, 'Employee Management System'),
(102, 'Analytics Dashboard'),
(103, 'Payroll System');

INSERT INTO employee_projects (employee_id, project_id)
VALUES
(1, 101),
(2, 101),
(2, 102),
(3, 102),
(3, 103),
(4, 101),
(4, 103),
(5, 102),
(5, 103);

-- ============================================================
-- 4. BASIC DATA RETRIEVAL
-- ============================================================

SELECT * FROM employees;

SELECT * FROM projects;

SELECT * FROM employee_projects;

-- ============================================================
-- 5. EMPLOYEE AND PROJECT ANALYSIS
-- ============================================================

-- Employee-wise project details
SELECT
    e.employee_id,
    e.employee_name,
    e.employee_salary,
    p.project_name
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id
ORDER BY e.employee_id;

-- Highest-paid employee
SELECT
    employee_id,
    employee_name,
    employee_salary
FROM employees
ORDER BY employee_salary DESC
LIMIT 1;

-- Average employee salary
SELECT
    AVG(employee_salary) AS average_salary
FROM employees;

-- Number of employees in each project
SELECT
    p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS employee_count
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name;

-- Average employee salary for every project
SELECT
    p.project_name,
    AVG(e.employee_salary) AS average_salary
FROM projects p
JOIN employee_projects ep
    ON p.project_id = ep.project_id
JOIN employees e
    ON ep.employee_id = e.employee_id
GROUP BY p.project_id, p.project_name;

-- ============================================================
-- 6. EMPLOYEE ANALYTICS
-- ============================================================

-- Complete Employee Analytics Report
SELECT
    e.employee_id,
    e.employee_name,
    e.employee_salary,
    COUNT(ep.project_id) AS projects_working_on,
    GROUP_CONCAT(p.project_name SEPARATOR ', ') AS projects
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
LEFT JOIN projects p
    ON ep.project_id = p.project_id
GROUP BY
    e.employee_id,
    e.employee_name,
    e.employee_salary
ORDER BY e.employee_salary DESC;

-- Employees working on multiple projects
SELECT
    e.employee_id,
    e.employee_name,
    COUNT(ep.project_id) AS project_count
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.employee_name
HAVING COUNT(ep.project_id) > 1
ORDER BY project_count DESC;

-- Employees working on the most projects
SELECT
    e.employee_id,
    e.employee_name,
    COUNT(ep.project_id) AS total_projects
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY total_projects DESC, e.employee_name;

-- ============================================================
-- 7. SALARY ANALYSIS
-- ============================================================

-- Management salary statistics
SELECT
    COUNT(*) AS total_employees,
    ROUND(AVG(employee_salary), 2) AS average_salary,
    MAX(employee_salary) AS highest_salary,
    MIN(employee_salary) AS lowest_salary,
    ROUND(SUM(employee_salary), 2) AS total_salary
FROM employees;

-- Rank employees by salary
SELECT
    employee_id,
    employee_name,
    employee_salary,
    RANK() OVER (ORDER BY employee_salary DESC) AS salary_rank
FROM employees;

-- Employees earning above average salary
SELECT
    employee_id,
    employee_name,
    employee_salary
FROM employees
WHERE employee_salary > (
    SELECT AVG(employee_salary)
    FROM employees
)
ORDER BY employee_salary DESC;

-- Salary distribution
SELECT
    CASE
        WHEN employee_salary < 50000 THEN 'Below 50K'
        WHEN employee_salary BETWEEN 50000 AND 69999 THEN '50K - 69K'
        ELSE '70K+'
    END AS salary_range,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_range
ORDER BY employee_count DESC;

-- ============================================================
-- 8. PROJECT ANALYSIS
-- ============================================================

-- Find the largest project by employee count
SELECT
    p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS employee_count
FROM projects p
JOIN employee_projects ep
    ON p.project_id = ep.project_id
GROUP BY p.project_id, p.project_name
ORDER BY employee_count DESC
LIMIT 1;

-- Project salary analysis
SELECT
    p.project_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(e.employee_salary), 2) AS average_salary,
    MAX(e.employee_salary) AS highest_salary,
    MIN(e.employee_salary) AS lowest_salary
FROM projects p
JOIN employee_projects ep
    ON p.project_id = ep.project_id
JOIN employees e
    ON ep.employee_id = e.employee_id
GROUP BY p.project_id, p.project_name
ORDER BY average_salary DESC;

-- Total salary cost by project
SELECT
    p.project_name,
    COUNT(e.employee_id) AS employee_count,
    SUM(e.employee_salary) AS total_salary_cost
FROM projects p
JOIN employee_projects ep
    ON p.project_id = ep.project_id
JOIN employees e
    ON ep.employee_id = e.employee_id
GROUP BY p.project_id, p.project_name
ORDER BY total_salary_cost DESC;

-- ============================================================
-- 9. EMPLOYEE WORKLOAD ANALYSIS
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    COUNT(ep.project_id) AS project_count,
    CASE
        WHEN COUNT(ep.project_id) = 1 THEN 'Single Project'
        WHEN COUNT(ep.project_id) = 2 THEN 'Multi-Project'
        ELSE 'High Workload'
    END AS workload_category
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY e.employee_id, e.employee_name
ORDER BY project_count DESC;

-- ============================================================
-- 10. FINAL MANAGEMENT DASHBOARD QUERY
-- ============================================================

SELECT
    e.employee_id,
    e.employee_name,
    e.employee_salary,
    COUNT(ep.project_id) AS project_count,
    ROUND(e.employee_salary / COUNT(ep.project_id), 2)
        AS salary_per_project,
    CASE
        WHEN COUNT(ep.project_id) = 1 THEN 'Single Project'
        WHEN COUNT(ep.project_id) = 2 THEN 'Multi-Project'
        ELSE 'High Workload'
    END AS workload_category
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY
    e.employee_id,
    e.employee_name,
    e.employee_salary
ORDER BY e.employee_salary DESC;

-- ============================================================
-- 11. REUSABLE SQL VIEWS
-- ============================================================

-- Employee Project Details View
CREATE VIEW employee_project_details AS
SELECT
    e.employee_id,
    e.employee_name,
    e.employee_salary,
    p.project_name
FROM employees e
JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
JOIN projects p
    ON ep.project_id = p.project_id;

SELECT * FROM employee_project_details;

-- Employee Analytics View
CREATE VIEW employee_analytics AS
SELECT
    e.employee_id,
    e.employee_name,
    e.employee_salary,
    COUNT(ep.project_id) AS projects_working_on
FROM employees e
LEFT JOIN employee_projects ep
    ON e.employee_id = ep.employee_id
GROUP BY
    e.employee_id,
    e.employee_name,
    e.employee_salary;

SELECT * FROM employee_analytics;

-- Project Statistics View
CREATE VIEW project_statistics AS
SELECT
    p.project_id,
    p.project_name,
    COUNT(ep.employee_id) AS employee_count,
    ROUND(AVG(e.employee_salary), 2) AS average_salary
FROM projects p
LEFT JOIN employee_projects ep
    ON p.project_id = ep.project_id
LEFT JOIN employees e
    ON ep.employee_id = e.employee_id
GROUP BY
    p.project_id,
    p.project_name;

SELECT * FROM project_statistics;

-- High-Salary Employees View
CREATE VIEW high_salary_employees AS
SELECT
    employee_id,
    employee_name,
    employee_salary
FROM employees
WHERE employee_salary >= 60000;

SELECT * FROM high_salary_employees;

-- ============================================================
-- END OF PROJECT
-- ============================================================
