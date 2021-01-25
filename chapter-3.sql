create table eagle_watch (observed_date date, eagles_seen INTEGER);

create table char_data_types (
  varchar_column varchar(10),
  char_column char(10),
  text_column text
);

insert into char_data_types
values ('abc', 'abc', 'abc'),
  ('defghi', 'defghi', 'defghi');

copy char_data_types to '/tmp/typetest.txt' with (format csv, header, DELIMITER '|');

create table people (id serial, person_name varchar(100));

create table number_data_types (
  numeric_column numeric(20, 5),
  real_column real,
  double_column double precision
);

insert into number_data_types
values (.7,.7,.7),
  (2.13579, 2.13579, 2.13579),
  (2.1357987654, 2.1357987654, 2.1357987654);

select *
from number_data_types;

select numeric_column * 10000000 as "Fixed",
  real_column * 10000000 as "Float"
from number_data_types
where numeric_column =.7;

create table date_time_types (
  timestamp_column timestamp with time zone,
  interval_column interval
);

insert into date_time_types
values ('2018-12-31 01:00 EST', '2 days'),
  ('2018-12-31 01:00 -8', '1 month'),
  (
    '2018-12-31 01:00 Australia/Melbourne',
    '1 century'
  ),
  (now(), '1 week');

select *
from date_time_types;

select timestamp_column,
  interval_column,
  timestamp_column - interval_column as new_date
from date_time_types;

select timestamp_column,
  cast(timestamp_column as VARCHAR(10))
from date_time_types;

select numeric_column,
  cast(numeric_column as integer),
  cast(numeric_column as varchar(6))
from number_data_types;

select cast(char_column as INTEGER)
from char_data_types;

select timestamp_column,
  cast(timestamp_column as varchar(10))
from date_time_types;

select timestamp_column::varchar(10)
from date_time_types;

-- try it yourself
select '4//2017'::date;