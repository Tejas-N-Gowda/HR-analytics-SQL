# 👔 SQL Project : HR Analytics

This project uses SQL to explore workforce data for a fictional company. It analyzes salaries, employee performance, demographics, and departmental trends to support HR decision-making.

---

## 🗃️ Dataset Overview

Four main tables were created and populated:

- **departments** – department_id, department_name  
- **employees** – employee_id, name, gender, age, join_date, department_id  
- **salaries** – employee_id, salary, effective_date  
- **performance_reviews** – review_id, employee_id, review_date, rating  

---

## 🧠 Questions Solved (14 total)

| # | Topic | SQL Concepts Used |
|--|-------|--------------------|
| 1 | Avg salary per department | `AVG()`, `JOIN`, `GROUP BY` |
| 2 | Top 3 highest paid | `ORDER BY`, `LIMIT` |
| 3 | Recently joined employees | `DATE_SUB()`, `CURDATE()` |
| 4 | Top department by performance | `AVG()`, `JOIN`, `LIMIT` |
| 5 | Above-average salary holders | `SUBQUERY`, `AVG()` |
| 6 | Employee count by department | `COUNT()`, `GROUP BY` |
| 7 | Last review date per employee | `MAX()`, `GROUP BY` |
| 8 | High performers view (rating ≥ 4.5) | `VIEW`, `JOIN`, `WHERE` |
| 9 | No reviews in 2023 | `NOT EXISTS`, `YEAR()` |
| 10 | Gender ratio per department | `CASE`, `GROUP BY` |
| 11 | Salary rank within department | `RANK() OVER(PARTITION BY)` |
| 12 | Rating trend by month | `DATE_FORMAT()`, `AVG()` |
| 13 | Earners above department average | `CORRELATED SUBQUERY` |
| 14 | Salary summary view | `VIEW`, `MAX()`, `MIN()`, `AVG()` |

---

## 📌 Key Insights

- The **Engineering** department has the highest average salary and top performers.
- **Frank White** is the highest paid employee and a top-rated performer.
- **Grace Kim**, hired in 2023, also scored a top-tier rating.
- The gender distribution is reasonably balanced across departments.
- The dynamic views help build reusable summaries for HR dashboards.

---

## 🛠️ Techniques Practiced

- ✅ Aggregate functions: `AVG()`, `COUNT()`, `MAX()`, `MIN()`  
- ✅ Joins & subqueries  
- ✅ Window functions: `RANK()`  
- ✅ Views for reusable analytics  
- ✅ Temporal filtering and formatting with `DATE_FORMAT()`, `YEAR()`  

---

## 📁 Files Included

- `hr_analytics.sql` – Tables, data inserts, and all 14 queries
- `README.md` – Project description, results, and insights
- `high_performers` and `department_salary_summary` views

---

## 👤 Author

**Tejas N Gowda**  
📧 tejasngowda1431@gmail.com 
🔗 www.linkedin.com/in/tejas-n-gowda-62b7b4252
