#M200A GENETIC DRIFT EXERCISES,Dr. Kirk Lohmueller, Fall 2015
#Hayley Stansell
#
#
getwd()
#
?rbinom
rbinom(3,10,0.1)
#3 random vars from a binom dist. 1st draw = 1/10 success, 2nd = 2/10 success, 3rd = 0/10 success
#[1] 1 2 0
rbinom
#just the function w/ nothing returns a summary of rbinom
#
#
########################################################################################EXERCISE ONE###################
#
#What is the expected number of successes in a sample of size 10 from the binomial dist. with probability of success p=0.1? 
#First, figure this out analytically based on the formulas from class. 
#Second, write a simulation in R to confirm this. 
#
#1)Based on probability p=0.1 (1 in 10 is a success), I would expect to see approximately one success in 10 draws. 
#2)
rbinom(10, 5, 0.1)
#[1] 1 0 0 1 2 0 1 2 0 1
#[1] 0 0 2 0 1 1 0 1 0 1
rbinom(10, 1, 0.1)
#[1] 0 0 0 0 0 0 0 0 0 0
#[1] 0 0 0 0 0 0 1 0 0 0

#################################################################

#simulate genetic drift
#
#p= allele freq (at t)
#N= pop size (number of diploid individs, or number of c-somes in pop)----HERE = number of diploid individs (so, pop has 2N csomes)


