

*Table 1: final equations

*Economic EQ
reg  v3Mdiff truthvictim fv8 fv10 fv11 fv34 xratf labor v64mean 

*Institutions EQ
reg  v3Mdiff truthvictim fv27 polity2 

*Conflict EQ
reg  v3Mdiff truthvictim damage cw_duration_lag  peace_agreement_lag victory_lag 

*Final EQ
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean


*robustness checks - using different measure of FDI inflows.

*Institutions EQ
reg  v2diff truthvictim fv8 fv10 fv11 fv34 xratf labor v64mean 

*domestic institutions
reg  v2diff truthvictim fv27 polity2 

*Conflict EQ
reg  v2diff truthvictim damage cw_duration_lag  peace_agreement_lag victory_lag 

*Final EQ
reg v2diff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean

*human rights robustness checks

*adding physical integrity
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean physint

*adding phystical integrity and worker
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean physint worker

*adding phystical, integrity, worker's rights, secondary education (women)
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean physint worker v60mean

*adding phystical, integrity, worker's rights, secondary education (women), and Raw Materials
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean physint worker v60mean v63mean

*appendix a: cem equation
*several coarsened techniques were tried. the automated procedure produced the most balanced dataset, so we used that in our analysis.
cem peace_agreement_lag damage victory_lag  issue_territory_lag, tr(truthvictim)
reg v3Mdiff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean [iweight=cem_weights]

reg v2diff truthvictim fv8 fv10 fv11 fv34 fv27  victory_lag cw_duration_lag  damage  peace_agreement_lag  coldwar polity2 xratf labor v64mean [iweight=cem_weights]

