CREATE TABLE "Titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM "Titles";

CREATE TABLE "Departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_Departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM "Departments";

CREATE TABLE "Employees" (
    "emp_no" INTEGER   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_Employees" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM "Employees";

CREATE TABLE "Salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL
);

SELECT * FROM "Salaries";

CREATE TABLE "Dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL
);

SELECT * FROM "Dept_emp";

CREATE TABLE "Dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
	"emp_no" INTEGER   NOT NULL
);

SELECT * FROM "Dept_manager";

ALTER TABLE "Employees" ADD CONSTRAINT "fk_Employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "Titles" ("title_id");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_emp" ADD CONSTRAINT "fk_Dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Dept_manager" ADD CONSTRAINT "fk_Dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

SELECT * FROM "Employees";

SELECT * FROM "Dept_emp";

--List the following details of each employee: 
--employee number, last name, first name, sex, and salary.

SELECT e.emp_no, e.first_name, e.last_name, e.sex, s.salary
 FROM "Employees" AS e
 JOIN "Salaries" AS s
 ON (e.emp_no = s.emp_no);
 
 --List first name, last name, and hire date for employees who were hired in 1986
 
 SELECT first_name, last_name, hire_date
 FROM "Employees"
 WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';
 
 --List the manager of each department with the following information: 
 --department number, department name, the manager's employee number, last name, first name.

SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM "Dept_manager" AS dm
JOIN "Departments" AS d
ON (dm.dept_no = d.dept_no)
JOIN "Employees" AS e
ON (dm.emp_no = e.emp_no);

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Dept_emp" AS de
JOIN "Employees" as e
ON (de.emp_no = e.emp_no)
JOIN "Departments" as d
ON (de.dept_no = d.dept_no);

--List first name, last name, and sex for employees
--whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM "Employees"
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

--List all employees in the Sales department, 
--including their employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" AS e
JOIN "Dept_emp" AS de
ON (e.emp_no = de.emp_no)
JOIN "Departments" AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

--List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.

SELECT de.emp_no, e.last_name, e.first_name, d.dept_name
FROM "Employees" AS e
JOIN "Dept_emp" AS de
ON (e.emp_no = de.emp_no)
JOIN "Departments" AS d
ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN 
(
	SELECT dept_name
	FROM "Departments"
	WHERE dept_name = 'Sales'
	OR dept_name = 'Development'
);

--In descending order, list the frequency count of employee last names, 
--i.e., how many employees share each last name.

SELECT last_name, COUNT(last_name) AS last_name_frequency
FROM "Employees"
GROUP BY last_name
ORDER BY last_name_frequency DESC;

SELECT * FROM "Salaries";

--List employees salaries, employee_id, first_name and last_name
SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM "Employees" AS e
JOIN "Salaries" AS s
ON (e.emp_no = s.emp_no);

--Group employees by salaries
SELECT e.emp_no, s.salary
FROM "Employees" AS e
JOIN "Salaries" AS s
ON (e.emp_no = s.emp_no)
GROUP BY s.salary, e.emp_no
ORDER BY s.salary DESC;

