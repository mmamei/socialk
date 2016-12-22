


synch.data = read.csv("features-data.csv", header = TRUE, sep = ",",stringsAsFactors=FALSE)


#standardize

synch.data$avg_within <- scale(synch.data$avg_within)
synch.data$avg_between <- scale(synch.data$avg_between)
synch.data$rpc <- scale(synch.data$rpc)


synch.data$referendum <- scale(synch.data$referendum)
synch.data$blood <- scale(synch.data$blood)
synch.data$assoc <- scale(synch.data$assoc)
synch.data$depriv <- scale(synch.data$depriv)

dependent = "avg_within+avg_between+rpc";


fit_assoc = lm(as.formula(paste("assoc ~ ",dependent)),data=synch.data);
fit_blood = lm(as.formula(paste("blood ~ ",dependent)),data=synch.data);
fit_referendum = lm(as.formula(paste("referendum ~ ",dependent)),data=synch.data);
fit_depriv = lm(as.formula(paste("depriv ~ ",dependent)),data=synch.data);



library(boot)
library(yhat)
library(relaimpo)


## ASSOCIATION DENSITY

lm.out = fit_assoc
regr.out<-calc.yhat(lm.out)
regr.out$PredictorMetrics
commonalityCoefficients(synch.data, "assoc", list('avg_between', 'avg_within', 'rpc'))

boot.out<-boot(data=synch.data,boot.yhat,100,lmOut=lm.out,regrout0=regr.out)
## Evaluate bootstrap results
result<-booteval.yhat(regr.out,boot.out,bty="perc")
result$combCIpm

## Dominance Analysis
regr.out$PairedDominanceMetrics
calc.relimp(lm.out, type = c("lmg", "first", "last", "betasq", "pratt"), rela=TRUE)


## BLOOD DONATIONS

lm.out = fit_blood
regr.out<-calc.yhat(lm.out)
regr.out$PredictorMetrics
commonalityCoefficients(synch.data, "blood", list('avg_between', 'avg_within', 'rpc'))

boot.out<-boot(data=synch.data,boot.yhat,100,lmOut=lm.out,regrout0=regr.out)
## Evaluate bootstrap results
result<-booteval.yhat(regr.out,boot.out,bty="perc")
result$combCIpm

## Dominance Analysis
regr.out$PairedDominanceMetrics
calc.relimp(lm.out, type = c("lmg", "first", "last", "betasq", "pratt"), rela=TRUE)


## REFERENDA TURNOUT

lm.out = fit_referendum
regr.out<-calc.yhat(lm.out)
regr.out$PredictorMetrics
commonalityCoefficients(synch.data, "referendum", list('avg_between', 'avg_within', 'rpc'))

boot.out<-boot(data=synch.data,boot.yhat,100,lmOut=lm.out,regrout0=regr.out)
## Evaluate bootstrap results
result<-booteval.yhat(regr.out,boot.out,bty="perc")
result$combCIpm

## Dominance Analysis
regr.out$PairedDominanceMetrics
calc.relimp(lm.out, type = c("lmg", "first", "last", "betasq", "pratt"), rela=TRUE)



