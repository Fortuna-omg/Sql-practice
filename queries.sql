-- Oracle SQL Practice
-- HR Schema


-- 1. Employees and their countries
SELECT DISTINCT
       e.first_name,
       e.last_name,
       c.country_name
FROM employees e
FULL OUTER JOIN departments d
    ON e.department_id = d.department_id
FULL OUTER JOIN locations l
    ON d.location_id = l.location_id
FULL OUTER JOIN countries c
    ON l.country_id = c.country_id;


-- 2. Departments with more than 30 employees
SELECT d.department_name,
       COUNT(e.employee_id)
FROM departments d
JOIN employees e
    USING (department_id)
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 30;


-- 3. Managers with more than 6 employees
SELECT e.first_name,
       COUNT(e2.employee_id)
FROM employees e
JOIN employees e2
    ON e.employee_id = e2.manager_id
GROUP BY e.empployee_id, e.first_name
HAVING COUNT(e2.employee_id) > 6;


-- 4. Employees whose manager was hired in 2005
-- and who were hired before 2005
SELECT e2.*
FROM employees e
JOIN employees e2
    ON e2.manager_id = e.employee_id
WHERE TO_CHAR(e.hire_date, 'YYYY') = '2005'
  AND TO_CHAR(e2.hire_date, 'YYYY') < '2005';

-- =========================================
-- Subqueries (Подзапросы)
-- =========================================

-- 1. Employees earning above the company average
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 2. Employees earning more than their department average
SELECT e.first_name,
       e.last_name,
       e.salary,
       e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);

-- 3. Employees with the maximum salary in the company
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);
