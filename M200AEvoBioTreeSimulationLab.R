#M200A Evolutionary Biology Tree Simulation Lab
#
#
library(geiger)
library(phytools)
#trouble loading phytools
getwd()
setwd("C:\\Users\\Hayley\\eeb201hayleystansell")
getwd()
library(geiger)
library(phytools)
#still no phytools
library(phytools)
#got it
library(diversitree)
#need to get this one too
#got it
#
source('rabosky_functions.R')
#got it
#
#
# Using function simulateTree to simulate a birth death tree:
# Example, lambda = 10, mu = 5
pars <- c(10, 0); #in order: lambda, mu
tt <- simulateTree(pars, max.taxa=100)

##simulate under BD and fit gamma
## is confidence in speciation or extinction better?
## regression
## show loop construct
## pull lambda and mu

plot(tt,  show.tip.label = F)
#tree successfully produced....
#
#What have we done? 
#Using functions in diversitree we specify parameters for a birth death tree (with the pars() function). 
#Next we use the function simulateTree to make a tree with those parameters. 
#
#We can now FIT a birth-death model to this tree. Here we know the true speciation and extinction rates. 
#Lets see how well we can estimate those from a tree with 100 tips. 
#To fit a model to a tree in diversitree we have to 
#1) create a likelihood function based on the tree and 
#2) pass that funciton to another function called fitDiversitree().
#
# use function diversitree::make.bd  ----birth death model
# fit model with fitDiversitree
# Example:
#   my_likelihood_fxn <- make.bd(....likelihood....)
tt.func <- make.bd(tt)
fitDiversitree(tt.func)
##############################OUTPUT
#$pars
#lambda       mu 
#10.86981  0.00100 
#
#$loglik
#[1] 494.9562
#
#$AIC
#[1] -985.9125
#
#$counts
#function gradient 
#13       13 
#
#$convergence
#[1] 0
#
#$message
#[1] "CONVERGENCE: REL_REDUCTION_OF_F <= FACTR*EPSMCH"
################################
#What values of lambda and mu did you get? - lambda: 10.86981 , mu: 0.00100
#How do these compare to your original simulation? - lambda: 10 , mu: 5
#
#
#
###################################################################################EXERCISE 1###########################
#
#lambda = birth rates, mu = death rates
#
#simulate 100 trees with same birth and death rates (non-zero). 
# -----------Assuming this means that lambda and mu are the same tree to tree, not that lambda = mu...?
#
# General template for simulations:
# In this example, we will just
#  generate a single random number 
#  for each replicate simulation, then
#  store the results in a vector. --------------NEED 100 reps

