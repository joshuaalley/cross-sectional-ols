*BASELINE REGRESSIONS (Table 1)


use "national tariffs original.dta", clear

reg tariff polity lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt, robust

reg tariff iec lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt, robust



use "national ntbs original.dta", clear

reg corecov polity lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg corecov iec lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg qualcov polity lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg qualcov iec lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust




*CONSUMER PROXIES (Table 3)

reg qualcov polity iso9000 lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg qualcov iec iso9000 lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust


reg qualcov polity capgov lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg qualcov iec capgov lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust


reg qualcov polity syswql lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust

reg qualcov iec syswql lngdppc lngdp lnexpgdp reer growth dimpgdp lngovcons gatt avgtar, robust




*SECTORAL REGRESSIONS (Table 4)


use "sectoral ntbs original.dta", clear

gen lncorecov1=lncorecov

replace lncorecov1=. if lncorecov==0

gen lnqualcov1=lnqualcov

replace lnqualcov1=. if lnqualcov==0


intreg lncorecov1 lncorecov lnempshare lnimppen lnexpdep dlnimppen lngdp lngdppc lngovcons reer growth lntariff, cluster(isocode)

intreg lnqualcov1 lnqualcov lnempshare lnimppen lnexpdep dlnimppen iso9000 lngdp lngdppc lngovcons reer growth lntariff, cluster(isocode)




*PARTY MANIFESTO REGRESSIONS (Table 2)

use "manifesto data.dta", clear

quietly tab year, gen(yr)

xtgls challenges ltariff, i(ccode) panels(hetero) corr(ar1) force

reg challenges lchallenges ltariff, cluster(ccode)

reg challenges lchallenges ltariff yr*

reg challenges lchallenges ltariff if eu==0, cluster(ccode)

reg challenges lchallenges ltariff if year>1989, cluster(ccode)



