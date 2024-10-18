-- Single Row Transaction


--\c hrms

-- selection
select * from manager;

-- projection
select id, trim(rpad(firstname, 20, '*')) as firstname, salary from manager;

-- SELECT CLAUSE

-- String functions

select id, initcap(firstname), length(firstname) as "firstname length"
from manager;

--CONCAT
--select id, concat(firstname, ' ', gender) as "firstname & gender"
--from manager;

select id, concat(firstname || ' ' || gender) as "firstname & gender"
from manager;

-- string converters (to_date and to_number)
select id, firstname || ' ' || gender as "firstname & gender"
from manager;

--select id, firstname, to_date('2010-10-10', 'YYYY-MM-DD')
--from manager;
select id, firstname, to_date('October 10, 2010', 'MONTH DD, YYYY')
from manager;

select id, firstname, to_number('9,999.333', '999G999D000')
from manager;

-- NUMBER FUNCTIONS
--salary double to char (casting with format)
select id, firstname, firstname || ' ' || gender || ' ' || to_char(salary, '999G999D000') 
		as "firstname & gender & salary"
from manager;

select id, firstname, rpad(to_char(salary, 'FM$999G999D000'), 15, '-') as salary
from manager;

--casting (as float/int/char/varchar(100)/text)
select id, firstname, CAST(salary + 1000.57815 as float) as "salary", 
		age::numeric(10, 2) as age, birthday::varchar(100) as birthday
from manager;

--rounding (use casting to numeric) -> forced casting
-- absolute value
select id, firstname, abs(round(CAST(salary + 1000.57815 as numeric (10, 2)))) as "salary", 
		age::numeric(10, 2) as age, birthday::varchar(100) as birthday
from manager;

-- TEMPORAL FUNCTIONS
select to_char(birthday, 'MONTH DD, YYYY') as birthday
from manager;

select date_part('year', birthday) as "birth year",
	   date_part('month', birthday) as "birth month",
	   date_part('day', birthday) as "birth date"
from manager;

select now() - birthday as "duration"
from manager;

--select birthday - INTERVAL '3 years 5 months 6 days' as difference
select birthday + INTERVAL '5 months 26 days' as difference
from manager;

select age(now(), birthday) as "duration with timestamp"
from manager;

select age(cast(now() as date), birthday) as "duration"
from manager;

-- temporal types are ok with conditional ops
select cast(now() as date) = birthday as "is now?"
from manager;

/*
create table stocks(
	id smallint not null primary key,
	commission float,
	rate float,
	amount float not null default 1.0
);
*/
/*
insert into stocks values(1, NULL, NULL, 10);
insert into stocks values(2, 500.00, 0.10, 10);
insert into stocks values(3, 2000.00, 0.20, 1000);
*/

-- VALIDATORS

--coalescing (if not null sa table, use this)
--common table expression
with stocks_cte as (
	select id, (amount + (coalesce(commission, 0.0) * coalesce(rate, 0.0))) as total_profit
	from stocks
)
select id, total_profit,
		case
			when total_profit > 1000.00 then 'WIN'
			when total_profit = 1000.00 then 'BREAKEVEN'
			else 'LUGI'
		end as "profit analysis"
from stocks_cte;

-- distinct 
-- first normal form (pk)
-- second normal form (fk)
-- di pwede magdistinct sa pk (id, etc.), sa columns lang na di pk
select distinct firstname
from manager;