REPS <- 100
myResults <- numeric(REPS)
#okay
for (i in 1:REPS) {
  
  #  Here we would do the simulation: 
  pars <- c(6, 2); #in order: lambda, mu
  treeresult <- simulateTree(pars, max.taxa=100)
  plot(treeresult,  show.tip.label = F)
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  myResults[i] <- treeresult
  
}
#There were 50 or more warnings....
warnings()
#ALL "In myResults[i] <- treeresult: number of items to replace is not a multiple of replacement 
#
#try moving parameters outside the loop?
REPS <- 100
myResults <- numeric(REPS)
pars <- c(5, 1); #in order: lambda, mu
#okay
for (i in 1:REPS) {
  
  #  Here we would do the simulation: 
  treeresult <- simulateTree(pars, max.taxa=100)
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  myResults[i] <- treeresult
  
}
#still getting over 50 warnings, same message
warnings()
?warnings
#
#go back to pseudocode-------------------------------------------
REPS <- 5
myResults <- numeric(REPS)
for (i in 1:REPS){
  
  #  Here we would do the simulation: 
  tmp <- rnorm(1)
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  myResults[i] <- tmp
  
}
#this has no problem, 
#change to 100, no problem
#the simulation is the tree simulation, so that should be there in the for loop......
??fitDiversitree
REPS <- 100
REPS
myResults <- numeric(length=REPS)
myResults
?numeric
for (i in 1:REPS){
  
  #  Here we would do the simulation:
  
  #---------------------previous simulation: tmp <- rnorm(10)
  
  # Using function simulateTree to simulate a birth death tree:
  # Example, lambda = 10, mu = 5
  pars <- c(10, 5); #in order: lambda, mu
  tt <- simulateTree(pars, max.taxa=100) #simulating 100 trees
  tt
  tt.func <- make.bd(tt)
  fitDiversitree(tt.func) #fitting those 100 trees to a birth-death model, no errors!
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  #----------------------previous results: myResults[i] <- tmp
  ########################myResults[i] <-length(tt)
  
}
summary(fitDiversitree(tt.func))
finaloutput<- summary(fitDiversitree(tt.func))
finaloutput[[1]][[1]]
finaloutput[1][1]
names(fitDiversitree(tt.func))
fitDiversitree(tt.func)$pars
#Warning messages still there....
#the PROBLEM is with myResults [i] <- tt
#checking what "tt" and "myResults" looks like
#betting that i'm getting 100 error messages, and it's this message being repeated for each run (100x)
#myResults looks WEIRD in that it shows a list going 1-100, with 1-99 as follows: [[1]][1] 0 
#.............then, at [[100]], there is this other layer that comes out that's another matrix with some odd numbers
#trying change "numeric(REPS)" to numeric(length=REPS)?
#looking better? getting a list of zeros that appears to be 100 long
warnings()
#same error messages.....
#..................................ADDING "length" into line 170 seems to have killed the error messages
myResults[i]
#output is [1] 5 .........????
tt.func <- make.bd(tt)
fitDiversitree(tt.func)
#$pars
#lambda       mu 
#14.35130 11.03408 
#
#$loglik
#[1] 469.3121
#
#$AIC
#[1] -934.6242
#------------------------^sample output
#
#----------------------------------------------------------------------STARTING EXERCISE ONE AGAIN-------------------
REPS <- 100
REPS
myResults <- numeric(length=REPS)
myResults
?numeric
for (i in 1:REPS){
  
  #  Here we would do the simulation:
  
  #---------------------previous simulation: tmp <- rnorm(10)
  
  # Using function simulateTree to simulate a birth death tree:
  # Example, lambda = 10, mu = 5
  pars <- c(10, 5); #in order: lambda, mu
  tt <- simulateTree(pars, max.taxa=100) #simulating 100 trees
  tt
  tt.func <- make.bd(tt)
  fitDiversitree(tt.func) #fitting those 100 trees to a birth-death model, no errors!
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  #----------------------previous results: myResults[i] <- tmp
  ########################myResults[i] <-length(tt)
  
}
summary(fitDiversitree(tt.func))
finaloutput<- summary(fitDiversitree(tt.func))
finaloutput[[1]][[1]]
finaloutput[1][1]
names(fitDiversitree(tt.func))
fitDiversitree(tt.func)$pars
#   lambda        mu 
#10.208447  5.592388 
#this is good - it's showing a lambda and a mu...... need a list though? shouldn't it be 100 lambda's, 100 mu's?
?list
as.list(fitDiversitree(tt.func)$pars)
#got the same output, just in a "list"
#$lambda
#[1] 10.20849
#
#$mu
#[1] 5.592448
#-------------------------------------------------------------------------------------EXERCISE ONE TAKE THREE
REPS <- 100
REPS
myResults <- numeric(length=REPS)
myResults
?numeric
for (i in 1:REPS){
  
  #  Here we would do the simulation:
  
  #---------------------previous simulation: tmp <- rnorm(10)
  
  # Using function simulateTree to simulate a birth death tree:
  # Example, lambda = 10, mu = 5
  pars <- c(10, 5); #in order: lambda, mu
  tt <- simulateTree(pars, max.taxa=100) #simulating 100 trees
  tt
  tt.func <- make.bd(tt)
  fitDiversitree(tt.func) #fitting those 100 trees to a birth-death model, no errors!
  summary(fitDiversitree(tt.func))
  finaloutput<- summary(fitDiversitree(tt.func))
  fitDiversitree(tt.func)$pars
  
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  #----------------------previous results: myResults[i] <- tmp
  ########################myResults[i] <-length(tt)
  
}
as.list(fitDiversitree(tt.func)$pars)
#still no errors, good..................but just again, one value per thing.....
?pars
??pars
??lambda
#-------------------------------------------------------------------------------------EXERCISE ONE TAKE FOUR
REPS <- 100
REPS
myResults <- numeric(length=REPS)
myResults
?numeric
for (i in 1:REPS){
  
  #  Here we would do the simulation:
  
  #---------------------previous simulation: tmp <- rnorm(10)
  
  # Using function simulateTree to simulate a birth death tree:
  # Example, lambda = 10, mu = 5
  pars <- c(10, 5); #in order: lambda, mu
  tt <- simulateTree(pars, max.taxa=100) #simulating 100 trees
  tt
  tt.func <- make.bd(tt)
  fitDiversitree(tt.func) #fitting those 100 trees to a birth-death model, no errors!
  summary(fitDiversitree(tt.func))
  finaloutput<- summary(fitDiversitree(tt.func))
  fitDiversitree(tt.func)$pars[[1]][[1]] #----------------this gets the lambda to output alone
  myResults[i]<- fitDiversitree(tt.func)$pars[[1]][[1]] #-----------------nothing bad happening here....
  #   tmp is now the result of our simulation.
  #   We will now store it in the results vector: 
  
  #----------------------previous results: myResults[i] <- tmp
  ########################myResults[i] <-length(tt)
  
}
as.list(fitDiversitree(tt.func)$pars)
#still no errors, good..................but just again, one value per thing.....
