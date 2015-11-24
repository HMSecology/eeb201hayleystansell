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
#
#
#############################################################################################Exercise FIVE###############
#
#From previous work, it seems that the rate of coalescence should be 1/2N , where 2N is number of chromosomes
#
#
#############################################################################################EXERCISE SIX###############
#
#
rate<-1/20000
mean(rexp(10000, rate))
#[1] 19712.04
##########################a) what is the average time to most recent common ancestor in your simulation?
#19712.04
##########################b) what is the theoretical expectation?
#20,000
##########################c) how do the values compare?
# They are very close to one another. 
##########################d) make a density plot of simulated coalescent times
??densityplot
?density
?plot
density(rexp(10000,rate))
plot(density(rexp(10000,rate)))
#Success!!

