--8) Find the average Prevailing Wage for each Job for each Year (take part time and full time separate). Arrange the output in descending order - [Certified and Certified Withdrawn.]

h1b = load '/user/hive/warehouse/niit.db/h1b_final/*' using PigStorage('\t') as (sno:int, case_status:chararray, emp_name:chararray, soc_name:chararray, job_title:chararray, full_time_pos:chararray, wage:long, year:chararray, worksite:chararray, longitude:double, lattitude:double);
h1b = filter h1b by case_status == 'CERTIFIED' or case_status == 'CERTIFIED-WITHDRAWN';
h1b_y = filter h1b by $5=='N';
y_avg = group h1b_y by ($7,$4);
final_y = foreach y_avg generate flatten(group),  AVG(h1b_y.$6);
--dump final;
f11 = filter final_y by $0=='2011';
f11 = order f11 by $2 desc;
f12 = filter final_y by $0=='2012';
f12 = order f12 by $2 desc;
f13 = filter final_y by $0=='2013';
f13 = order f13 by $2 desc;
f14 = filter final_y by $0=='2014';
f14 = order f14 by $2 desc;
f15 = filter final_y by $0=='2015';
f15 = order f15 by $2 desc;
f16 = filter final_y by $0=='2016';
f16 = order f16 by $2 desc;
fyes = union f11,f12,f13,f14,f15,f16;
store fyes into '/niit/project8n';


