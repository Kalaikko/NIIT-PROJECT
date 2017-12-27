--1b) Find top 5 job titles who are having highest avg growth in applications.
h1b = load '/user/hive/warehouse/niit.db/h1b_final/*' using PigStorage('\t') as (sno:int, case_status:chararray, emp_name:chararray, soc_name:chararray, job_title:chararray, full_time_pos:chararray,wage:long, year:chararray, worksite:chararray, longitude:double, lattitude:double);

h1b1 = filter h1b by year=='2011';
grp1 = group h1b1 by $4;
tot1 = foreach grp1 generate group, COUNT(h1b1.$1);
--dump tot1;

h1b1 = filter h1b by year=='2012';
grp1 = group h1b1 by $4;
tot2 = foreach grp1 generate group, COUNT(h1b1.$1);

h1b1 = filter h1b by year=='2013';
grp1 = group h1b1 by $4;
tot3 = foreach grp1 generate group, COUNT(h1b1.$1);

h1b1 = filter h1b by year=='2014';
grp1 = group h1b1 by $4;
tot4 = foreach grp1 generate group, COUNT(h1b1.$1);

h1b1 = filter h1b by year=='2015';
grp1 = group h1b1 by $4;
tot5 = foreach grp1 generate group, COUNT(h1b1.$1);

h1b1 = filter h1b by year=='2016';
grp1 = group h1b1 by $4;
tot6 = foreach grp1 generate group, COUNT(h1b1.$1);

total = join tot1 by $0,tot2 by $0,tot3 by $0,tot4 by $0,tot5 by $0,tot6 by $0;
total = foreach total generate $0,$1,$3,$5,$7,$9,$11;
--dump total;

growth = foreach total generate $0,(float)($2-$1)*100/$1,(float)($3-$2)*100/$2,(float)($4-$3)*100/$3,(float)($5-$4)*100/$4,(float)($6-$5)*100/$5;
--dump growth;
avg_growth = foreach growth generate $0,($1+$2+$3+$4+$5)/5;
orderbydesc = limit(order avg_growth by $1 desc) 5;
--dump orderbydesc;
store orderbydesc into '/niit/project1b';

