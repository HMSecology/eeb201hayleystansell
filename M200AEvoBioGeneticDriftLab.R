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
#
p<- 0.1
N<- 10
count<- rbinom(1,2*N, p)
count
#[1] 2
count/(2*N)
#[1] 0.1
#
#####################################################################################EXERCISE TWO#######################
#
#Write an R-function that simulates T generations of genetic drift for L independent SNPs. 
#Keep track of allele freq's of each of the L-SNPs in each of the T-generations. 
#All SNPs should start in the initial generation at frequency "p"
#
#Hint: Initialize a matrix to keep track of the freqs in each generation:
# T<- 5 
# L<- 3
# freqs<- matrix(nrow=T,ncol=L) #sets up framework for matrix to get allel freqs each generation.
#                                 each ROW is a generation, each COLUMN is a SNP
#Hint: First row of this matrix can/should have the initial allele frequency (p). 
#       Write a loop that will iterate through each generation and perform binom sampling.
#
T<- 8
L<- 3
freqs<- matrix(nrow = T, ncol = L)
freqs
#success!
#saying that pInitial(or pPrev)=0.25, N(size)=100 individuals, n(aka L)= 3 indept. SNPs
#so, pCurrent= count/(2N), and count= rbinom(3, 2*100, pPrev) for each. pCurrent becomes pPrev each new generation
#pPrev is all SNPs having p of 0.25
freqs[1,]<-0.25
freqs[1,]
N<-100
for(i in 2:T){
  count<- rbinom(L,2*N, freqs[(i-1),])
  freqNew<-(count/(2*N))
  freqs[i,]<-freqNew
}
freqs
#[,1]  [,2]  [,3]
#[1,] 0.250 0.250 0.250
#[2,] 0.295 0.280 0.265
#[3,] 0.310 0.300 0.275
#[4,] 0.270 0.370 0.235
#[5,] 0.305 0.365 0.230
#[6,] 0.405 0.350 0.210
#[7,] 0.475 0.310 0.250
#[8,] 0.510 0.260 0.285
#
#
#############################################################################################EXERCISE THREE###################
#
#Use the function just written to simulate drift with these parameters:
N<-100
L<-1000
T<-10000
p<-0.1
#
#
freqs3<- matrix(nrow = T, ncol = L)
freqs3
#success!
#saying that pInitial(or pPrev)=0.25, N(size)=100 individuals, n(aka L)= 3 indept. SNPs
#so, pCurrent= count/(2N), and count= rbinom(3, 2*100, pPrev) for each. pCurrent becomes pPrev each new generation
#pPrev is all SNPs having p of 0.25
freqs3[1,]<-0.1 #this is the pPrev(pInitial)
freqs3[1,]
for(i in 2:T){
  count<- rbinom(L,2*N, freqs3[(i-1),])
  freqNew3<-(count/(2*N))
  freqs3[i,]<-freqNew3
}
freqs3
#Success!!!
#data matrix too big to just paste here
#
#
#
###################################a) How many SNPs(L=1000) @ T=10,000 are at freq 0?
#   row=T, so at [10,000,], values = 0 --- L=0 at that point
?sum
?frequency
#frequency of zeros at [10000, ], freq that L's are zero
########################### == ----says if X == # ...if x equal to a number. So, X == 0, "tests" include < , > , and ==
sum(freqs3[10000, ] == 0) 
#[1] 906
#success!!
###################################b) How many are at frequency 1?
sum(freqs3[10000, ] == 1) 
#[1] 94
###################################c) Does this value agree with theoretical prediction for prob of fixation of a neutral?
#Yes, this supports the idea that as time progresses, a given allele will either drop out of existence 
#or become present across the whole population...becoming "fixed". 
#
#
###################################d) Make a plot of freq. trajectories for 100 SNPs. 
# 100 columns all rows .... freqs3[10000,100]
# x is 0-10000, y is 0-1
#try a small number freqs3[1000,5]

