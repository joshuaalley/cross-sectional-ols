/* Interpretation */

keep if $x~=.
sum $x
global n 21
global ave=round(_result(3), 0.01)
global min=round(_result(3)-_result(4)^(1/2), 0.01)
global max=round(_result(3)+_result(4)^(1/2), 0.01)
global bin=($max-$min)/($n-1)

gen xx=.
local i=1
while `i'<=$n{
   	replace xx=$min+$bin*(`i'-1) if _n==`i'
 	local i=`i'+1
}
la var xx "Positive - Negative"

save temp, replace

capture program drop myint
program define myint

	gen predy_lo=.
	gen predy_hi=.
	gen predy_av=.

    setx mean

	local i=1
	while `i'<=$n{
		capture drop yy
    	setx $x xx[`i']
    	simqi, `1' `2'(yy)
    	if "`2'"=="genpr"{
    		replace yy=1-yy
    	}
    	else if "`2'"=="genev"{
    		replace yy=yy/100
    	}		
 		_pctile yy, p(2.5, 97.5)
*		_pctile yy, p(5, 95)
  		sort xx
 		replace predy_lo=r(r1) if _n==`i'
 		replace predy_hi=r(r2) if _n==`i'
		sum yy
		replace predy_av=_result(3) if _n==`i'
		local i=`i'+1
	}

	keep xx predy_*
	keep if xx~=.
	gen dv=`3'
	save temp`3', replace
	
end


use temp, clear
estsimp $model iraq_dum $x $z1 $nonnat, vce($vceoption)
myint pr genpr 1 

use temp, clear
estsimp $model article98 $x $z2 $nonnat, vce($vceoption)
myint pr genpr 2

use temp, clear
estsimp reg unvoting $x $z1 $nonnat, vce($vceoption)
myint ev genev 3 

use temp1, clear
append using temp2
append using temp3
#delimit;
la define dv 1 "P( Sent Troops in Iraq in 2003 = 1 )"
			 2 "P( BIA entered into force in 2003 = 1 )"
			 3 "E( UN voting with US, ratio )";
#delimit cr

la val dv dv
set graph off

#delimit;
tw 	(scatter predy_av xx, c(l) )
	(rcap predy_hi predy_lo xx),
	legend(off) ylab(0 0.5 1.0) xlab($min $ave $max) xtitle("Opinion About US Foreign Policy")
	by(dv, yresc col(1) legend(off) note(""));	
#delimit cr

set graph on
graph display, ysize(7) xsize(6) scheme(s2mono) scale(0.8)
* graph display, ysize(4.95) xsize(9) scheme(s2mono) scale(1.2)

capture erase temp.dta
capture erase temp1.dta
capture erase temp2.dta
capture erase temp3.dta
