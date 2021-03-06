#M200A - Approx. Bayesian Computation - Dr. Kirk Lohmueller, Fall 2015
#Hayley Stansell
#
#
getwd()
setwd("C:\\Users\\Hayley\\eeb201hayleystansell")
getwd()
#
#Exercise 1
#
#a) Assume that N can be any value b/w 100 and 100,000. Draw 1 million values from the prior dist. of N. 
#Use a uniform distribution for N. Assume that N~U[100, 100000]

?runif
#try simulating the coin flip thing from class
#prior<- runif(1e6)
#D_sim<- rbinom(n=1e6, size=100, p=prior)
#plot(D_sim)
#This produces a "black block", x-axis going from 0 to 1e6, y-axis going from 0 to 100....
#?plot
#how is a number the prior distribution???? 
prior<- runif(n=1e6, min = 100, max = 100000)
prior
#plot(prior) #looks correct in terms of axes
#

#b) For each value of N, simulate a TMRCA. Use same approach as on last week's assignment. Note that you are using N (vs. 2N)
#   because you are dealing with haploid samples (2 haploid samples from 2 individuals, one c-some per individ.)

rate<- 1/(prior)
mostrecent<- rexp(1e6, rate)
#######DOES NOT NEED TO BE A LOOP!, R automatically takes each value of "prior" and plugs it in in order to the "mostrecent" vector
#######Follows that NEITHER DOES NEXT STEP
mostrecent
length(mostrecent)


#c) For each TMRCA, add a Poisson number of mutations w/ the appropriate mutation rate. 
#   rate = mu = 1e-8 per base pair per c-some....for 100kb is 1e-3.... *2? for 2 c-somes??
ratemu<- 1e-3
snpnumber<- rpois(1e6, mostrecent*ratemu*2)
snpnumber
max(snpnumber)
length(snpnumber)


#d) Set parameters to "choose" which draws from the prior give data that approx. the OBSERVED number of SNPs
#accept all values of "N" that give b/w 45 and 55 SNPs
sims<- cbind(prior, snpnumber)
simslower<- subset(sims, sims[,2]>45)
simsupper<- subset(simslower, simslower[,2]<55)
posterior<-simsupper[,1]
posterior
max(posterior)
min(posterior)
hist(posterior)
density(posterior)
plot(density(posterior))

#e) I should be done!


#############################################################################################EXERCISE TWO

#Make a density plot of your prior and posterior distributions of N. 
#plot them on the same axes, label which line corresponds to the prior, which corresponds to the posterior


density(posterior)
plot(density(posterior), main= "Posterior vs. Prior distributions", xlab= "Population size (value of N)", col= "blue")
density(prior)
?lines
# "lines() adds a line to an existing plot --- lines(namevector, col = color)
lines(density(prior), col= "red")
?legend
legend(8e04,1.35e-05, # places a legend at the appropriate place 
       c("Posterior", "Prior"), # puts text in the legend
       
       lty=c(1,1), # gives the legend appropriate symbols (lines)
       
       lwd=c(2.5,2.5),col=c("blue", "red")) # gives the legend lines the correct color and width

###########################################################################################EXERCISE THREE

#What is the median value of the posterior distribution of N?

