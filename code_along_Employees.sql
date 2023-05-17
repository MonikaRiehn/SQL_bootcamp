-- rename columns
SELECT emp_no AS "Employee No", birth_date AS "Birthday", first_name AS "First Name" FROM "public"."employees";

-- select the table titles
SELECT * FROM public.titles;
SELECT concat(emp_no, ' is a ', title) FROM titles;

SELECT * FROM public.employees;

-- show employee number, rename the column, then concat first- and last name and rename the column:
SELECT emp_no AS "Employee No.", concat (first_name, ' ', last_name) AS "Employee Name" FROM public.employees;

SELECT * FROM public.employees;

-- count the total number of employees (use employee number)
SELECT count(emp_no) FROM public.employees;
SELECT sum(salary) FROM public.salaries;
SELECT min(salary) FROM public.salaries;
SELECT max(salary) FROM public.salaries;

SELECT avg(salary) FROM public.salaries;

-- show the youngest employee
SELECT * FROM "public"."employees";
SELECT max(birth_date) FROM public.employees;

/*
* Multi line comments are also 
* pretty sweet
*/

-- select employee 'Mayumi Schueller'
SELECT * FROM public.employees WHERE first_name='Mayumi' AND last_name='Schueller';

/*
COMMON SELECT MISTAKES
'' single quotes for text, e.g. names: 'name'
"" double quotes for tables, e.g. "employees", when case-sensitive
if only lowercase, no quotes necessary (?)
*/

-- Filter data
SELECT
  first_name,
  last_name
FROM
  public.employees
WHERE gender = 'F' ;

SELECT count(emp_no) FROM public.employees WHERE gender='F';

-- AND/OR -- Order of operations
SELECT hire_date, first_name, last_name FROM "public"."employees"
WHERE first_name='Georgi' OR first_name='Bezalel';

SELECT first_name, last_name, hire_date FROM "public"."employees"
WHERE first_name = 'Georgi' AND last_name = 'Facello' AND hire_date = '1986-06-26';

-- if all the first part matches OR second part
SELECT first_name, last_name, hire_date FROM "public"."employees"
WHERE (first_name = 'Georgi' AND last_name = 'Facello' AND hire_date = '1986-06-26')
OR (first_name = 'Bezalel' AND last_name = 'Simmel');

/* SQL chains all the ANDs together after the OR. Wie Punkt-vor-Strich: AND-vor-OR
where SQL/the WHERE clause sees an OR, it starts a new filter !
WHERE(...AND ...) OR (... AND...)
*/
SELECT first_name, last_name, hire_date FROM employees
WHERE (first_name = 'Georgi' AND last_name = 'Facello' AND hire_date = '1986-06-26') -- contains many specific filters
OR (first_name = 'Bezalel' AND last_name = 'Simmel');

-- Parentheses - */ - +/- - NOT - AND - OR

-- the IS operator allows you to filter on values that are null, not null, true or false
-- SELECT * FROM table WHERE field IS [NOT] NULL
-- SELECT * FROM table WHERE field = '' IS NOT FALSE

-- EXERCISES 

-- Get all employees above 60 (select age(birth_date) creates new column with exact age, in sense of interval from birthday to now)
SELECT age(birth_date), * FROM employees 
WHERE (
    EXTRACT(YEAR FROM age(birth_date))
) > 60;

-- alternatively
SELECT age(birth_date), * FROM employees
WHERE birth_date < now() - INTERVAL '61 years';

-- How many employees were hired in February?
SELECT count(emp_no) FROM employees 
WHERE EXTRACT (MONTH FROM hire_date) = 2;

-- How many employees were born in November?
SELECT count(emp_no) FROM employees
WHERE EXTRACT(MONTH FROM birth_date) = 11;

-- Who is the oldest employee?
SELECT min(birth_date) FROM employees;
SELECT max(age(birth_date)) FROM employees;


-- EXERCISES SORT
SELECT * FROM employees
ORDER BY first_name ASC, last_name DESC;

SELECT * FROM employees
ORDER BY birth_date ASC;

SELECT * FROM employees
WHERE first_name ILIKE 'k%'
ORDER BY hire_date;


-- Exercises Inner Join
-- Show for each employee which department they work in
SELECT e.first_name, d.dept_name
FROM employees AS e
INNER JOIN dept_emp AS de ON e.emp_no = de.emp_no
INNER JOIN departments AS d ON de.dept_no = d.dept_no;

/*GROUP BY
splits data into groups or chunks so we can apply functions against the group rather than the entire table
we use group by almost exclusively with aggregate functions (sum, count, min, max, avg,...)
every column (in select) which is not in the group-by-clause must apply a function (here emp_no need the function count)

count no. of employees per department:
*/
SELECT dept_no, count(emp_no)
FROM dept_emp
GROUP BY dept_no;