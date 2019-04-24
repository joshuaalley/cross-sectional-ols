/* Regression Analysis */

clear
set more off
cd "C:\Users\quanli\Desktop\Dropbox\teaching\309spring2013\data\Goldsmith"
global date 2011-07-26
use data_$date

* Make some new variables 
gen iraq_dum=(troops_iraq>0)
gen afgh_dum=(troops_afgh>0)
gen freedomhouse=(pr+cl)

* Average of VOP2002, PreIraq, and PostIraq
egen positive_A=rowmean(pos1 pos2 pos3)
egen negative_A=rowmean(neg1 neg2 neg3)
gen nonnat_A=(nonnat1+nonnat2+nonnat3==1)

* Average of VOP2002, and PreIraq [ROBUSTNESS CHECK]
egen positive_B=rowmean(pos1 pos2)
egen negative_B=rowmean(neg1 neg2)
gen nonnat_B=(nonnat1+nonnat2==1)

* PostIraq [ROBUSTNESS CHECK]
gen positive_C=pos3
gen negative_C=neg3
gen nonnat_C=(nonnat3==1)

* VOP2002 [ROBUSTNESS CHECK]
gen positive_D=pos1
gen negative_D=neg1
gen nonnat_D=(nonnat1==1)

gen x_A    =(positive_A-negative_A)/100
gen x_B    =(positive_B-negative_B)/100
gen x_C    =(positive_C-negative_C)/100
gen x_D    =(positive_D-negative_D)/100

* Define Globals
#delimit;
global model probit;
global z1 	afgh_dum icc s_lead nato
			aid_m aid_e lntrade lngdppc
			freedomhouse muslim europe; /* All variables */
global z2 	afgh_dum icc s_lead
			aid_m aid_e lntrade lngdppc
			freedomhouse muslim; /* All variables - europe - nato */
global opt 	se coefastr 3aster nolab br bd(2);
global vceoption robust;
global x x_A;
* global x x_B;
* global x x_C;
* global nonnat nonnat_A; /* Drop "*" if you want to add a non-national sample dummy */
* global nonnat nonnat_B; /* Drop "*" if you want to add a non-national sample dummy */
* global nonnat nonnat_C; /* Drop "*" if you want to add a non-national sample dummy */
global nonnat; /* Add "*" If you want to include a non-national sample dummy */
#delimit cr

* Descriptive Analysis (Tables 1 and 2)
sort $x country 
list country $x iraq_dum article98 unvoting if $x~=., sep(0)

* Regression without instruments
$model  iraq_dum  $x     , vce($vceoption)
outreg            $x     using table_$date.txt, $opt replace
$model  iraq_dum  $x $z1 $nonnat, vce($vceoption)
outreg            $x $z1 $nonnat using table_$date.txt, $opt append
$model article98  $x     , vce($vceoption)
outreg            $x     using table_$date.txt, $opt append
$model article98  $x $z2 $nonnat, vce($vceoption)
outreg            $x $z2 $nonnat using table_$date.txt, $opt append
reg   unvoting    $x     , vce($vceoption)
outreg            $x     using table_$date.txt, $opt append
reg   unvoting    $x $z1 $nonnat, vce($vceoption)
outreg            $x $z1 $nonnat using table_$date.txt, $opt append

* Descriptive Statistics
sum $x $z1 if e(sample), separator(0)

* Check whether regime-type interactions matter
* gen x_free=$x*freedomhouse
* $model iraq_dum  $x x_free $z1 $nonnat, vce($vceoption)
* $model article98 $x x_free $z2 $nonnat, vce($vceoption)
* reg    unvoting  $x x_free $z1 $nonnat, vce($vceoption)
cl
* Make Graph for Interpretation of Marginal Effects
save tempdata, replace
do _interpretation

* Multiple Imputation
use tempdata, clear
do _multiple.imputation.do

* Instrumental Variables Regressions
use tempdata, clear
do _ivregression

capture erase tempdata.dta
capture log close

