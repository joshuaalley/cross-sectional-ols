/* Multiple Imputation */

drop if unvoting==.
drop if s_lead==. /* East Timor */

keep country ccode iraq_dum article98 unvoting $x $z1

mi set wide
mi register imputed $x lntrade lngdppc
set seed 29390
#delimit;
mi impute mvn $x lntrade lngdppc = 
	s_lead muslimpct nato aid_m aid_e icc afgh_dum unvoting article98 
	europe iraq_dum freedomhouse
	, add(20)  initmcmc(em, iterate(2000));
#delimit cr

mi est: $model iraq_dum  $x     , vce($vceoption)
mi est: $model iraq_dum  $x $z1 $nonnat, vce($vceoption)

mi est: $model article98 $x     , vce($vceoption)
mi est: $model article98 $x $z2 $nonnat, vce($vceoption)

mi est: reg   unvoting   $x     , vce($vceoption)
mi est: reg   unvoting   $x $z1 $nonnat, vce($vceoption)

mi xeq 0 1 20: sum x $z1

* Check wether regime-type interactions matter
gen x_free=$x*freedomhouse
mi est: $model iraq_dum  $x x_free $z1 $nonnat, vce($vceoption)
mi est: $model article98 $x x_free $z2 $nonnat, vce($vceoption)
mi est: reg    unvoting  $x x_free $z1 $nonnat, vce($vceoption)
