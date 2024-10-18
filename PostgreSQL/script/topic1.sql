-- Single comment


/*
 
This is a block comment.

*/

-- select 'Hello World';

-- Data Definition Language (DDL)
-- Operations for creating schema: table, database, view, sp, sf, ds, truncate


--create database hrms;
--drop database hrms;

--always connect (not in postgres (default))
--\c hrms 

/*
create table manager(
	id integer not null primary key, --integer -> 11 digits max
	firstname varchar(100) not null,
	gender char(1) not null default 'F', --fixed size
	age integer not null check (age >= 0), --constraint
	salary float not null, --may float 16 32 etc.
	birthday date not null check (birthday > '1920-01-01')
);
*/
/*
create table data_types(
-- integer types
		age smallint not null, --> short
		empId int not null,
		popSize bigint not null, --> long
		counter int2 not null,
-- float or real types
		salary double precision not null,
		account_amount real not null, -->twice the size of double precision
		donation decimal not null, -->exact (sample 3000 lahat)
		mortgage numeric(10,3) not null, -->like totaldigits sa xsd (numofdigits, decimalplaces)
-- text-based
		nickname char(10) not null,
		position varchar(200) not null,
		comment text not null,
-- boolean
		isEmployed boolean not null, -->can be bool/boolean
-- temporal types
		timeIn time not null, -->24H format
		birthday date not null,
		dateResigned timestamp not null,
		moneyTxDate timestamptz not null,
-- auto_increment or with sequence
		id serial not null,
-- monetary
		amount money not null,
-- binary types (medyo related sa boolean)
		isTurnOff bit not null,
		picture bytea not null
);
*/
--drop table data_types;


/*
create table developer(
	id serial not null primary key,
	empId integer not null unique,
	devId integer references manager(id) --reference key/foreign key
);
*/



-- Altering table
/*
alter table developer
add column firstname varchar(100) not null default '';

alter table developer
drop column firstname;
*/
--alter table developer
--alter column empid type smallint;

--minor alteration
--alter table developer
--rename column empid to employeedId;
/*
alter table developer
alter column devId set default 1;

alter table developer
alter column devId set not null;

alter table data_types
add constraint empid unique(empid);

alter table developer
add constraint devId check (devId >= 1);
*/

/*
-- Data entry rules --
create table insurance(
	policyid integer not null,
	id serial not null,
	primary key(policyId, id)
);
*/

--good tandem; unique composition
create table allowance(
	allowanceId integer not null primary key,
	id serial not null unique
);



