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
