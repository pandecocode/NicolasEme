-- Aut increment

--Scenario 1
--create sequence manager_id_seq;

--alter table manager
--alter column id set default nextval('manager_id_seq');

--Scenario 2
--create sequence utility_id_seq; -- ito or 
/*
create sequence utility_id_seq start 10;
create table utility(
	id integer not null primary key default nextval('utility_id_seq'),
	fullname varchar(100) not null
);
*/

/*
create table administrator(
	id integer not null primary key default nextval ('utility_id_seq'),
	fullname varchar(100) not null,
	role varchar(100) not null
);
*/

--subquery (kahit di nakajoin ok lang)

/*
select *
from manager
where supervisor in (
	select supervisor
	from manager
	where supervisor > 0
);
*/

/*
-- CTE (common table expression)
with statistics as (
	select gender, stddev(salary) "standard deviation", 
		   min(salary) as minimum, max(salary) as maximum
	from manager
	group by gender
)
select * from statistics;
*/

--MERGING OF RECORDS: UNION

--similar/related tables yung sa union/pag-integrate ng rows
/* cmd:
insert into utility(fullname)
values('James Reid');
insert into administrator(fullname, role)
values ('John Chua', 'CEO');

select id, fullname
from utility
union
select id, fullname
from administrator
where fullname like '%e%';

select id, fullname
from utility
union
select id, role
from administrator
where fullname like '%S%';

select id, fullname
from utility
union
select id, role
from administrator
where fullname like '%S%'
order by 1;

-- 2 where clauses
select age, firstname
from manager
where age >= 34
union
select id, fullname
from utility
where fullname like '%e%';

-- INTERSECT

select age, firstname
from manager
intersect
select id, fullname
from utility;

-- EXCEPT (minus)

select age, firstname
from manager
except
select id, fullname
from utility;
--always nasa dulo order by

-- VIEW
create view project_data_view as
select *
from project a natural join project_members b;
--CREATE VIEW

\dv

create or replace view project_data_view as
select *
from project a natural join project_members b;
--CREATE VIEW

-- SP: STORED PROCEDURE (ideally: create or replace)
/* oks lang if may () sa ngayon but if walang param wag na ()
 */

create or replace procedure helloworld()language plpgsql as$$begin    raise notice 'hello world';end;$$;


create or replace procedure insert_project_count_sp(id integer, pname varchar(100), pdate date, INOUT rcount integer)
language plpgsql as
$$
begin
	insert into project
	values(id, pname, pdate);
	 select count(*) into rcount from manager;
end;
$$;

call insert_project_count_sp(5, 'E-Cart System', '2026-10-10', 0);

create or replace procedure increase_salary_sp(inc_salary float, id integer)
language plpgsql as
$$
declare
    total float := 0.0;
begin
    update manager
    set salary = salary + inc_salary where id = id;
    select salary into total from manager where id = id;
    raise notice 'New Salary %', total;
end;
$$;

*/

/*
create or replace procedure increase_salary_sp(inc_salary float, idLcl integer)
language plpgsql as
$$
declare
    total float := 0.0;
begin
    update manager
    set salary = salary + inc_salary where id = idLcl;
    select salary into total from manager where id = idLcl;
    raise notice 'New Salary %', total;
end;
$$;
*/
--call increase_salary_sp(10000.00, 102);

--perform is to loop

create or replace procedure show_projects_join_count_sp()
language plpgsql as
$$
declare
	proj_count integer := 0;
	rec record;
begin
	for rec in select * from project natural join project_members
		loop
			raise notice '% % %', rec.projid, rec.projname, rec.projdate;
	end loop;
	select count(*) into proj_count from project natural join project_members;
	raise notice 'Total join records: %', proj_count;
end;
$$;




