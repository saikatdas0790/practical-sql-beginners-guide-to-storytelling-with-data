create table natural_key_example (
  license_id varchar(10) constraint license_key primary key,
  first_name varchar(50),
  last_name varchar(50)
);

drop table natural_key_example;

create table natural_key_example (
  license_id varchar(10),
  first_name varchar(50),
  last_name varchar(50),
  constraint license_key primary key (license_id)
);

insert into natural_key_example (license_id, first_name, last_name)
values ('T229901', 'Lynn', 'Malero');

insert into natural_key_example (license_id, first_name, last_name)
values ('T229901', 'Sam', 'Tracy');

create table natural_key_composite_example (
  student_id varchar(10),
  school_day date,
  present boolean,
  constraint student_key primary key (student_id, school_day)
);

insert into natural_key_composite_example (student_id, school_day, present)
values(775, '1/22/2017', 'Y');

insert into natural_key_composite_example (student_id, school_day, present)
values(775, '1/23/2017', 'Y');

insert into natural_key_composite_example (student_id, school_day, present)
values(775, '1/23/2017', 'N');

create table surrogate_key_example (
  order_number bigserial,
  product_name varchar(50),
  order_date date,
  constraint order_key primary key (order_number)
);

insert into surrogate_key_example (product_name, order_date)
values ('Beachball Polish', '2015-03-17'),
  ('Wrinkle De-Atomizer', '2017-05-22'),
  ('Flux Capacitor', '1985-10-26');

select *
from surrogate_key_example;

create table licenses (
  license_id varchar(10),
  first_name varchar(50),
  last_name varchar(50),
  constraint licenses_key primary key (license_id)
);

create table registrations (
  registration_id varchar(10),
  registration_date date,
  license_id varchar(10) references licenses (license_id),
  constraint registration_key primary key (registration_id, license_id)
);

insert into licenses (license_id, first_name, last_name)
values ('T229901', 'Lynn', 'Malero');

insert into registrations (registration_id, registration_date, license_id)
values ('A203391', '3/17/2017', 'T229901');

insert into registrations (registration_id, registration_date, license_id)
values ('A75772', '3/17/2017', 'T000001');

create table registrations (
  registration_id varchar(10),
  registration_date date,
  license_id varchar(10) references licenses (license_id) on delete cascade,
  constraint registration_key primary key (registration_id, license_id)
);

create table check_constraint_example (
  user_id bigserial,
  user_role varchar(50),
  salary integer,
  constraint user_id_key primary key (user_id),
  constraint check_role_in_list check (user_role in ('Admin', 'Staff')),
  constraint check_salary_not_zero check (salary > 0)
);

create table unique_constraint_example (
  contact_id bigserial constraint contact_id_key primary key,
  first_name varchar(50),
  last_name varchar(50),
  email varchar(200),
  constraint email_unique unique (email)
);

insert into unique_constraint_example (first_name, last_name, email)
values ('Samantha', 'Lee', 'slee@example.org');

insert into unique_constraint_example (first_name, last_name, email)
values ('Betty', 'Diaz', 'bdiaz@example.org');

insert into unique_constraint_example (first_name, last_name, email)
values ('Sasha', 'Lee', 'slee@example.org');

create table not_null_example (
  student_id bigserial,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  constraint student_id_key primary key (student_id)
);

alter table not_null_example drop constraint student_id_key;

alter table not_null_example
add constraint student_id_key primary key (student_id);

alter table not_null_example
alter column first_name drop not null;

alter table not_null_example
alter column first_name
set not null;

create table new_york_addresses (
  longitude numeric(9, 6),
  latitude numeric(9, 6),
  street_number varchar(10),
  street varchar(32),
  unit varchar(7),
  postcode varchar(5),
  id integer constraint new_york_key primary key
);

copy new_york_addresses
from '/tmp/city_of_new_york.csv' with (format csv, header);

explain analyze
select *
from new_york_addresses
where street = 'BROADWAY';

explain analyze
select *
from new_york_addresses
where street = '52 STREET';

explain analyze
select *
from new_york_addresses
where street = 'ZWICKY AVENUE';

create index street_idx on new_york_addresses (street);

explain analyze
select *
from new_york_addresses
where street = 'BROADWAY';

explain analyze
select *
from new_york_addresses
where street = '52 STREET';

explain analyze
select *
from new_york_addresses
where street = 'ZWICKY AVENUE';