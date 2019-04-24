*MAIN TARIFF REGRESSIONS

use "trade blocs tariffs.dta", clear

reg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc fsharec wlxmc f_xm


*ROBUST REGRESSIONS

rreg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac f_rca

rreg dlnsmfn l_lnsmfn lngdppc fsharec wlxmc f_xm


*2SLS REGRESSIONS

ivreg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac (f_rca=xicrca)

ivreg dlnsmfn l_lnsmfn lngdppc fsharec wlxmc (f_xm=xicrca)


*NTB REGRESSIONS

use "trade blocs ntbs.dta", clear

reg dlnntb l_lnntb lngdppc fsharec wlrcac f_rca, robust

reg dlnntb l_lnntb lngdppc fsharec wlxmc f_xm, robust


*ADDITIONAL ROBUSTNESS CHECKS

use "trade blocs tariffs.dta", clear


*ADDITION AND SUBTRACTION OF CONTROLS

reg dlnsmfn fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons cu fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons eu fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons cu checks2a fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons cu checks3 fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons cu polcon3 fsharec wlrcac f_rca

reg dlnsmfn l_lnsmfn lngdppc growth dunemp dxr imf polity govcons cu polcon5 fsharec wlrcac f_rca


*IMPORT-WEIGHTED AND OUTPUT-WEIGHTED MFN TARIFFS

reg dlniwmfn l_lniwmfn lngdppc fsharec wlrcac f_rca

reg dlniwmfn l_lniwmfn lngdppc fsharec wlxmc f_xm

reg dlnpwmfn l_lnpwmfn lngdppc fsharec wlrcac f_rca

reg dlnpwmfn l_lnpwmfn lngdppc fsharec wlxmc f_xm



*3-DIGIT SITC CONVERGENCE MEASURE

reg dlnsmfn l_lnsmfn lngdppc fsharec lsitc3c f_sitc


*EXCLUDING CASES WITH HIGH DFBETAS

reg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac f_rca

predict dfbrca, dfbeta(f_rca)

reg dlnsmfn l_lnsmfn lngdppc fsharec wlrcac f_rca if abs(dfbrca)<2/sqrt(30)


reg dlnsmfn l_lnsmfn lngdppc fsharec wlxmc f_xm

predict dfbxm, dfbeta(f_xm)

reg dlnsmfn l_lnsmfn lngdppc fsharec wlxmc f_xm if abs(dfbxm)<2/sqrt(30)



