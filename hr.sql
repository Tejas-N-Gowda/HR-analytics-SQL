create database project_3;
use project_3;
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100)
);

CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  full_name VARCHAR(100),
  gender VARCHAR(10),
  age INT,
  join_date DATE,
  department_id INT,
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE salaries (
  employee_id INT,
  salary INT,
  effective_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE performance_reviews (
  review_id INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INT,
  review_date DATE,
  rating DECIMAL(2,1),
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

INSERT INTO departments VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Finance'),
(4, 'Sales'),
(5, 'Marketing');

INSERT INTO employees VALUES
(101, 'Alice Johnson', 'Female', 28, '2021-01-15', 1),
(102, 'Bob Smith', 'Male', 35, '2019-06-10', 2),
(103, 'Carol Lee', 'Female', 42, '2018-11-01', 3),
(104, 'David Brown', 'Male', 29, '2020-03-20', 4),
(105, 'Eva Green', 'Female', 31, '2021-07-12', 5),
(106, 'Frank White', 'Male', 40, '2017-08-30', 1),
(107, 'Grace Kim', 'Female', 26, '2023-01-05', 1);

INSERT INTO salaries VALUES
(101, 60000, '2023-01-01'),
(102, 55000, '2023-01-01'),
(103, 72000, '2023-01-01'),
(104, 50000, '2023-01-01'),
(105, 48000, '2023-01-01'),
(106, 80000, '2023-01-01'),
(107, 62000, '2024-01-01');

INSERT INTO performance_reviews (employee_id, review_date, rating) VALUES
(101, '2023-01-10', 4.5),
(102, '2023-01-12', 3.8),
(103, '2023-01-15', 4.2),
(104, '2023-01-20', 4.0),
(105, '2023-01-25', 3.5),
(106, '2023-02-01', 4.9),
(107, '2024-02-10', 4.7);

-- Q1. Average salary per department
SELECT d.department_name, ROUND(AVG(s.salary), 2) AS avg_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Q2. Top 3 highest paid employees
SELECT e.full_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
ORDER BY s.salary DESC
LIMIT 3;

-- Q3. Employees who joined in the last 3 years
SELECT full_name, join_date
FROM employees
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Q4. Department with highest average performance rating
SELECT d.department_name, ROUND(AVG(p.rating), 2) AS avg_rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_reviews p ON e.employee_id = p.employee_id
GROUP BY d.department_name
ORDER BY avg_rating DESC
LIMIT 1;

-- Q5. Employees with above average salary
SELECT e.full_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary > (SELECT AVG(salary) FROM salaries);

-- Q6. Count of employees per department
SELECT d.department_name, COUNT(e.employee_id) AS num_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Q7. Most recent performance review per employee
SELECT e.full_name, MAX(p.review_date) AS last_review
FROM employees e
JOIN performance_reviews p ON e.employee_id = p.employee_id
GROUP BY e.full_name;

-- Q8. View: High performers (rating >= 4.5)
SELECT e.full_name, d.department_name, p.rating
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN performance_reviews p ON e.employee_id = p.employee_id
WHERE p.rating >= 4.5;

-- Q9. Employees with no performance review in 2023
SELECT e.full_name
FROM employees e
WHERE NOT EXISTS (
  SELECT 1
  FROM performance_reviews p
  WHERE p.employee_id = e.employee_id AND YEAR(p.review_date) = 2023
);

-- Q10. Department-wise gender ratio
SELECT d.department_name,
       SUM(CASE WHEN gender = 'Male' THEN 1 ELSE 0 END) AS male_count,
       SUM(CASE WHEN gender = 'Female' THEN 1 ELSE 0 END) AS female_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Q11. Rank employees by salary within department
SELECT 
  d.department_name,
  e.full_name,
  s.salary,
  RANK() OVER (PARTITION BY e.department_id ORDER BY s.salary DESC) AS salary_rank
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- Q12. Performance trend (average rating by month)
SELECT DATE_FORMAT(review_date, '%Y-%m') AS review_month,
       ROUND(AVG(rating), 2) AS avg_rating
FROM performance_reviews
GROUP BY review_month
ORDER BY review_month;

-- Q13. Employees earning more than department average
SELECT e.full_name, d.department_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
WHERE s.salary > (
  SELECT AVG(s2.salary)
  FROM salaries s2
  JOIN employees e2 ON s2.employee_id = e2.employee_id
  WHERE e2.department_id = e.department_id
);

-- Q14. View: Department-wise salary summary
CREATE VIEW department_salary_summary AS
SELECT d.department_name,
       COUNT(e.employee_id) AS total_employees,
       ROUND(AVG(s.salary), 2) AS avg_salary,
       MAX(s.salary) AS max_salary,
       MIN(s.salary) AS min_salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- Query the view
SELECT * FROM department_salary_summary ORDER BY avg_salary DESC;

