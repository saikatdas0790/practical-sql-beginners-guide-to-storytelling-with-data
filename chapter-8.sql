create table pls_fy2014_pupld14a (
  stabr varchar(2) not null,
  fscskey varchar(6) constraint fscskey2014_key primary key,
  libid varchar(20) not null,
  libname varchar(100) not null,
  obereg varchar(2) not null,
  rstatus integer not null,
  statstru varchar(2) not null,
  statname varchar(2) not null,
  stataddr varchar(2) not null,
  longitud numeric(10, 7) not null,
  latitude numeric(10, 7) not null,
  fipsst varchar(2) not null,
  fipsco varchar(3) not null,
  address varchar(35) not null,
  city varchar(20) not null,
  zip varchar(5) not null,
  zip4 varchar(4) not null,
  cnty varchar(20) not null,
  phone varchar(10) not null,
  c_relatn varchar(2) not null,
  c_legbas varchar(2) not null,
  c_admin varchar(2) not null,
  geocode varchar(3) not null,
  lsabound varchar(1) not null,
  startdat varchar(10),
  enddate varchar(10),
  popu_lsa integer not null,
  centlib integer not null,
  branlib integer not null,
  bkmob integer not null,
  master numeric(8, 2) not null,
  libraria numeric(8, 2) not null,
  totstaff numeric(8, 2) not null,
  locgvt integer not null,
  stgvt integer not null,
  fedgvt integer not null,
  totincm integer not null,
  salaries integer,
  benefit integer,
  staffexp integer,
  prmatexp integer not null,
  elmatexp integer not null,
  totexpco integer not null,
  totopexp integer not null,
  lcap_rev integer not null,
  scap_rev integer not null,
  fcap_rev integer not null,
  cap_rev integer not null,
  capital integer not null,
  bkvol integer not null,
  ebook integer not null,
  audio_ph integer not null,
  audio_dl float not null,
  video_ph integer not null,
  video_dl float not null,
  databases integer not null,
  subscrip integer not null,
  hrs_open integer not null,
  visits integer not null,
  referenc integer not null,
  regbor integer not null,
  totcir integer not null,
  kidcircl integer not null,
  elmatcir integer not null,
  loanto integer not null,
  loanfm integer not null,
  totpro integer not null,
  totatten integer not null,
  gpterms integer not null,
  pitusr integer not null,
  wifisess integer not null,
  yr_sub integer not null
);

create index libname2014_idx on pls_fy2014_pupld14a (libname);

create index stabr2014_idx on pls_fy2014_pupld14a (stabr);

create index city2014_idx on pls_fy2014_pupld14a (city);

create index visits2014_idx on pls_fy2014_pupld14a (visits);

COPY pls_fy2014_pupld14a
from '/tmp/pls_fy2014_pupld14a.csv' with (FORMAT CSV, HEADER);

create table pls_fy2009_pupld09a (
  stabr varchar(2) not null,
  fscskey varchar(6) constraint fscskey2009_key primary key,
  libid varchar(20) not null,
  libname varchar(100) not null,
  address varchar(35) not null,
  city varchar(20) not null,
  zip varchar(5) not null,
  zip4 varchar(4) not null,
  cnty varchar(20) not null,
  phone varchar(10) not null,
  c_relatn varchar(2) not null,
  c_legbas varchar(2) not null,
  c_admin varchar(2) not null,
  geocode varchar(3) not null,
  lsabound varchar(1) not null,
  startdat varchar(10),
  enddate varchar(10),
  popu_lsa integer not null,
  centlib integer not null,
  branlib integer not null,
  bkmob integer not null,
  master numeric(8, 2) not null,
  libraria numeric(8, 2) not null,
  totstaff numeric(8, 2) not null,
  locgvt integer not null,
  stgvt integer not null,
  fedgvt integer not null,
  totincm integer not null,
  salaries integer,
  benefit integer,
  staffexp integer,
  prmatexp integer not null,
  elmatexp integer not null,
  totexpco integer not null,
  totopexp integer not null,
  lcap_rev integer not null,
  scap_rev integer not null,
  fcap_rev integer not null,
  cap_rev integer not null,
  capital integer not null,
  bkvol integer not null,
  ebook integer not null,
  audio integer not null,
  video integer not null,
  databases integer not null,
  subscrip integer not null,
  hrs_open integer not null,
  visits integer not null,
  referenc integer not null,
  regbor integer not null,
  totcir integer not null,
  kidcircl integer not null,
  loanto integer not null,
  loanfm integer not null,
  totpro integer not null,
  totatten integer not null,
  gpterms integer not null,
  pitusr integer not null,
  yr_sub integer not null,
  obereg varchar(2) not null,
  rstatus integer not null,
  statstru varchar(2) not null,
  statname varchar(2) not null,
  stataddr varchar(2) not null,
  longitud numeric(10, 7) not null,
  latitude numeric(10, 7) not null,
  fipsst varchar(2) not null,
  fipsco varchar(3) not null
);

