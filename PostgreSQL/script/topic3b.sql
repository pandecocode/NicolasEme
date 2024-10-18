-- where clause (sometimes called contrainst clause)

-- operations
-- + - * / = > >= < <= like ~ ! and or %
-- <> / not

select *
from manager
where salary > 100.00;

-- inclusive
select *
from manager
where salary between 60000.00 and 100000.00;

select *
from stocks
where commission is null;

select *
from stocks
where commission is not null or commission > 1000.00;

select *
from stocks 
where amount <= commission + 1000.00;

-- LIKE and NOT LIKE for string comparison

--M% starts with M; 
--M____ any word that starts with M and has 4 whitespace/special char/alphabet
--%h% any word that contains s in it
-- ~* not case sensitive
-- ~ similar to like
-- ^S starts with letter S; 
-- ^.e has e in second position
select *
from manager
where firstname like '%h%'; 

select *
from manager
where firstname ~ '[a-z]+';

select *
from manager
where not firstname ~ '[a-e]+';

--remove others that do not start with M
select *
from manager
where firstname ~ '^[^M]';

-- SORTING OF TABLE RECORDS
--virtual columns
select id, firstname, (salary + 10000.00) as "total bonus"
from manager
order by "total bonus" desc;

-- if there's a null, nasa dulo ng table
select id, coalesce(commission, 0.0) as commission from stocks order by commission;

-- FROM CLAUSE
-- table relationships
-- JOIN transactions

-- create table relationships

--1. Using simple references
/*
create table project(
	id smallint not null primary key,
	projName varchar(200) not null,
	projDate date not null
);

create table project_members(
	empid integer not null primary key,
	firstname varchar(60) not null,
	lastname varchar(60) not null,
	projid integer not null,
	foreign key (projid) references project(id) on delete cascade on update cascade
);
--foreign key nasa child (project_members); 
-- reference key nasa parent (project)
*/

/*
insert into project values (1, 'HRMS', '2024-11-11');
insert into project values (2, 'Credit Card App', '2025-03-25');
insert into project values (3, 'DTR', '2025-05-05');

insert into project_members values (101, 'Juan', 'Luna', 2);
insert into project_members values (102, 'Maria', 'Clara', 2);
insert into project_members values (103, 'Jose', 'Rizal', 1);
insert into project_members values (104, 'Apo', 'Mabini', 3);
*/

--insert into project values (4, 'Scanner System', '2025-05-05');

--INNER JOIN
--table alias dont put "as", deretso na

select *
from project a right join project_members b
on a.projid = b.projid;
--where a.id = 1;

-- SELF JOIN
select a.id, a.firstname, b.id, b.firstname
from manager a inner join manager b 
on a.id = b.supervisor;

-- CROSS JOIN (do not use in enterprise)
select *
from project, project_members;

-- NATURAL JOIN (may fields na same name, so parang shortcut ng inner join lang)
select *
from project a natural join project_members b;
