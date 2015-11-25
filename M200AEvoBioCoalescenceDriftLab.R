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
#19712.04 generations
##########################b) what is the theoretical expectation?
#20,000 generations
##########################c) how do the values compare?
# They are very close to one another. 
##########################d) make a density plot of simulated coalescent times
??densityplot
?density
?plot
density(rexp(10000,rate))
plot(density(rexp(10000,rate)))
#Success!!
##########################e) what is the standard deviation of the coal. times?
output<-rexp(10000,rate)
density(output)
sd(output)
#[1] 20371.65
#
#
#############################################################################################EXERCISE SEVEN#############
##answer parts a-e from Q6 for this simulation
# set 2N = 2000
#
rate7<-1/2000
mean(rexp(10000, rate7))
#[1] 2009.536
##########################a) what is the average time to most recent common ancestor in your simulation?
#2009.536 generations
##########################b) what is the theoretical expectation?
#2000 generations
##########################c) how do the values compare?
# They are very close to one another, just as in Exercise Six
##########################d) make a density plot of simulated coalescent times
density(rexp(10000,rate7))
plot(density(rexp(10000,rate7)))
#Success!! ---it looks nearly identical in shape to the plot from exercise six. 
#             The largest are occupies 0-5000, 1/10 of what was seen with the simulation where 2N=20000 (0-50000). It scales up.
##########################e) what is the standard deviation of the coal. times?
output7<-rexp(10000,rate7)
density(output7)
sd(output7)
#[1] 1999.717
#
##########################f) how does TMRCA from simulations in Q6 (2N =20,000) and Q7 (2N = 2,000) compare?
#  They are both theoretically (and approximately, in simulation) equal to 2N generations.
#  With the population size in Q7 being a tenth of the size of Q6, the resulting TMRCA is similarly one tenth. 
##########################g) what can you conclude about how the population size affects the expected coalescent time?
#  The expected coalescent time appears to scale in direct proportion with population size. 
#  As population size increases or decreases one way or another, the TMRCA is expected to shift accordingly and to the same degree.
#
#
#
##############################################################################################EXERCISE EIGHT#################
#
#POISSON RANDOM VARIABLES
?rpois
#rpois is the random variable generation for the Poisson dist. (there's also dpois, ppois, qpois)
#inputs are n, lambda . n is number of values to return, and lambda is a vector of (non-neg) means
# n is number of "draws", lambda is a rate parameter for the distribution -- rate = expected value (and variance) of the dist.
#
#given rate of occurence (here, 2), over a number of intervals (here, 10) 
#     - how many occurances of an event will there be in a given interval?
rpois(10,2)
#[1] 2 2 3 3 2 3 4 3 3 1
#
#simulate to show that the expected value of a given Poisson distribution is equal to the rate paramter (lambda)
mean(rpois(10000,2))
#[1] 1.9922 ----this mean is approximately 2 (the rate)
#
#getting workable syntax
2*10
1*(10^-4)
#[1] 1e-04
#
#
#
#################################a) add mutations to the geneologies (aka coal. times) simulated in Q6. 
# mu (aka lambda) = 1e-04
# coal. times from Q6 .... 2N = 20,000 . so, 20000 generations (theoretically)
# what is avg. # of SNPs/geneology (the mean! from the poisson)
#
rate8<-1/20000
rexp(10000, rate8) #gets 10,000 simulations of geneologies (coal. times) given 2N = 20,000. 
#10,000 similar/distributed coal. times. given those coal times...each output is an n...10,000 n's / draws for the Poisson
geneologies<-rexp(10000, rate8)
geneologies
#okay
#mean(rpois(geneologies, 1e-04))
#[1] 0 ....hmmmmmmm
#rpois(geneologies, 1e-04)
#all values are zero here.... hmmm
#for geneologies[i-10000]
rate<-1e-04 #no? is rate*geneology value?
rate
for (i in geneologies){
  rate<-1e-04*geneologies[i]
  rpois(i, rate)
  output<-mean(rpois(i,rate))
}
#slow-ish, but not locked up
output
#[1] 0.0001249649
#very close to the rate!
#################################b) What is the average number of SNPs per geneology?
# From my simulation, it appears that the average number of SNPs per geneology closely approximates 
# the given input mutation rate of 0.0002. The number generated through my simulation was ~0.000125
#
#
#################################c) given that Theta = 4N(mu), what is theta predicted to be in this example?
Theta<-2*20000*(1e-04)
Theta
# 4, if working with theoretical values of N and mu . 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~b) TAKE TWO
#feel like my output for b) was incorrect, a my rate did not factor in the length of each geneology as it went
geneologies<-rexp(10000, rate8)
geneologies
#okay
#mean(rpois(geneologies, 1e-04))
#[1] 0 ....hmmmmmmm
#rpois(geneologies, 1e-04)
#all values are zero here.... hmmm
#for geneologies[i-10000]

for (i in geneologies){
  rate<- 1e-04*geneologies #this worked! took out the [i] (had *geneologies[i])
  rpois(i, rate) #appears to output a bunch of values that seem okay....integer numbers, mostly under 5, some up to ~20
  output<-mean(rpois(i,rate))
}
#slow-ish, but not locked up
output
#[1] 1.95577 
1e-04*20000
#[1] 2
# HERE, the output from this simulation appears to approximate the value of mu*number of geneologies....or, mu*coal.time. 
# So, the average number of SNPs per coalescent time (geneology), is approximating the rate of mutation for the 
# theoretical/ideal. parameters
#
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~c) BACK TO C
#################################c) given that Theta = 4N(mu), what is theta predicted to be in this example?
Theta<-2*20000*(1e-04) # = 4N(mu)
Theta
# [1] 2, if working with theoretical values of N and mu . 