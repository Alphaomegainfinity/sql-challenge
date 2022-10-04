--DROP TABLE IF EXISTS Departments CASCADE;
--DROP TABLE IF EXISTS Department_Employee CASCADE;
--DROP TABLE IF EXISTS Department_Manager CASCADE;
--DROP TABLE IF EXISTS Employees CASCADE;
--DROP TABLE IF EXISTS Salaries CASCADE;
--DROP TABLE IF EXISTS Titles CASCADE;

-- DATA ENGINEERING
-- Create tables for Titles, Employees, Salaries, Departments, Department Manager and Department Employees 
--(import data csv into tables according to its order with table Titles as 1st and table Department Employees as the last one)

CREATE TABLE Departments (
  dept_no VARCHAR(4) NOT NULL,
  dept_name VARCHAR NOT NULL,
  PRIMARY KEY (dept_no)
);

CREATE TABLE Titles (
  title_id character varying(5) NOT NULL,
  title character varying NOT NULL,
  PRIMARY KEY (title_id)
);

CREATE TABLE Employees (
  emp_no integer NOT NULL,
  emp_title character varying(5) NOT NULL,
  birth_day VARCHAR NOT NULL,
  first_name character varying NOT NULL,
  last_name character varying NOT NULL,
  sex character varying(1) NOT NULL,	
  hire_date character varying NOT NULL,
  PRIMARY KEY (emp_no),
  FOREIGN KEY (emp_title) REFERENCES Titles (title_id)
);

CREATE TABLE Department_Employee (
  emp_no integer NOT NULL,
  dept_no VARCHAR(4) NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES Departments (dept_no),
  FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);
CREATE TABLE Salaries (
    emp_no integer NOT NULL,
    salary integer NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees (emp_no)
);

CREATE TABLE Department_Manager (
  dept_no character varying(4) NOT NULL,
  emp_no integer NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES Employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES Departments (dept_no)
);

-- Data Analysis:

-- Convert and Update birth_day & hire_date column in Employees table from VARCHAR to DATE (convert the US date type to YYYY-MM-DD)
UPDATE Employees
SET birth_day = to_date(birth_day, 'MM/DD/YYYY'), hire_date = to_date(hire_date, 'MM/DD/YYYY');

--1.List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT emp.emp_no, emp.first_name, emp.last_name, emp.sex, s.salary
FROM Employees emp
JOIN Salaries s 
ON emp.emp_no = s.emp_no;

-- 2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM Employees emp
WHERE hire_date LIKE '1986%'

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept.dept_no AS "Department Number", dept.dept_name AS "Department Name", mgr.emp_no AS "Manager employee number", emp.first_name AS "First Name", emp.last_name AS "Last Name"
FROM Employees AS emp 
JOIN Department_Manager AS mgr
ON emp.emp_no = mgr.emp_no
JOIN Departments AS dept
ON mgr.dept_no = dept.dept_no


--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name",emp.first_name AS "First Name", dept.dept_name AS "Department Name"
FROM Employees AS emp 
JOIN Department_Employee AS dept_emp 
ON emp.emp_no = dept_emp.emp_no
JOIN Departments AS dept
ON dept_emp.dept_no = dept.dept_no


--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name AS "First Name", last_name AS "Last Name", sex AS "Gender"
FROM Employees
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%'


--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name",emp.first_name AS "First Name", dept.dept_name AS "Department Name"
FROM Employees AS emp 
JOIN Department_Employee AS dept_emp 
ON emp.emp_no = dept_emp.emp_no
JOIN Departments AS dept
ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name = 'Sales'


--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.emp_no AS "Employee Number", emp.last_name AS "Last Name",emp.first_name AS "First Name", dept.dept_name AS "Department Name"
FROM Employees AS emp 
JOIN Department_Employee AS dept_emp 
ON emp.emp_no = dept_emp.emp_no
JOIN Departments AS dept
ON dept_emp.dept_no = dept.dept_no
WHERE dept.dept_name IN ('Sales', 'Development')


--8. List the frequency count of employee last names (i.e., how many employees share each last name) in descending order.
SELECT last_name AS "LAST NAME", COUNT (last_name) AS "Frequency Count"
FROM Employees
GROUP BY last_name
HAVING COUNT (last_name) >1
ORDER BY last_name DESC;

