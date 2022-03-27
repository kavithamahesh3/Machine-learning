-- Stock Market Analysis
-- Dropping existing schema if any
drop schema assignment;
-- Creating new schema
create schema Assignment;
-- Using the schema
use Assignment;
-- Assuming all excel files are in the required path, creating tables
-- Crreating table bajaj1
create table bajaj1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`bajaj auto`;

-- Creating table eicher1
create table eicher1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`eicher motors`;

-- Creating table tcs1
create table tcs1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`tcs`;

-- Creating table infosys1
create table infosys1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`infosys`;

-- Creating table hero1
create table hero1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`hero motocorp`;

-- Creting table tvs1
create table tvs1(CONSTRAINT PK_date PRIMARY KEY (date))
as
SELECT str_to_date(date,"%d-%M-%Y") as `Date`, `close price` as `Close Price`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 19 preceding and current row) as `20 Day MA`,
avg(`close price`) over (order by str_to_date(date,"%d-%M-%Y") rows between 49 preceding and current row) as `50 Day MA`
FROM Assignment.`tvs motors`;

-- Creating master table involving stock price of all tables
create table master_table as 
select b.date as `Date`, b.`Close Price` as `Bajaj`, tc.`Close Price` as `TCS`,tv.`Close Price` as `TVS`,i.`Close Price` as `Infosys`,e.`Close Price` as `Eicher`,h.`Close Price` as `Hero`
from bajaj1 b  inner join tcs1 tc 
on tc.date = b.date
inner join tvs1 tv on tv.date = tc.date
inner join infosys1 i on i.date = tv.date
inner join eicher1 e on e.date = i.date
inner join hero1 h on h.date = e.date;

-- Using tables created till now (named 1 to create tables with signals)
-- Creating table bajaj2 using bajaj1
create table bajaj2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.bajaj1;

-- Creating table eicher2 using eicher1
create table eicher2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.eicher1;

--Creating table tcs2 using tcs1
create table tcs2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.tcs1;

-- Creating table infosys2 from infosys1
create table infosys2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.infosys1;

-- Creating table hero2 from hero1
create table hero2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.hero1;

-- Creating taable tvs2 from tvs1
create table tvs2 as 
SELECT `Date`, `Close Price`,
case 
        WHEN `20 Day MA` > `50 Day MA` AND LAG(`20 Day MA`) over() < LAG(`50 Day MA`) over() THEN 'BUY'
		WHEN `20 Day MA` < `50 Day MA` AND LAG(`20 Day MA`) over() > LAG(`50 Day MA`) over() THEN 'SELL'
		ELSE 'HOLD' 
end as `Signal`
FROM Assignment.tvs1;

-- Creating an user defined function that takes the date as input and returns the signal
-- Dropping if the function name already exists
DROP function IF EXISTS Assignment.signalFun;

-- Creating the function 
delimiter $$
create function signalFun ( given_date varchar(10) )
returns varchar(4)
deterministic
begin
declare signal_value varchar(4);
select `Signal` into sigvalue from bajaj2 where date=STR_TO_DATE(given_date, "%Y-%m-%d");
return sigvalue;
end$$ 
-- Reseting the delimiter value 
delimiter ;
