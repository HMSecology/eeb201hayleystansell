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
myResults
#generates a list 100 spots long, but only has the one lambda in the 100th spot. 
#-------------------------------------------------------------------------------------EXERCISE ONE TAKE FIVE
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

myResults
#generates .................NON-ZEROS????? not sure what is different, other than I typed in line 349 "myResults[i]"
#...which returned one value ([1] 10.65872), then deleted that and executed line 350 (myResults) again....anywho...
#
#myResults
#[1] 10.564712 11.124008  7.708430 10.375060 13.133952 13.986790  8.298091  9.377686 13.396869 10.085819 12.701470 13.250707
#[13] 11.169086  8.387705 11.404952  9.347448  9.024440 11.959539 14.255858  9.635809 10.057936  9.614476 10.841234 15.742211
#[25]  8.707598  9.312122 11.890291  7.859690 11.384383  8.029795 15.580418  7.343947  8.879070  7.640789  8.211915 12.011827
#[37]  7.713998 11.937973 10.039225 11.411142  9.474223  8.120601 10.277090  8.736183 13.008636 10.699424  9.035406  9.326144
#[49] 13.838332  9.094192 11.875985 12.204478  9.896398  7.536383 11.828437  7.601313 11.064531 11.596795 12.434150  9.248458
#[61]  8.402248 10.207672  7.313502  9.988052  9.173694 15.454996 10.671979 12.098639 10.821827  9.413293 12.008835 13.660082
#[73] 11.387582 10.027658 12.496453  9.240023  9.231328 12.278881  8.160843 10.022397 14.083078  8.627564 10.177580 10.606892
#[85]  9.432656  9.144337 11.951256  9.892600 12.399523  9.259037  7.944824  9.314829  8.357183 11.571660 12.018892 11.989941
#[97] 11.058536  9.432203  7.024850 10.658719
#
#
#getting the mu's now....
fitDiversitree(tt.func)$pars
fitDiversitree(tt.func)$pars[[2]][[1]] #-------------------this gives the Mu
#
REPS <- 100
REPS
myOtherResults <- numeric(length=REPS)
myOtherResults
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
  fitDiversitree(tt.func)$pars[[2]][[1]] #----------------this gets the mu to output alone
  myOtherResults[i]<- fitDiversitree(tt.func)$pars[[2]][[1]] 
  #   fitDiversitree(tt.func)$pars[[2]][[1]] is now the result of our simulation.
  #   We will now store it in the results vector: 
  #-----------------myOtherResults[i] <- blahblahblah
  
  
}

myOtherResults
#SUCCESSSSSSSSSSSSSSSSSSSSSS
#
#[1]  4.1602748  3.3604050  3.9721578  3.2643795  5.3414809  2.5541560  1.0037616  7.3351755  4.3562698  4.6550336  5.0948197
#[12]  1.5325401  6.1138542  7.1273304  7.1356341  6.2412195  3.5424101 11.2674436  5.8280635  7.2550040  6.2367642  6.6540193
#[23]  5.3633383  9.2158400  1.5993553  5.6610975  8.1234886  3.9598577  0.7327271  3.9020943  6.0997813 11.6405883  6.8936827
#[34]  4.4113915  5.6216974  7.1837047  7.6269408  5.2894016  4.9042839  1.9210246  9.6895312  4.2400289  7.4610566  8.9210247
#[45]  6.7751818  2.3434504  9.0600976  8.5281644  7.2899214  4.5185287  6.5670865  3.2768220  5.4604314 13.1431611  4.6500448
#[56]  2.6104927  7.7616513  6.2347909  6.1350106  4.9223879  9.2609719  5.5751135  5.7480986 12.6527846  2.5172855  3.4272587
#[67]  6.8105193  6.9155924  7.5728745  3.5185637  8.3162703  4.6684416 10.3750073  5.5014250  6.6043708  6.9813688  1.2979342
#[78]  5.2058009  5.0648929  3.8844985  6.9450091  4.4604918  6.3111104  3.6921491  6.8908605  2.9439830  6.1173978  4.8446970
#[89]  5.4738218  2.3932389  5.6306194 11.5228453  9.3228118  4.2943635  8.6552660  4.4840239  8.3229169  7.0301236  3.2278562
#[100]  9.1786562
hist(myResults, main = "Lambda(birth) for 100 Trees")
hist(myOtherResults, main = "Mu(death) for 100 Trees")
?hist
#
#
#
###########################################################################################EXERCISE 2##########################
#
#Simulate 100 more trees with constant birth/death. Extract number of species from each tree (results vector mySpecies). 
#need to remove fitting the bd model, remove maximum taxa
#
#
setwd("C:\\Users\\Hayley\\eeb201hayleystansell")
source('rabosky_functions.R')
#
REPS <- 100
REPS
mySpecies <- numeric(length=REPS)
mySpecies
?numeric
for (i in 1:REPS){
  
  #  Here we would do the simulation:
  
  #---------------------previous simulation: tmp <- rnorm(10)
  
  # Using function simulateTree to simulate a birth death tree:
  # Example, lambda = 7, mu = 5
  pars <- c(5,5); #in order: lambda, mu
  tt <- simulateTree(pars, max.taxa=Inf, max.t=100, include.extinct=T) #simulating 100 trees, #NEED TO REMOVE MAX TAXA....or not, changing to 1000 to see
                                                                  #changing max.taxa to Inf....TAKES TOO LONG? adding a max.t = 500
                                                                  #still getting long run time ....adding "include.extinct=F")
        #the problem seems to be with 445 "tt", so removing that, instead looking for just Nnode. 
        #A-HA! - setting lambda an mu equal to one another got it to stop running indefinitely. 
  #tt
  tt$Nnode
  
  #THIS IS CURRENTLY RUNNING FOR A LONG TIME, NOT SURE IF THERE'S A LOOP ISSUE OR JUST TAKES A WHILE. ABLE TO HIT "STOP" AND GET ">" BACK
  #mySpecies[i]<-number of tips for tt
  mySpecies[i]<-((tt$Nnode) + 1) #no problems here
  
}

#tt$Nnode #this is a valid command. if has 1000 tips and 999 internal nodes, tips = nodes +1 ?
#getting a long run-time with addition of mySpecies[i] line 445
#FINISHED after ~5 min
mySpecies
#okay, have a list of 100 values, but they are all 1000.....
?simulateTree
??simulateTree
?simulate
#OKAY - need command " View(simulateTree) "