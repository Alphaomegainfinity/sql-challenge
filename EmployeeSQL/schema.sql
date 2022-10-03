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