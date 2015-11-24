#M200A COALESCENCE EXERCISES,Dr. Kirk Lohmueller, Fall 2015
#Hayley Stansell
#
#
getwd()
setwd("C:\\Users\\Hayley\\eeb201hayleystansell")
getwd()
#
#
?rexp
#
output<-rexp(10,2)
#[1] 0.21809588 1.70468865 1.24958590 0.03783002 0.65334166 0.31265010 0.25168173 0.32412173 0.05198139 0.64820064
output
hist(output)
#This shows that most outputs are clustering just below 0.5
outputbig<-rexp(200,2)
outputbig
mean(outputbig)
#[1] 0.4781231
hist(outputbig)

