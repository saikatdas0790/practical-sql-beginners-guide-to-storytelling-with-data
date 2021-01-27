create table departments (
  dept_id bigserial,
  dept varchar(100),
  city varchar(100),
  constraint dept_key primary key (dept_id),
  constraint dept_city_unique unique (dept, city)
);

create table employees (
  emp_id bigserial,
  first_name varchar(100),
  last_name varchar(100),
  salary integer,
  dept_id integer references departments (dept_id),
  constraint emp_key primary key (emp_id),
  constraint emp_dept_unique unique (emp_id, dept_id)
);

insert into departments (dept, city)
values ('Tax', 'Atlanta'),
  ('IT', 'Boston');

insert into employees (first_name, last_name, salary, dept_id)
values ('Nancy', 'Jones', 62500, 1),
  ('Lee', 'Smith', 59300, 1),
  ('Soo', 'Nguyen', 83000, 2),
  ('Janet', 'King', 95000, 2);

select *
from employees
  join departments on employees.dept_id = departments.dept_id;

create table schools_left (
  id integer constraint left_id_key primary key,
  left_school varchar(30)
);

create table schools_right (
  id integer constraint right_id_key primary key,
  right_school varchar(30)
);

insert into schools_left (id, left_school)
values (1, 'Oak Street School'),
  (2, 'Roosevelt High School'),
  (5, 'Washington Middle School'),
  (6, 'Jefferson High School');

insert into schools_right (id, right_school)
values (1, 'Oak Street School'),
  (2, 'Roosevelt High School'),
  (3, 'Morrison Elementary'),
  (4, 'Chase Magnet Academy'),
  (6, 'Jefferson High School');

select *
from schools_left
  join schools_right on schools_left.id = schools_right.id;

select *
from schools_left
  left join schools_right on schools_left.id = schools_right.id;

select *
from schools_left
  right join schools_right on schools_left.id = schools_right.id;

select *
from schools_left
  full outer join schools_right on schools_left.id = schools_right.id;

select *
from schools_left
  cross join schools_right;

select *
from schools_left
  left join schools_right on schools_left.id = schools_right.id
where schools_right.id is null;

select schools_left.id,
  schools_left.left_school,
  schools_right.right_school
from schools_left
  left join schools_right on schools_left.id = schools_right.id;

select lt.id,
  lt.left_school,
  rt.right_school
from schools_left as lt
  left join schools_right as rt on lt.id = rt.id;

create table schools_enrollment (id integer, enrollment integer);

create table schools_grades (id integer, grades varchar(10));

insert into schools_enrollment (id, enrollment)
values (1, 360),
  (2, 1001),
  (5, 450),
  (6, 927);

insert into schools_grades (id, grades)
values (1, 'K-3'),
  (2, '9-12'),
  (5, '6-8'),
  (6, '9-12');

select lt.id,
  lt.left_school,
  en.enrollment,
  gr.grades
from schools_left as lt
  left join schools_enrollment as en on lt.id = en.id
  left join schools_grades as gr on lt.id = gr.id;

create table us_counties_2000 (
  geo_name varchar(90),
  state_us_abbreviation varchar(2),
  state_fips varchar(2),
  county_fips varchar(3),
  p0010001 integer,
  p0010002 integer,
  p0010003 integer,
  p0010004 integer,
  p0010005 integer,
  p0010006 integer,
  p0010007 integer,
  p0010008 integer,
  p0010009 integer,
  p0010010 integer,
  p0020002 integer,
  p0020003 integer
);

copy us_counties_2000
from '/tmp/us_counties_2000.csv' with (format csv, header);

select c2010.geo_name,
  c2010.state_us_abbreviation as state,
  c2010.p0010001 as pop_2010,
  c2000.p0010001 as pop_2000,
  c2010.p0010001 - c2000.p0010001 as raw_change,
  round(
    (
      cast(c2010.p0010001 as numeric(8, 1)) - c2000.p0010001
    ) / c2000.p0010001 * 100,
    1
  ) as pct_change
from us_counties_2010 c2010
  inner join us_counties_2000 c2000 on c2010.state_fips = c2000.state_fips
  and c2010.county_fips = c2000.county_fips
  and c2010.p0010001 <> c2000.p0010001
order by pct_change desc;