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
plot(freqs3[1000,5])