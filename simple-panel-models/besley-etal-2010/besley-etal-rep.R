# compliled by Steven Miller 

library(here)
library(tidyverse)
library(fixest)

setwd(here("simple-panel-models/besley-etal-2010"))
getwd()

PCPG <- haven::read_dta("formatteddata.dta")

# Model 1, Table 2
summary(feols(share_taxes_inc ~ compnorm, fixef = c("state", "year"), data = PCPG))
# Model 4, Table 2
summary(feols(share_cap_exp ~ compnorm, fixef = c("state", "year"), data = PCPG))
# Model 7, Table 2
summary(feols(rtw ~ compnorm, fixef = c("state", "year"), data = PCPG))
