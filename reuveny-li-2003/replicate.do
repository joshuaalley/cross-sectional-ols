clear
capture log close

#delimit ;
set more off;
set mem 40m;

use "D:\Inequality\replicate\replicate.dta", clear;
des;
sort cow year;
tsset cow year, yearly;
iis cow;
tis year;


**Table 1 Results**;
regress gg lgg dmdem dmtrade  dmportf dmfdiin dmgdppc sqgdppc , robust cluster(cow);

regress gg lgg dmdem dmtrade  dmportf dmfdiin dmgdppc sqgdppc if oecd==0, robust cluster(cow);

regress gg lgg dmdem dmtrade  dmportf dmfdiin dmgdppc sqgdppc if oecd==1, robust cluster(cow);

regress gg lgg dmdem dmtrade  dmportf dmfdiin dmgdppc sqgdppc if year==1912, robust ;
