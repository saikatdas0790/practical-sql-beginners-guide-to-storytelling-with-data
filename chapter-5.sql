select 2 + 2;

select 9 - 1;

select 3 * 4;

select 11 / 6;

select 11 % 6;

select 11.0 / 6;

select cast (11 as numeric(3, 1)) / 6;

select 3 ^ 4;

select |/ 10;

select sqrt(10);

select ||/ 10;

select 4 !;

select 7 + 8 * 9;

select (7 + 8) * 9;

select 3 ^ 3 - 1;

select 3 ^ (3 - 1);

select geo_name,
  state_us_abbreviation as "st",
  p0010001 as "Total Population",
  p0010003 as "White Alone",
  p0010004 as "Black or African American Alone",
  p0010005 as "Am Indian/Alaska Native Alone",
  p0010006 as "Asian Alone",
  p0010007 as "Native Hawaiian and Other Pacific Islander Alone",
  p0010008 as "Some Other Race Alone",
  p0010009 as "Two or More Races"
from us_counties_2010;

select geo_name,
  state_us_abbreviation as "st",
  p0010003 as "White Alone",
  p0010004 as "Black Alone",
  p0010003 + p0010004 as "Total White and Black"
from us_counties_2010;

select geo_name,
  state_us_abbreviation as "st",
  p0010001 as "Total",
  p0010003 + p0010004 + p0010005 + p0010006 + p0010007 + p0010008 + p0010009 as "All Races",
  (
    p0010003 + p0010004 + p0010005 + p0010006 + p0010007 + p0010008 + p0010009
  ) - p0010001 as "Difference"
from us_counties_2010
order by "Difference" desc;

select geo_name,
  state_us_abbreviation as "st",
  (cast(p0010006 as numeric(8, 1)) / p0010001) * 100 as "pct_asian"
from us_counties_2010
order by "pct_asian" desc;

create table percent_change (
  department varchar(20),
  spend_2014 numeric(10, 2),
  spend_2017 numeric(10, 2)
);

insert into percent_change
values ('Building', 250000, 289000),
  ('Assessor', 178556, 179500),
  ('Library', 87777, 90001),
  ('Clerk', 451980, 650000),
  ('Police', 250000, 223000),
  ('Recreation', 199000, 195000);

select department,
  spend_2014,
  spend_2017,
  round((spend_2017 - spend_2014) / spend_2014 * 100, 1) as "pct_change"
from percent_change;

select sum(p0010001) as "County Sum",
  round(avg(p0010001), 0) as "County Average"
from us_counties_2010;

create table percentile_test (numbers integer);

insert into percentile_test (numbers)
values (1),
  (2),
  (3),
  (4),
  (5),
  (6);

select percentile_cont(.5) within group (
    order by numbers
  ),
  percentile_disc(.5) within group (
    order by numbers
  )
from percentile_test;

select sum(p0010001) as "County Sum",
  round(avg(p0010001), 0) as "County Average",
  percentile_cont(.5) within group (
    order by p0010001
  ) as "County Median"
from us_counties_2010;

select percentile_cont(array [.25, .5, .75]) within group (
    order by p0010001
  ) as "quartiles"
from us_counties_2010;

select unnest(
    percentile_cont(array [.25, .5, .75]) within group (
      order by p0010001
    )
  ) as "quartiles"
from us_counties_2010;

create or replace function _final_median(anyarray) returns float8 as $$ with q as (
    select val
    from unnest($1) val
    where val is not null
    order by 1
  ),
  cnt as (
    select count(*) as c
    from q
  )
select avg(val)::float8
from (
    select val
    from q
    limit 2 - mod(
        (
          select c
          from cnt
        ),
        2
      ) offset greatest(
        ceil(
          (
            select c
            from cnt
          ) / 2.0
        ) - 1,
        0
      )
  ) q2;

$$ language sql immutable;

create aggregate median(anyelement) (
  sfunc = array_append,
  stype = anyarray,
  finalfunc = _final_median,
  initcond = '{}'
);

select sum(p0010001) as "County Sum",
  round(avg(p0010001), 0) as "County Average",
  median(p0010001) as "County Median",
  percentile_cont(.5) within group (
    order by p0010001
  ) as "50th Percentile"
from us_counties_2010;

select mode() within group (
    order by p0010001
  )
from us_counties_2010;