wd()
getwd()
setwd("C:\\Users\\Hayley\\eeb201hayleystansell")
getwd()
par(mfrow = c(1,1))
displace<-rnorm(100)
plot(displace)
library(geiger)
#package 'ape' loaded
#messages x2 - both geiger an ape were built under R vers 3.1.3
#neither of these lines below work "as is"
par(mfrow = c(1,1))
displace<-rnorm(100)
plot(displace)
# ^ running these piecemeal worked. have a plot 
#exported as PDF
x<-cumsum(displace)
plot(x, type="l", xlab="Time", ylab="Trait Value")
#SUCCESS 
cols<-rainbow(50) 
#uses the "rainbow pallette" to assign colors to each line plotted. Is a now named-vector called "cols"
plot(cumsum(rnorm(100)), type="l", ylim=c(-30,30))
# simple for loop for each of the 50 colours
for(i in 1:length(cols)) lines(cumsum(rnorm(100)), col=cols[i]) 
#
#
#Exercise 2
#just plotted 50 lineages with BM for 100 time units
#now plotting 50 lineages with BM for 50 time units
#basically doing the same code but changing rnorm to 50 instead of 100...see how it goes...
par(mfrow = c(1,1))
displace<-rnorm(50)
plot(displace)
# ^ running these piecemeal worked. have a plot 
#exported as PDF
x<-cumsum(displace)
plot(x, type="l", xlab="Time", ylab="Trait Value")
#SUCCESS 
cols<-rainbow(50) 
#uses the "rainbow pallette" to assign colors to each line plotted. Is a now named-vector called "cols"
plot(cumsum(rnorm(50)), type="l", ylim=c(-30,30))
# simple for loop for each of the 50 colours
for(i in 1:length(cols)) lines(cumsum(rnorm(50)), col=cols[i]) 
#Excccccelent
#
#
#Examining the effect of rate (step size, standard deviation of draws from a normal distribution)
#blue uses a step size of 1, the default, whereas green is using a step of 5 standard deviations
plot(cumsum(rnorm(100)), type="l", ylim=c(-80,80), ylab="Trait", col="blue")
for(i in 1:20) lines(cumsum(rnorm(100)), col="blue")
for(i in 1:20) lines(cumsum(rnorm(100, sd=5)), col="green")
#Graph worked for this, too. Woot.
#
#Exercise 3
#
#
tree<-read.tree(text="((grizzlybear:1, polarbear:1):4, spectacledbear:5);")
plot(tree)
nodelabels()
axisPhylo()
#successful plot of simple tree
#
rootMass <- 250 # size of ancestor
sigmasq = 2.5 # Brownian rate
time = 5 # 5 million years of independent evolution from the root
sd <- sqrt(time * sigmasq) # Brownian evolution is proportional to rate X time)
specbearDeltaMass <- rnorm(1, mean = 0, sd = sd)
specbearMass <- rootMass + specbearDeltaMass
specbearMass
#[1] 255.8844  was output. Compare with tutorial output of ~248
#try a second time
#[1] 246.7905 was output of second run. Highlights the "random walk" nature of BM going on here
#
##another way to do this using the tree structure itself to supply the time argument
#in R, tree tip labels are numbered 
specbearDeltaMass<-rnorm(1, mean=0, sd=sqrt(sigmasq*tree$edge.length[1]))
specbearMass <- rootMass + specbearDeltaMass
specbearMass
#[1] 253.0734 was ouput of this run. 
#
#Exercise 4
#
#simulate BM evolution for this whole three taxon tree. (already have final masses for Spectacled Bear...?)
#4 million years of common evolution, followed by 1 million years of independent for each remaining bear
#the question is, how to get that 1 million year change independent.............
#starting by focusing on polar bear (honestly the same as for grizzly bear)
rootMass <- 250 # size of ancestor
sigmasq = 2.5 # Brownian rate - using the same as for spectacled bear
time = 4 # 4 million years of common evolution, no matter if polar or grizzly
sd <- sqrt(time * sigmasq) 
polarDeltaMassCommon <- rnorm(1, mean = 0, sd = sd)
polarMassCommon <- rootMass + polarDeltaMassCommon
polarMassCommon
#[1] 248.1919 as output
#the final 1 MYA should be whatever the value is after the 4 MYA + a 1 MYA random walk
#splitMass<-polarMassCommon + polarDeltaMassCommon
#need to redefine polarDeltaMassCommon to be the deltaMass for the 1 MYA split, OR, it's adding in as a second delta...?
#final mass = common 4 MYA change(already defined) + independent 1 MYA change(undefined)
#independent 1 MYA change (final mass) = common 4 MYA change + BM simulation for 1 MYA from that 4MYA output(splitMass) (YES)
#finalpolarMass = common 4MYA change output(newrootMass) + splitDeltaMass
#newrootMass<-polarMassCommon #(REDUNDANT)
#sigmasq = 2.5
#time = 1
#sd <- sqrt(time * sigmasq) 
#splitDeltaMass(NEW CHANGE IN MASS) <- rnorm(1, mean = 0, sd = sd)
#finalpolarMass <- newrootMass + splitDeltaMass(NEW CHANGE IN MASS)
#finalpolarMass
#WORKED - RAN PIECEMEAL, 1st running code for polarMassCommon, then runing for finalpolarMass
newrootMass<-polarMassCommon #(REDUNDANT)
sigmasq = 2.5
time = 1
sd <- sqrt(time * sigmasq) 
splitDeltaMass <- rnorm(1, mean = 0, sd = sd)
finalpolarMass <- newrootMass + splitDeltaMass
finalpolarMass
#polarMassCommon - [1] 245.7656
#finalpolarMass - [1] 245.8545
#THIS RESULT SHOULD NOT MATTER IF IT'S A POLAR OR GRIZZLY BEAR as the same time is split between the two in the same way
#
#
#Exercise 5
#
bmtrend<-function(time, mu, stdev){ # a function that requires mu which is the trend parameter showing how 
  displace<-vector( , length=time) # set up an empty vector of the same length as time
    for(i in 1:time){
      displace[i]<-rnorm(1, mean=mu*i, sd=stdev) # sample from rnorm with a mean with a mean of mu 
      }
    traj<-cumsum(displace) # calculates the trajectory over time
    return(traj)
}
#not getting an outright error message but have a warning on line 124 "missing argument to function call", not sure if spacing is the problem
par(mfrow = c(1,1))
bmtrend0.02<-replicate(10, bmtrend(100, 0.02, 1))
bmtrendneg0.02<-replicate(10, bmtrend(100, -0.02, 1))
cols1<-rainbow(10)
cols2<-grey(0:10/10)
plot(bmtrend0.02[,1], xlim=c(0,100), ylim=c(-150, 150), type="l", col=cols1[1], xlab="Time", ylab="Trait")
for(i in 2:10) lines(bmtrend0.02[,i], col=cols1[i])
for(i in 1:10) lines(bmtrendneg0.02[,i], col=cols2[i])
#SUCCESS, correct-looking output

