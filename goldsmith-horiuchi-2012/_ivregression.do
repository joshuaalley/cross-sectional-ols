sort ccode
save temp, replace
use Pew44nations2002_20090819, clear
replace ccode=255 if ccode==260
sort ccode
merge 1:1 ccode using temp
capture erase temp.dta

* Regression with instruments

gen x61b=p_q61b_pos-p_q61b_neg
gen x61d=p_q61d_pos-p_q61d_neg
global iv x61b x61d

ivregress 2sls iraq_dum ($x =$iv) $z1 $nonnat, vce($vceoption) first
outreg $x $z1 $nontat using table_iv__$date.txt, $opt replace
estat firststage
estat endogenous
estat overid

ivregress 2sls article98 ($x =$iv) $z1, vce($vceoption) first
outreg $x $z1 $nontat using table_iv__$date.txt, $opt append
estat firststage
estat endogenous
estat overid
 
ivregress 2sls unvoting ($x =$iv) $z1, vce($vceoption) first
outreg $x $z1 $nontat using table_iv__$date.txt, $opt append
estat firststage
estat endogenous
estat overid
