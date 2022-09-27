-- Compiling table of retirement eligible employees respective titles
Select e.emp_no,
       e.first_name,
	   e.last_name,
	   t.title,
	   t.from_date,
	   t.to_date
INTO retirement_titles
FROM employees as e 
	LEFT JOIN titles as t
		on (e.emp_no = t.emp_no)
		WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
		ORDER BY e.emp_no
		
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no)
       rt.emp_no,
       rt.first_name,
	   rt.last_name,
	   rt.title
INTO unique_titles
FROM retirement_titles as rt
WHERE (rt.to_date = '9999-01-01')
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- Number of employees by most recent job who are about to retire
SELECT count(ut.title) as "title count", ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY "title count" DESC;

-- Mentorship Eligibility Table
SELECT DISTINCT ON (e.emp_no)
	   e.emp_no,
	   e.first_name,
	   e.last_name,
	   e.birth_date,
	   de.from_date,
	   de.to_date,
	   t.title
INTO mentorship_eligibility
FROM employees as e
	LEFT JOIN dept_emp as de ON (e.emp_no = de.emp_no)
		LEFT JOIN titles as t on (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no
      