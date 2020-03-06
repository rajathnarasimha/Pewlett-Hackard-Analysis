# Pewlett-Hackard-Analysis

## Report:


## 1. Number of individuals retiring :  41380
## -- Number of employees retiring
## SELECT COUNT(first_name)
## FROM employees
## WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
## AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

## 2. Number of individuals being hired : 41380
## 3. Number of individuals available for mentorship : 18928
## -- Employees available for mentorship
## select ri.emp_no,
## ri.first_name,
## ri.last_name,
## d.dept_name
## from retirement_info as ri
## inner join dept_emp as de
## on (ri.emp_no = de.emp_no)
## inner join departments as d
## on(de.dept_no = d.dept_no)
## where d.dept_name in ('Sales', 'Development');

## 4. We can analyse this company's data set based on the department and position  (title) and have a hiring plan for each department and position.
