#Basic Script for Geometric population growth
#simulates a discrete logistic model

N0<-25
RR<-1.05
ttMax<-100
#ttMax is total number of timesteps to simulate

NN<-matrix(NA, nrow=1, ncol=ttMax+1)
#initializes a vector assigned to variable NN, will produce NA values
#this is a matrix with one row, and with number of columns=ttMax+1 (here 101), and with each entry being NA so it can be filled in
NN[1]<-N0
#sets first value to initial condition (as opposed to NA, because you have that initial value)

#Loop this code over the ttMax timesteps (here 100), using the modeling EQ to update NN. "For times in range of 1:100, run this equation"

for (tt in 1:ttMax){
  NN[tt+1]<-RR*NN[tt]
}
NN

#Plot results (range of 100 --1 to 101 on x, population at that time on Y)
plot(1:(ttMax+1), NN, xlab="time", ylab="N", type="b", col='blue')

#############################################################################################

#Creating a function from this script

geometricgrowthfun <- function(N0, RR, ttMax){
  NN<-matrix(NA, nrow=1, ncol=ttMax+1)
  NN[1]<-N0
  for (tt in 1:ttMax){
    NN[tt+1]<-RR*NN[tt]
  }
  return(NN)
}

#Testing above function's functionality

NN<-geometricgrowthfun(N0=55, RR=0.5, ttMax=30)
plot(1:(30+1), NN, xlab="time", ylab="N", type="b", col='green')
#?????getting the same basic geometric curve no matter the RR value????
#first issue - needed to call an actual result from the function - here, it's "NN", NN is the RESULT of the function(x,y,z)
#second issue - despite entering a ttMax of 30 in the parentheses of geometricgrowthfun, it was only located in the function. 
# -the ttMax that is listed as the Max of the x-axis is SOMEHOWWWWWW??? not connected with the ttMax that is located in the function's parentheses
# -do not understand why this connection does not exist

ttMax
