DROP TABLE departments CASCADE;
DROP TABLE dept_manager CASCADE;
DROP TABLE dept_emp CASCADE;
DROP TABLE employees CASCADE;
DROP TABLE salaries CASCADE;
DROP TABLE titles CASCADE;

CREATE TABLE titles (
    title_id varchar NOT NULL,
    title varchar NOT NULL,
    PRIMARY KEY (title_id)
);

CREATE TABLE employees (
    emp_no int NOT NULL,
    emp_title_id varchar NOT NULL,
    birth_date date NOT NULL,
    first_name varchar NOT NULL,
    last_name varchar NOT NULL,
    sex varchar NOT NULL,
    hire_date date NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

CREATE TABLE departments (
    dept_no varchar NOT NULL,
    dept_name varchar NOT NULL,
    PRIMARY KEY (dept_no)
);

CREATE TABLE dept_manager (
    dept_no varchar NOT NULL,
    emp_no int NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE dept_emp (
    emp_no int  NOT NULL,
    dept_no varchar  NOT NULL,
	PRIMARY KEY (dept_no, emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);


CREATE TABLE salaries (
    emp_no int NOT NULL,
    salary int NOT NULL,
    PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

COPY departments
FROM 'C:\Users\perki\Desktop\sql-challenge\data\departments.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM departments;

COPY titles
FROM 'C:\Users\perki\Desktop\sql-challenge\data\titles.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM titles;

COPY employees
FROM 'C:\Users\perki\Desktop\sql-challenge\data\employees.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM employees;

COPY salaries
FROM 'C:\Users\perki\Desktop\sql-challenge\data\salaries.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM salaries;

COPY dept_manager
FROM 'C:\Users\perki\Desktop\sql-challenge\data\dept_manager.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM dept_manager;

COPY dept_emp
FROM 'C:\Users\perki\Desktop\sql-challenge\data\dept_emp.csv'
DELIMITER ',' CSV HEADER;
SELECT * FROM dept_emp;



