


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


summary(fit_referendum)
summary(fit_blood)
summary(fit_assoc)
summary(fit_depriv)
