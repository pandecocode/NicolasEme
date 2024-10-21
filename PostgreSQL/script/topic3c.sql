--Multiple Row Transactions

--GROUP BY
/* **stratification
wag mag-group by using PK and unique
numerical range -> kasi di predictable / arbitrary 
 */

--yung stratified column will appear in group by, bawal concat
select gender
from manager
group by gender;

--aggregates -> for data analysis
select gender, count(gender), avg(salary)
from manager
group by gender;

select gender, count(gender), avg(salary) as "average salary per gender"
from manager
group by gender;

select gender, supervisor, count(gender), avg(salary) as "average salary per gender"
from manager
group by gender, supervisor;
--gender and supervisor are both ok with stratification

select gender, supervisor, count(gender), avg(salary) as "average salary per gender", min(age), max(age), sum(salary)
from manager
group by gender, supervisor;

--standard deviation
select gender, stddev (salary)
from manager
group by gender;

--std and variance
select gender, stddev (salary), variance(salary)
from manager
group by gender;

--yung field na hindi oks for strata, pwede naman i-analyze lang

--generic strata, break it down to more specific ones

-- HAVING
select gender, stddev(salary), variance(salary)
from manager
group by gender
having stddev(salary) > 20000.00;

--if may alias
select gender, stddev(salary) as standard_dev, variance(salary)
from manager
group by gender
having stddev(salary) > 20000.00;

--IN clause
select gender, stddev(salary), variance(salary)
from manager
group by gender
having stddev(salary) in (10000.00, 20000.00);

--BETWEEN clause
select gender, stddev(salary), variance(salary)
from manager
group by gender
having stddev(salary) between 10000.00 and 20000.00;

--WHERE clause
select gender, stddev(salary), variance(salary)
from manager
where salary <= 10000.00
group by gender
having stddev(salary) between 10000.00 and 20000.00;

--COALESCE
select gender, coalesce(stddev(salary), 0.0), coalesce(variance(salary), 0.0)
from manager
where salary > 10000.00
group by gender;

--HAVING AND GROUP BY
select gender, coalesce(stddev(salary), 0.0), coalesce(variance(salary), 0.0)
from manager
where salary > 10000.00
group by gender
having stddev(salary) between 10000.00 and 20000.00;

--ORDER BY (Multiple columns)
select gender, supervisor
from manager
group by gender, supervisor
order by gender, supervisor;

select gender, coalesce(stddev(salary), 0.0), coalesce(variance(salary), 0.0)
from manager
where salary > 10000.00
group by gender
having stddev(salary) between 10000.00 and 20000.00
order by gender;

--DATA ANALYSIS WITH SORTING
--desc one strata, asc naman other strata
select gender, supervisor
from manager
group by gender, supervisor
order by gender DESC, supervisor;

