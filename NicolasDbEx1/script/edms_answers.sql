-- ITEM 1

create database edms;
\c edms;

create table salary_grade(
	grade integer not null,
	min_salary integer not null,
	max_salary integer not null
);

create table department(
	dep_id integer not null primary key,
	dep_name varchar(20) not null,
	dep_location varchar(20) not null
);

create table employees(
	emp_id integer not null primary key,
	emp_name varchar(15) not null,
	job_name varchar(10) not null,
	manager_id integer,
	hire_date date not null,
	salary decimal(10,2) not null,
	commission decimal(7,2),
	dep_id integer not null,
	foreign key (dep_id) references department(dep_id) on delete cascade on update cascade
);

insert into salary_grade
values(1, 800, 1300),
	(2, 1301, 1500),
	(3, 1501, 2100),
	(4, 2101, 3100),
	(5, 3101, 9999);
		
insert into department 
values(1001, 'FINANCE', 'SYDNEY'),
	(2001, 'AUDIT', 'MELBOURNE'),
	(3001, 'MARKETING', 'PERTH'),
	(4001, 'PRODUCTION', 'BRISBANE');
		
insert into employees
values(68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000.00, NULL, 1001),
	(66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750.00, NULL, 3001),
	(67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', 2550.00, NULL, 1001),
	(65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957.00, NULL, 2001),
	(67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', 3100.00, NULL, 2001),
	(69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100.00, NULL, 2001),
	(63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900.00, NULL, 2001),
	(64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00, 3001),
	(65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00, 3001),
	(66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350.00, 1500.00, 3001),
	(68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, 0.00, 3001),
	(68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200.00, NULL, 2001),
	(69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050.00, NULL, 3001),
	(69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, NULL, 1001);

-- ITEM 2
select emp_name as "Managers wih salary between 1500-2500"
from employees
where job_name = 'MANAGER' and salary between 1500.00 and 2500.00;

-- ITEM 3
with employees_cte as (
	select emp_name, job_name, (salary + coalesce(commission, 0.0)) as income 
	from employees
)
select emp_name as "Salesmen with an income above 2000"
from employees_cte
where job_name = 'SALESMAN' and income > 2000.00;

-- ITEM 4
select emp_name as "Employees working in Sydney"
from employees emp inner join department dept
on emp.dep_id = dept.dep_id
where emp.dep_id = 1001;

-- ITEM 5 
select emp.emp_name as "Employees earning more than their manager"
from employees emp inner join employees mgr 
on emp.manager_id = mgr.emp_id
where emp.salary > mgr.salary;

-- ITEM 6
select emp.emp_name as "Salesmen earning a salary grade of 2"
from employees emp inner join salary_grade sal 
on emp.salary between sal.min_salary and sal.max_salary
where emp.job_name = 'SALESMAN' and sal.grade = 2;

-- ITEM 7
select emp.emp_name as "Employee Name", sal.grade as "Salary Grade"
from employees emp inner join salary_grade sal 
on emp.salary between sal.min_salary and sal.max_salary
order by sal.grade;

-- ITEM 8
select distinct mgr.emp_name as "Employees managing at least one salesman"
from employees mgr join employees subordinates
on  mgr.emp_id = subordinates.manager_id
where subordinates.job_name = 'SALESMAN';

-- ITEM 9
select dep_name as "Departments located in Melbourne"
from department
where dep_location = 'MELBOURNE';

-- ITEM 10
select mgr.emp_name as "Employees managing at least three people"
from employees mgr
where mgr.emp_id in (
      select emp.manager_id
      from employees emp
      where emp.manager_id is not null 
      and (select count(*)
           from employees subordinates
           where subordinates.manager_id = emp.manager_id) >= 3);

-- ITEM 11
select emp_name, rpad(to_char(salary * (1.15), 'FM$999G999D00'), 15, '-') as increased_salary
from employees;

-- ITEM 12
select emp_name || ' & ' || job_name as "Employee & Job"
from employees;

-- ITEM 13
select emp_name || ': ' || trim(to_char(hire_date, 'Month DD, YYYY')) as "Employees' Hired Date"
from employees;

-- ITEM 14
select emp_name as "Employees who joined in January"
from Employees
where date_part('month', hire_date) = '01';

-- ITEM 15
select hire_date, job_name, emp_name
from employees
where hire_date < '1992-12-31';

-- ITEM 16
select emp_id, emp_name, salary
from employees
where hire_date < now() - interval '10 years';

-- ITEM 17
select emp_name as "Employee Names containing 'AR'"
from employees
where emp_name like '%AR%';

-- ITEM 18
select emp.emp_name, sal.grade as salary_grade, emp.job_name,
	case
		when emp.salary between 2000 and 10000 then 'Supervisory'
		when emp.salary between 1000 and 1999 then 'Team Leader'
		when emp.salary between 700 and 999 then 'Administrative'
		else 'NA'
	end as salary_category
from employees emp inner join salary_grade sal
on emp.salary between sal.min_salary and sal.max_salary;

-- ITEM 19
select emp_name, emp_id, salary, coalesce(commission, 0.0) as commission
from employees;

-- ITEM 20
select *
from employees
where commission is not null;
