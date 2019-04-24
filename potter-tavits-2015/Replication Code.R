# Replication Code


##########################
#### Campaign Finance Laws 
#### and Party Competition 
#### Joshua D. Potter and
#### Margit Tavits
#### April 2013
##########################


##########################
#### Codebook
##########################

# cnty \ country name
# year \ year of current election
# rulelaw \ from World Bank
# polity \ Polity IV score
# thresh \ legal vote threshold 
# postenp \ ENP after current election
# preenp \ ENP prior to current election
# fundparity4 \ Metric presented in paper
# fundparity 3 \ Alternate drops direct funding
# directelig \ Direct funding eligibility
# demin \ Year first democratic
# demyear \ Number of democratic years
# fed \ Whether or not federal
# pres \ Whether or not presidential
# avemag \ Average district magnitude
# smd \ Whether or not SMD system
# fract \ Ethnolinguistic fractionalization
# donorlimit \ Whether limits on donations
# eligmedia \ Free media eligibility
# partyspend \ Whether limits on spending


##########################
#### Replication Code
##########################

# Set working directory

# read in data
library(foreign)
raw.data<-read.dta("potter_tavits_data.dta")

# drop outliers
campaigns <- subset(raw.data, postenp < 9.2)


# create post-1974 subset for endogeneity test
later1974<-subset(campaigns, demin>1973)

# estimate Model 1 in Table 2
library(arm)
full<-lm(postenp ~ fundparity4
         + demyears
         + fed 
         + pres 
         + log(avemag) 
         + fract 
         + log(avemag):fract, 
         data=campaigns)
display(full)	

# estimate Model 2 in Table 2
post1974<-lm(postenp ~ fundparity4
             + demyears
             + fed 
             + pres 
             + log(avemag) 
             + fract 
             + log(avemag):fract, 
             data=later1974)	
display(post1974)

# Use texreg to place their table in the paper
library(texreg)
rep.list <- list(full, post1974)

texreg(rep.list)

# construct the endogeneity plot in Figure 1
plot(campaigns$fundparity4 
     ~ campaigns$preenp, 
     pch=20, col="grey20", cex=1.5, 
     xlab="Previous ENP", 
     ylab="Current Fund Parity Value")
display(lm(fundparity4 ~ preenp, data=campaigns))
abline(a=0.82, b=-0.04, lwd=2)	

# model to ensure that all fund parity metric components are exerting similarly-signed influences (this model is mentioned in footnote 44)
components<-lm(postenp ~ directelig 
               + partyspend
               + donorlimit
               + eligmedia
               + demyears
               + fed 
               + pres 
               + log(avemag) 
               + fract 
               + log(avemag):fract, 
               data=campaigns)
display(components)

# model to ensure that differences between legal rules and actual empirical practice in a country are not driving our results (this model is mentioned in footnote 45)
rules.practice<-lm(postenp ~ fundparity4
                   + rulelaw
                   + fundparity4*rulelaw
                   + demyears
                   + fed 
                   + pres 
                   + log(avemag) 
                   + fract 
                   + log(avemag):fract, 
                   data=campaigns)
display(rules.practice)

# model to ensure that including legal threshold (which eliminates a large number of our observations due to data availability) does not undercut our results (this model is mentioned in footnote 56) 
threshold<-lm(postenp ~ fundparity4
              + thresh
              + demyears
              + fed 
              + pres 
              + log(avemag) 
              + fract 
              + log(avemag):fract, 
              data=campaigns)
display(threshold)
