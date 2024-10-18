-- Data Manipulation Language (insert/create, delete, update)

--one/single form
--insert into manager
--values(101, 'Juan', 'M', 80, 60000.00, '1999-10-10');

--multiple insertion
/*
insert into manager
values (102, 'Maria', 'F', 80, 60000.00, '1999-10-10'),
	   (103, 'Hoshi', 'M', 40, 90000.00, '1996-06-15'),
	   (104, 'Won', 'M', 30, 90000.00, '1996-07-17')
*/
/*
insert into manager(birthday,  firstname, age, id, gender, salary)
values('2002-01-31', 'Shai', '22', '105', 'F', 55000.00);
*/

/*
insert into allowance
values (3, 3);
*/

-- Update records

update manager
set firstname = 'Caloy' where id = '101';

-- Upsert

insert into manager
values(101, 'Juan', 'M', 60, 10000.00, '1999-10-10')
on conflict(id)
--do nothing;
do update set age = 60, salary = 10000.00;

-- Delete

delete from manager where id = 101; --DML may commit and rollback
--truncate(manager) -- DDL no commit and rollback; wala talaga after madelete all

-- Transaction Management (Commit and Rollback) for parsing engine

--begin transaction;

--delete from manager;

--table manager;



	
end 