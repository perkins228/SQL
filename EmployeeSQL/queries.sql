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

--List the following details of each employee: employee number, last name, first name, sex, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary 
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no
ORDER BY s.salary DESC;

--List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE date_part('year', hire_date) = '1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT d.dept_no, dp.dept_name, d.emp_no, e.last_name, e.first_name
FROM dept_manager AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no;

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS d
ON e.emp_no = d.emp_no
LEFT JOIN departments as dp
ON d.dept_no = dp.dept_no;

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT d.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no
WHERE dp.dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.emp_no, e.last_name, e.first_name, dp.dept_name
FROM dept_emp AS d
JOIN employees AS e
ON d.emp_no = e.emp_no
JOIN departments AS dp
ON d.dept_no = dp.dept_no
WHERE dp.dept_name = 'Sales' OR dp.dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM employees
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;


