SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM salaries;
SELECT * FROM titles;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';


-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
	FROM retirement_info
	LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;


-- Joining retirement_info and dept_emp tables
SELECT ri.emp_no,
	ri.first_name,
ri.last_name,
	de.to_date
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;


-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_count_by_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT * FROM salaries
ORDER BY to_date DESC;


SELECT emp_no,
	first_name,
last_name,
	gender
	INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
	INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	      AND (de.to_date = '9999-01-01');

-- List of managers per department
        SELECT  dm.dept_no,
                d.dept_name,
                dm.emp_no,
                ce.last_name,
                ce.first_name,
                dm.from_date,
                dm.to_date
      --  INTO manager_info
        FROM dept_manager AS dm
            INNER JOIN departments AS d
                ON (dm.dept_no = d.dept_no)
            INNER JOIN current_emp AS ce
                ON (dm.emp_no = ce.emp_no);

  SELECT ce.emp_no,
                ce.first_name,
                ce.last_name,
                d.dept_name
                -- INTO dept_info
                FROM current_emp as ce
                INNER JOIN dept_emp AS de
                ON (ce.emp_no = de.emp_no)
                INNER JOIN departments AS d
                ON (de.dept_no = d.dept_no);




select ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
from retirement_info as ri
inner join dept_emp as de
on (ri.emp_no = de.emp_no)
inner join departments as d
on(de.dept_no = d.dept_no)
where d.dept_name = 'Sales';



select ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
from retirement_info as ri
inner join dept_emp as de
on (ri.emp_no = de.emp_no)
inner join departments as d
on(de.dept_no = d.dept_no)
where d.dept_name = 'Sales' OR d.dept_name = 'Development';


select ri.emp_no,
ri.first_name,
ri.last_name,
d.dept_name
from retirement_info as ri
inner join dept_emp as de
on (ri.emp_no = de.emp_no)
inner join departments as d
on(de.dept_no = d.dept_no)
where d.dept_name in ('Sales', 'Development');

--------------------------Challenge Solutions---------------------------

---Number of [titles] Retiring
select ri.emp_no,
ri.first_name,
ri.last_name,
tl.title,
tl.from_date,
s.salary
into no_of_titles
from retirement_info as ri
inner join titles as tl
on (ri.emp_no = tl.emp_no)
inner join salaries as s
on (tl.emp_no = s.emp_no );


SELECT
  first_name,
  last_name,
  count(*)
FROM no_of_titles
GROUP BY
  first_name,
  last_name
HAVING count(*) > 1;


SELECT * FROM
  (SELECT *, count(*)
  OVER
    (PARTITION BY
      first_name,
      last_name
    ) AS count
  FROM no_of_titles) no_of_titles
  WHERE no_of_titles.count > 1;



  SELECT
    first_name,
    last_name,
    string_agg(title, ' / ') AS title
  FROM no_of_titles
  GROUP BY
    first_name,
    last_name;


    SELECT first_name, last_name, from_date, title into one_title FROM
    (SELECT first_name, last_name, from_date, title,
       ROW_NUMBER() OVER
  (PARTITION BY (first_name, last_name) ORDER BY from_date DESC) rn
     FROM no_of_titles
    ) tmp WHERE rn = 1;


select count(*), title
 from one_title
 where title in (select distinct title from one_title)
 group by title;


--Only the Most Recent Titles
select count(*), title
 into most_recent_frequency
 from one_title
 where title in (select distinct title from one_title)
 group by title;

--Who’s Ready for a Mentor?
select e.emp_no, e.first_name,e.last_name, tl.title, tl.from_date, tl.to_date
into ready_for_mentor
from employees as e
inner join titles as tl
on(e.emp_no = tl.emp_no)
where (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') and (tl.to_date = '9999-01-01');
