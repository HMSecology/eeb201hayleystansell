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
#
#Simulate two species with different mu's (0.5 and -0.5, 100 MY, )
#15 runs of a trend process for two groups of species: one with a mu of 0.5 and the other with a mu of -0.5 for 100 MY
par(mfrow = c(1,1))
bmtrend0.02<-replicate(15, bmtrend(100, 0.05, 1))
bmtrendneg0.02<-replicate(15, bmtrend(100, -0.05, 1))
cols1<-rainbow(15)
cols2<-grey(0:15/15)
plot(bmtrend0.02[,1], xlim=c(0,100), ylim=c(-200, 200), type="l", col=cols1[1], xlab="Time", ylab="Trait")
for(i in 2:10) lines(bmtrend0.02[,i], col=cols1[i])
for(i in 1:10) lines(bmtrendneg0.02[,i], col=cols2[i])
#success!
#
###################################################
#
#Ornstein-Uhlenbeck Model
#the farther away from theta (optimal trait value), the stronger the alpha (effective "pull" towards theta)
#sigma is again, the effective "step size" for the BM motion
alpha<-0.4
theta<-1
sigma<-0.05
x0<-0
#
OUalpha0.1_sample1<- x0 + alpha*(theta-x0)+sigma*(rnorm(1,mean=0))
#^this is one sample in the simulation
# the next sample(s) would be.....long because they build off the previous samples (aka steps??)
OUalpha0.1_sample2<- OUalpha0.1_sample1 + alpha*(theta-OUalpha0.1_sample1)+sigma*(rnorm(1,mean=0))
OUalpha0.1_sample3<- OUalpha0.1_sample2 + alpha*(theta-OUalpha0.1_sample2)+sigma*(rnorm(1,mean=0))
plot(x=0:3, y=c(1,OUalpha0.1_sample1, OUalpha0.1_sample2, OUalpha0.1_sample3), type="l", main="Alpha=0.4")
#plot successfully produced
#
#write a function to simplify this process
ornstein_uhlenbecksim <- function(n,theta,alpha,sigma2,x0){# n is the number of time units to simulate for, 
  dw <- rnorm(n, 0)
  x <- c(x0)
  for (i in 2:(n+1)) {
    x[i] <- x[i-1] + alpha*(theta-x[i-1]) + sigma2*dw[i-1]
  }
  return(x);
}
#no issues with this function
#10 trials modeling the OU process for 100 MY each
par(mfrow = c(1,1))
alpha<-0.4
theta<-1
sigma<-0.05
x0<-0
time = 100
alpha0.4sigma0.05theta1<-replicate(10, ornstein_uhlenbecksim(time, theta, alpha, sigma, x0)) # replicate() 
colr<-topo.colors(9)
#plotting info here ------
plot(alpha0.4sigma0.05theta1[,1], type="l", main="alpha 0.4 sigma=0.05", ylim=c(-2, 2))
for(i in 2:ncol(alpha0.4sigma0.05theta1)) lines(alpha0.4sigma0.05theta1[,i], type="l",col=colr[i-1] )
#SUCCESSSSSSS
#
#
#
#Exercise 6 - comparing OU to BM motion. ############################
#
#
#create a plot with the same parameters as this model ^ , but modeling BM (aka no ALPHA, no THETA)
#BM with the same starting value, sigma, and time
#
#essentially what was done at the beginning? 
#
#########just colors = # of lineages, rnorm(X), X =time units
#plotting 10 lineages with BM for 100 time units
par(mfrow = c(1,1))
displace<-rnorm(100)
plot(displace)
x<-cumsum(displace)
plot(x, type="l", xlab="Time", ylab="Trait Value")
#SUCCESS 
cols<-rainbow(10) 
#uses the "rainbow pallette" to assign colors to each line plotted. Is a now named-vector called "cols"
plot(cumsum(rnorm(100)), type="l", ylim=c(-30,30))
# simple for loop for each of the 50 colours
for(i in 1:length(cols)) lines(cumsum(rnorm(100)), col=cols[i]) 
#SUCCESS
#
#
#
#additional OU simulations
#
alpha1sigma0.01theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 1, 0.01, 0)) # replicate just runs it 
colr<-topo.colors(9)
plot(alpha1sigma0.01theta1[,1], type="l", main="alpha1 sigma=0.01", ylim=c(-2, 2))
for(i in 2:ncol(alpha1sigma0.01theta1)) lines(alpha1sigma0.01theta1[,i], type="l",col=colr[i-1] )
# play with different parameters.
alpha0.5sigma0.01theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0.5, 0.01, 0))
alpha0.1sigma0.01theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0.1, 0.01, 0))
alpha0sigma0.01theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0, 0.01, 0))
alpha1sigma0.1theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 1, 0.1, 0))
alpha0.5sigma0.1theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0.5, 0.1, 0))
alpha0.1sigma0.1theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0.1, 0.1, 0))
#
alpha0sigma0.1theta1<-replicate(10, ornstein_uhlenbecksim(100, 1, 0, 0.1, 0))
par(mfrow=c(2,2))
plot(alpha1sigma0.01theta1[,1], type="l", main="alpha1 sigma=0.01", ylim=c(-2, 2))
for(i in 2:ncol(alpha1sigma0.01theta1)) lines(alpha1sigma0.01theta1[,i], type="l",col=colr[i-1] )
plot(alpha1sigma0.1theta1[,1], type="l", main="alpha1 sigma=0.1", ylim=c(-2, 2))
for(i in 2:ncol(alpha1sigma0.1theta1)) lines(alpha1sigma0.1theta1[,i], type="l",col=colr[i-1] )
plot(alpha0.5sigma0.01theta1[,1], type="l", main="alpha0.5 sigma=0.01", ylim=c(-2, 2))
for(i in 2:ncol(alpha0.5sigma0.01theta1)) lines(alpha0.5sigma0.01theta1[,i], type="l",col=colr[i-1] )
plot(alpha0.5sigma0.1theta1[,1], type="l", main="alpha0.5 sigma=0.1", ylim=c(-2, 2))
for(i in 2:ncol(alpha0.5sigma0.1theta1)) lines(alpha0.5sigma0.1theta1[,i], type="l", col=colr[i-1] )
#
#NICE
#
#EVEN MORE --------------
#
plot(alpha0.1sigma0.01theta1[,1], type="l", main="alpha0.1 sigma=0.01", ylim=c(-2, 2))
for(i in 2:ncol(alpha0.1sigma0.01theta1)) lines(alpha0.1sigma0.01theta1[,i], type="l", col=colr[i-1] )
plot(alpha0.1sigma0.1theta1[,1], type="l", main="alpha0.1 sigma=0.1", ylim=c(-2, 2))
for(i in 2:ncol(alpha0.1sigma0.1theta1)) lines(alpha0.1sigma0.1theta1[,i], type="l", col=colr[i-1] )
plot(alpha0sigma0.01theta1[,1], type="l", main="alpha0 sigma=0.01", ylim=c(-2, 2))
for(i in 2:ncol(alpha0sigma0.01theta1)) lines(alpha0sigma0.01theta1[,i], type="l", col=colr[i-1] )
plot(alpha0sigma0.1theta1[,1], type="l", main="alpha0 sigma=0.1", ylim=c(-2, 2))
for(i in 2:ncol(alpha0sigma0.1theta1)) lines(alpha0sigma0.1theta1[,i], type="l", col=colr[i-1] )
#
#
##################################################################################################################
#MODEL FITTING EXERCISE
#
#just copy/pasted files into current WD
getwd()
library(ape)
library(geiger)
library(parallel)
tre <- read.tree("Haemulidae4models.tre")
dat<-read.csv("Haemulidae4models.csv", stringsAsFactors=FALSE) # Contains data on standard length, eye(???? no idea)
trait <- dat[,2] # Selecting a trait
names(trait) <- tre$tip.label # Assigning the appropriate tip labels to the trait object
#ok, no errors
#
#
#Demo - fit a BM model with function "fit continuous" ############################################################
#
BM.model <- fitContinuous(tre, trait, model="BM")
#not seeing any output at this time
BM.model
#ahhhhh okay, duh. 
#GEIGER-fitted comparative model of continuous data ###############OUTPUT##################
#fitted 'BM' model parameters:
#  sigsq = 0.002143
#z0 = 2.233988
#
#model summary:
#  log-likelihood = 12.308798
#AIC = -20.617596
#AICc = -20.362277
#free parameters = 2
#
#Convergence diagnostics:
#  optimization iterations = 100
#failed iterations = 0
#frequency of best fit = 1.00
#
#object summary:
#  'lik' -- likelihood function
# 'bnd' -- bounds for likelihood search
# 'res' -- optimization iteration summary
# 'opt' -- maximum likelihood parameter estimates
#
BM.model$bnd
#                  mn           mx
# sigsq 7.124576e-218 2.688117e+43
BM.model$opt
BM.model$opt$lnL
BM.model$opt$aicc # You get the drift :)
#
#Demo - fit OU Model with fit continuous #########################################################################
#
OU.model <- fitContinuous(tre, trait, model="OU")
# Warning message:
# In fitContinuous(tre, trait, model = "OU") :
#  Parameter estimates appear at bounds:
#  alpha
OU.model$bnd
OU.model <- fitContinuous(tre, trait, model="OU", bounds=list(alpha=c(0, 150)))
#what are the maximum likelihood estimates for the BM and OU models? see below:
BM.model$opt$lnL
OU.model$opt$lnL
#[1] 12.3088  ---output for BM
#[1] 47.05235 ----output for OU
#OU seems to be a better model fit, as it has a higher likelihood estimate
#
#Assuming this below is the likelihood ratio test??
delta.BM.OU <- 1-pchisq(2*(OU.model$opt$lnL - BM.model$opt$lnL),1)
delta.BM.OU
# [1] 1.110223e-16
#Not...really....sure what this means/is showing/how to interpret...
#
#AIC scores (corrected - AICc)
BM.model$opt$aicc # Higher AICc score is worse!
OU.model$opt$aicc # Lower AICc score is better!
#OU score is -87, BM score is -20 ...so OU is doing better, consistent with maximum likelihood estimate
all.aicc <- c(BM.model$opt$aicc, OU.model$opt$aicc)
delta.aicc <- all.aicc - min(all.aicc) # This may seem a bit circumstantial for just two models, but 
delta.aicc # delta AIC or AICC scores >2 are ususally considered to provide positive support
# [1] 67.22069  0.00000
#  ^the difference between the AICc scores for BM and OU models
#
#Akaike weights:
rel.L <- exp(-delta.aicc*0.5)
AK.weights <- rel.L/sum(rel.L)
AK.weights
AK.weights
# [1] 2.530532e-15 1.000000e+00  ----------------output-------------------------
#
#
# Exercise 7 ###################################################################
#
?fitContinuous
#INFO:
#fitContinuous(phy, dat, SE = 0,
#model = c("BM","OU","EB","trend","lambda","kappa","delta","drift","white"),
#bounds= list(), control = list(method = c("subplex","L-BFGS-B"),
#niter = 100, FAIL = 1e+200, hessian = FALSE, CI = 0.95), ncores=NULL, ...)
#
#WORKING WITH EYE WIDTH
names(trait)
trait
#not clear if that's whats' getting worked with, since I'm getting a name *and* a measurement for "trait"....
#already have BM and OU models, assuming they were looking at eye width
#need EB and trend
#
#EB model
EB.model <- fitContinuous(tre, trait, model="EB")
EB.model
#EB likelihood ----- [1] 12.3086
EB.model$opt$lnL
#EB AICc  --------- [1] -18.09546
EB.model$opt$aicc
#
#
#trend model
trend.model <- fitContinuous(tre, trait, model="trend")
trend.model
#trend likelihood ----- [1] 18.29803
trend.model$opt$lnL
#trend AICc ----------- [1] -30.07432
trend.model$opt$aicc
#
#
all.aicc <- c(BM.model$opt$aicc, OU.model$opt$aicc, trend.model$opt$aicc, EB.model$opt$aicc)
delta.aicc <- all.aicc - min(all.aicc) # This may seem a bit circumstantial for just two models, but 
delta.aicc
#
#
#FINAL COMPARISON
#
#EB likelihood ----- [1] 12.3086
#trend likelihood ----- [1] 18.29803
#BM likelihood ------ [1] 12.3088
#OU likelihood ------- [1] 47.05235
#
#EB AICc  --------- [1] -18.09546
#trend AICc ----------- [1] -30.07432
#BM AICc ------------ [1] -20.36228
#OU AICc-------------- [1] -87.58297
#
# # Higher AICc score is worse! Lower AICc score is better!
#
#deltaAIC's ------
#[1] 67.22069  0.00000 57.50865 69.48751
?trend
??trend