create index libname2009_idx on pls_fy2009_pupld09a (libname);

create index stabr2009_idx on pls_fy2009_pupld09a (stabr);

create index city2009_idx on pls_fy2009_pupld09a (city);

create index visits2009_idx on pls_fy2009_pupld09a (visits);

COPY pls_fy2009_pupld09a
from '/tmp/pls_fy2009_pupld09a.csv' with (FORMAT CSV, HEADER);

select count(*)
from pls_fy2014_pupld14a;

select count(*)
from pls_fy2009_pupld09a;

select count(salaries)
from pls_fy2014_pupld14a;

select count(libname)
from pls_fy2014_pupld14a;

select count(distinct libname)
from pls_fy2014_pupld14a;

select libname,
  count(libname)
from pls_fy2014_pupld14a
group by libname
order by count(libname) desc;

select libname,
  city,
  stabr
from pls_fy2014_pupld14a
where libname = 'OXFORD PUBLIC LIBRARY';

select max(visits),
  min(visits)
from pls_fy2014_pupld14a;

select stabr
from pls_fy2014_pupld14a
group by stabr
order by stabr;

select stabr
from pls_fy2009_pupld09a
group by stabr
order by stabr;

select city,
  stabr
from pls_fy2014_pupld14a
group by city,
  stabr
order by city,
  stabr;

select city,
  stabr,
  count(*)
from pls_fy2014_pupld14a
group by city,
  stabr
order by count(*) desc;

select stabr,
  count(*)
from pls_fy2014_pupld14a
group by stabr
order by count(*) desc;

select stabr,
  stataddr,
  count(*)
from pls_fy2014_pupld14a
group by stabr,
  stataddr
order by stabr asc,
  count(*) desc;

select sum(visits) as visits_2014
from pls_fy2014_pupld14a
where visits >= 0;

select sum(visits) as visits_2009
from pls_fy2009_pupld09a
where visits >= 0;

select sum(pls14.visits) as visits_2014,
  sum(pls09.visits) as visits_2009
from pls_fy2014_pupld14a pls14
  join pls_fy2009_pupld09a pls09 on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0
  and pls09.visits >= 0;

select pls14.stabr,
  sum(pls14.visits) as visits_2014,
  sum(pls09.visits) as visits_2009,
  round(
    (
      CAST(sum(pls14.visits) as decimal(10, 1)) - sum(pls09.visits)
    ) / sum(pls09.visits) * 100,
    2
  ) as pct_change
from pls_fy2014_pupld14a pls14
  join pls_fy2009_pupld09a pls09 on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0
  and pls09.visits >= 0
group by pls14.stabr
order by pct_change desc;

select pls14.stabr,
  sum(pls14.visits) as visits_2014,
  sum(pls09.visits) as visits_2009,
  round(
    (
      CAST(sum(pls14.visits) as decimal(10, 1)) - sum(pls09.visits)
    ) / sum(pls09.visits) * 100,
    2
  ) as pct_change
from pls_fy2014_pupld14a pls14
  join pls_fy2009_pupld09a pls09 on pls14.fscskey = pls09.fscskey
where pls14.visits >= 0
  and pls09.visits >= 0
group by pls14.stabr
having sum(pls14.visits) > 50000000
order by pct_change desc;