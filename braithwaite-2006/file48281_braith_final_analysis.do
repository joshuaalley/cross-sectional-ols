version 7.0
log using "C:\My Documents\Alex\JPR\braith_jpr_RR.log", replace  
#delimit;
set more off;
***********************************************************;
* Braith (Nov 1st, 2005) For JPR: the geog spread of mids *;
***********************************************************;

cd "C:\My Documents\Alex\JPR\";
set mem 100m;
set matsize 100;
use final_data.dta;

summ; 
corr logcap_ratio allies joint_democ territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource incidents logdurat final_hostile;
;


********************;
*Specific day one models*;
reg log_radius_area territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, robust;
vif;
hettest;
tobit log_radius_area territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, ll(0);

*models with dyadic controls*;
reg log_radius_area logcap_ratio allies joint_democ territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, robust;
vif;
hettest;
tobit log_radius_area logcap_ratio allies joint_democ territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, ll(0);

*models without dyadic and with post-hoc*;
reg log_radius_area incidents logdurat final_hostile territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, robust;
vif;
hettest;
tobit log_radius_area incidents logdurat final_hostile territory logsize  host_mt host_for water cwpceyrs bord_vital  host_resource   if final_hostile>0, ll(0);

save "C:\My Documents\Alex\JPR\final_data.dta", replace ;
exit, clear;
