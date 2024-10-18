-- ITEM #1
/*
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

insert into employees 
values(68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000.00, NULL, 1001),
		(66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750.00, NULL, 3001),
		(67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', 2550.00, NULL, 1001),
		(65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957.00, NULL, 2001),
		(67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', 3100.00, NULL, 2001),
		(69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100.00, NULL, 2001),
		(63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900.00, NULL, 2001);
		
		(64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00, 3001),
		(65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00, 3001),
		(66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350.00, 1500.00, 3001),
		(68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, 0.00, 3001),
		(68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200.00, NULL, 2001),
		(69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050.00, NULL, 3001),
		(69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, NULL, 1001); 
		
insert into department 
values(1001, 'FINANCE', 'SYDNEY'),
		(2001, 'AUDIT', 'MELBOURNE'),
		(3001, 'MARKETING', 'PERTH'),
		(4001, 'PRODUCTION', 'BRISBANE'); 

insert into salary_grade
values(1, 800, 1300),
		(2, 1301, 1500),
		(3, 1501, 2100),
		(4, 2101, 3100),
		(5, 3101, 9999);		
*/

-- ITEM #2
--select emp_name
--from employees
--where job_name = 'MANAGER' and salary between 1500.00 and 2500.00;

-- ITEM #3 (not ok)
--select emp_name, (salary + commission) as income
--from employees
--where income > 2000.00;

-- ITEM 4
--select emp_name, dep_name
--from employees emp inner join department dept
--on emp.dep_id = dept.dep_id
--where emp.dep_id = 1001;

-- ITEM 5

