-- Завдання 1.3
select count(*) as employees_total from hr.employees;
-- Завдання 2.1
select 
	first_name, 
	last_name 
from hr.employees 
where 
	manager_id = 101 
order by employee_id;
-- Завдання 2.2
select 
	first_name, 
	last_name, 
	salary 
from hr.employees 
	where salary < 4000 
order by salary;
-- Завдання 2.3
select 
	employee_id, 
	first_name, 
	last_name, 
	hire_date 
from hr.employees 
where 
	hire_date between '1996-01-01' and '1996-12-31'
order by hire_date;
-- Завдання 2.4
select 
	employee_id, 
	first_name, 
	last_name, 
	email 
from hr.employees 
where 
	email like '%example.com' 
order by email;
-- Завдання 2.5
select 
	employee_id, 
	first_name, 
	last_name, 
	department_id 
from hr.employees 
where 
	department_id in (20,30) 
order by department_id,employee_id;
-- Завдання 2.6
select 
	employee_id, 
	first_name 
from hr.employees 
where 
	lower(first_name) like '%a' 
order by first_name;
-- Завдання 2.7
select 
	employee_id, 
	first_name, 
	last_name, 
	salary, 
	commission_pct 
from hr.employees 
where 
	salary > 6000 and commission_pct = 0.15 
order by salary desc;
-- Завдання 2.8
select 
	employee_id, 
	first_name, 
	last_name, 
	phone_number 
from hr.employees 
where 
	phone_number like '515%' 
order by phone_number;
-- Завдання 2.9
select 
	employee_id, 
	first_name, 
	last_name, 
	salary 
from hr.employees 
where 
	department_id = 20 
order by salary desc;
-- Завдання 2.10
select 
	employee_id, 
	first_name, 
	last_name, 
	hire_date 
from hr.employees 
order by hire_date, employee_id 
limit 7;
-- Завдання 2.11
select 
	employee_id, 
	first_name, 
	last_name, 
	salary 
from hr.employees 
where 
	salary > 4000 order by employee_id 
limit 5;
-- Завдання 2.12 
select 
	employee_id, 
	first_name, 
	last_name, 
	cast(cast(salary as int) as text) || ' EUR' as salary_eur 
from hr.employees 
order by employee_id;
-- Завдання 2.13
select 
	employee_id,
	first_name, 
	last_name 
from hr.employees 
where 
	manager_id = 101 
order by last_name;
-- Завдання 2.14
select 
	employee_id, 
	first_name, 
	last_name, 
	salary 
from hr.employees 
order by salary desc 
offset 3 
limit 10;
-- Завдання 2.15
select 
	employee_id, 
	first_name, 
	last_name, 
	hire_date 
from hr.employees 
	where hire_date > '2000-01-01' 
order by hire_date desc;
-- Завдання 3.1
select round(avg(salary), 2) as avg_salary from hr.employees 
where 
	job_id like 'S%';
-- Завдання 3.2
select 
	department_id, 
	min(salary), 
	max(salary) 
from hr.employees 
group by department_id 
order by department_id;
-- Завдання 3.3
select 
	count(*) as employees_count 
from hr.employees 
where 
	salary > 3000;
-- Завдання 3.4
select 
	department_id, 
	sum(salary) as total_salary 
from hr.employees 
group by department_id 
having sum(salary) > 10000 
order by total_salary desc;
-- Завдання 3.5
select 
	employee_id, 
	first_name, 
	last_name, 
	coalesce(commission_pct,0) as commission 
from hr.employees 
order by employee_id;
-- Завдання 3.6
select 
	employee_id, 
	last_name, 
	salary + salary * coalesce(commission_pct, 0) as total_income 
from hr.employees 
where salary + salary * coalesce(commission_pct, 0) > 5000 
order by total_income desc;
-- Завдання 4.1
select 
	a.first_name, 
	a.last_name, 
	b.job_title 
from hr.employees as a join jobs as b on a.job_id = b.job_id order by last_name;
-- Завдання 4.2
select 
	a.first_name, 
	a.last_name, 
	a.salary, 
	b.job_title 
from hr.employees as a 
join hr.jobs as b on a.job_id = b.job_id 
	where 
		salary > 5000 
order by salary desc;
-- Завдання 4.3
select 
	a.first_name, 
	a.last_name, 
	b.department_name 
from hr.employees as a 
left join hr.departments as b on a.department_id = b.department_id
order by a.last_name;
-- Завдання 4.4
select 
	b.department_name,
	a.first_name, 
	a.last_name 
from hr.employees as a 
right join hr.departments as b on a.department_id = b.department_id
order by b.department_name;
-- Завдання 4.5
select 
	a.first_name, 
	a.last_name, 
	b.department_name 
from hr.employees as a 
full outer join hr.departments as b on a.department_id = b.department_id
order by b.department_name,a.last_name;
-- Завдання 4.6
select 
	a.first_name, 
	a.last_name, 
	b.job_title,
	c.department_name
from hr.employees as a 
left join hr.jobs as b on a.job_id = b.job_id 
left join hr.departments as c on a.department_id = c.department_id
order by c.department_name,a.last_name;
--Завдання 4.7
select 
	a.department_name,
	count(b.employee_id) as employees_count
from hr.departments a
left join hr.employees b on a.department_id = b.department_id
group by a.department_name
order by count(b.employee_id) desc;
--Завдання 4.8
select 
	a.department_name,
	count(b.employee_id) as employees_count
from hr.departments a
left join hr.employees b on a.department_id = b.department_id
group by a.department_name
having count(b.employee_id) > 3
order by count(b.employee_id) desc;
--Завдання 4.9
select 	
	a.department_name, 
	c.country_name 
from hr.departments as a
join hr.locations as b on a.location_id = b.location_id
join hr.countries as c on b.country_id = c.country_id
order by c.country_name,a.department_name;
--Завдання 4.10
select 	
	a.first_name, 
	a.last_name,
	b.department_name 
from hr.employees as a
left join hr.departments as b on a.department_id = b.department_id
left join hr.locations as c on b.location_id = c.location_id
left join hr.countries as d on c.country_id = d.country_id
left join hr.regions as e on d.region_id = e.region_id
where 
	e.region_name = 'Europe'
order by a.last_name;
--Завдання 5.1
select
	employee_id, 
	first_name, 
	last_name, 
	salary
from hr.employees
where
	salary > (select avg(salary) from hr.employees)
order by salary desc;
--Завдання 5.2
select 
	department_id, 
	department_name
from hr.departments 
where 
	department_id in (select department_id from hr.employees group by department_id having sum(salary) > 100000)
order by department_id;
-- Завдання 5.3
select 
	employee_id, 
	first_name, 
	last_name
from hr.employees
where 
	department_id in (select department_id from hr.departments 
					  where location_id in (select location_id from hr.locations where city like 'S%'))
order by employee_id;
-- Завдання 5.4
select 
	a.employee_id, 
	a.last_name, 
	a.salary,
	a.job_id 
from hr.employees as a
where
	a.salary > (select b.max_salary from hr.jobs as b where a.job_id = b.job_id)
order by a.salary desc; 
-- Завдання 5.5
select 
	department_id, 
	department_name
from hr.departments
where
	department_id not in (select department_id from hr.employees where department_id is not null)
order by department_id;
-- Завдання 5.6
select 
	department_id,
	count(employee_id) as employees_count
from hr.employees
where 
	department_id in (select department_id from hr.employees group by department_id having avg(salary) > 15000)
group by department_id
order by department_id;