matplot(freqs3 [1:1500, 1:100], type= "l", lty = 1)
#
#
##################################dcontinued) repeat, but change p to 0.6 
N<-100
L<-1000
T<-10000
p<-0.6
#
#
freqs3<- matrix(nrow = T, ncol = L)
freqs3
#success!
#saying that pInitial(or pPrev)=0.25, N(size)=100 individuals, n(aka L)= 3 indept. SNPs
#so, pCurrent= count/(2N), and count= rbinom(3, 2*100, pPrev) for each. pCurrent becomes pPrev each new generation
#pPrev is all SNPs having p of 0.25
freqs3[1,]<-0.1 #this is the pPrev(pInitial)
freqs3[1,]
for(i in 2:T){
  count<- rbinom(L,2*N, freqs3[(i-1),])
  freqNew3<-(count/(2*N))
  freqs3[i,]<-freqNew3
}
matplot(freqs3 [1:1500, 1:100], type= "l", lty = 1)
#success
#
##################################e) How many of the 1000 SNPs are at freq 0 at T = 10000
sum(freqs3[10000, ] == 0) 
#[1] 892
##################################f) How many are at freq 1 at T = 10000
sum(freqs3[10000, ] == 1)
#[1] 108
#################################g) Does this agree with the theoretical prediction for fixation?
#Like the previous simulation, I think this agrees with the idea of fixation for a neutral allele, 
#as most of the frequencies have shifted to frequency of 0. The result is not as extreme as it was for p = 0.1
#As p approaches 0.5, transmission of alleles becomes more of a random-chance situation, so time to fixation (or probability
#of fixation) becomes longer (as the probability decreases).
#
#
#
#
#
######################################################################################EXERCISE FOUR#######################
#try using mfrow...... par (mfrow = )
#
#repeat simulation, with N=10, 500, 1000 . p = 0.1, L = 1000, T = 10000
#
#
# Make population N = 10
N<-10
L<-1000
T<-10000
p<-0.1
#
#
freqs4a<- matrix(nrow = T, ncol = L)
freqs4a
freqs4a[1,]<-0.1 #this is the pPrev(pInitial)
freqs4a[1,]
for(i in 2:T){
  count<- rbinom(L,2*N, freqs4a[(i-1),])
  freqNew4a<-(count/(2*N))
  freqs4a[i,]<-freqNew4a
}
#success! 4a
#plot 4a
matplot(freqs4a [1:200, 1:300], type= "l", lty = 1, main = "Drift for Population Size 10 for 10000 gen", xlab = "Generations")
#SUCCESS
#
#
#Make population N= 500
N<-500
L<-1000
T<-10000
p<-0.1
#
#
freqs4b<- matrix(nrow = T, ncol = L)
freqs4b
freqs4b[1,]<-0.1 #this is the pPrev(pInitial)
freqs4b[1,]
for(i in 2:T){
  count<- rbinom(L,2*N, freqs4b[(i-1),])
  freqNew4b<-(count/(2*N))
  freqs4b[i,]<-freqNew4b
}
#success! 4b
#plot 4b
matplot(freqs4b [1:7000, 1:300], type= "l", lty = 1, main = "Drift for Population Size 500 for 10000 gen", xlab = "Generations")
#SUCCESS
#
#
#Make population N= 1000
N<-1000
L<-1000
T<-10000
p<-0.1
#
#
freqs4c<- matrix(nrow = T, ncol = L)
freqs4c
freqs4c[1,]<-0.1 #this is the pPrev(pInitial)
freqs4c[1,]
for(i in 2:T){
  count<- rbinom(L,2*N, freqs4c[(i-1),])
  freqNew4c<-(count/(2*N))
  freqs4c[i,]<-freqNew4c
}
#success! 4c
#plot 4c
matplot(freqs4c [1:10000, 1:300], type= "l", lty = 1, main = "Drift for Population Size 500 for 10000 gen", xlab = "Generations")
#SUCCESS!
#
#
#
#############################################b) Based on the plots, how does pop. size affect allele freq. change?
# The larger a population size is, the longer it takes for alleles to become fixed at either frequency 1 or frequency zero. 
#

#############################################c) For each pop. size, in what proportion of simulation replicates
# did the derived allele become fixed by the end of the simulation?
# From the plots, it seems that more replicates became fixed at the derived allele in populations of larger size. Among all populations
# it appears that for many replicates that drop to zero, they do so quickly. However, when comparing calcuated proportions, 
# the relative proportions of fixed vs lost (or fixed at 1, 0) alleles seem to be the same.

#############################################d) How is this probability affected by the pop. size?
# The probability of fixation for the derived allele seems to decrease with increase in population size. Given that 
# for a population of 1000, the number of alleles fixed at 1 or 0 was essentially equivalent for the number in a pop. of 100, 
# it appears that while the relative proportion of fixed vs lost alleles is the same - in the larger population, the overall
# number of alleles which are fixed *in the first place* at a given time is an order of magnitude less. 

#############################################e) How does this prob. of fixation estimated from the simulations match
#with the theoretical prediction?
# This appears to fit with theory, in that large populations tend to maintain greater allelic diversity through time, while
# small populations are much more prone to having alleles become fixed or loss due to the course of neutral genetic drift. 
# 
#FROM EXERCISE 3: (N= 100)
sum(freqs3[10000, ] == 0) 
#[1] 892
sum(freqs3[10000, ] == 1)
#[1] 108
#FROM EXERCISE 4: (N= 1000)
sum(freqs4c[10000, ] == 0)
#[1] 891
sum(freqs4c[10000, ] == 1)
#[1] 107