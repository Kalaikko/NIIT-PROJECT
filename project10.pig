--10) Which are the  job positions along with the number of petitions which have the success rate more than 70%  in petitions (total petitions filed 1000 OR more than 1000)?
h1b = load '/user/hive/warehouse/niit.db/h1b_final/*' using PigStorage('\t') as (sno:int, case_status:chararray, emp_name:chararray, soc_name:chararray, job_title:chararray, full_time_pos:chararray,wage:long, year:chararray, worksite:chararray, longitude:double, lattitude:double);

grp = group h1b by $4;
total = foreach grp generate group, COUNT(h1b.$1);
--dump total;

h1b_filter = filter h1b by case_status == 'CERTIFIED' or case_status == 'CERTIFIED-WITHDRAWN';
grp = group h1b_filter by $4;
certified = foreach grp generate group, COUNT(h1b_filter.$1);
--dump case_count;

--h1b_filter = filter h1b by case_status == 'CERTIFIED-WITHDRAWN';
--grp = group h1b_filter by $4;
--certified_withdrawn = foreach grp generate group, COUNT(h1b_filter.$1);

emp_join = join certified by $0, total by $0;
emp_join = foreach emp_join generate $0,$1,$3;
success = foreach emp_join generate $0,(float)$1/$2*100, $2;
--dump emp_join;
final = filter success by $1>70 and $2>=1000;
--dump final;
store final into '/niit/project10'; 
