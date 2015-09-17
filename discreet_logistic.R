#Basic Script for Logistic population growth


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

#
##################################
#CHANGING OVER TO LOGISTIC EQUATION
#


rr=0.25
ttMax=50
N0<-10
NN<-matrix(NA, nrow=1, ncol=ttMax+1)
NN[1]<-N0
KK=100
for (tt in 1:ttMax){
  NN[tt+1]<-NN[tt]*
    (1+(rr*(1-(NN[tt]/KK))))
}

#Need to define everything, including rr
#be VERY careful with parentheses/brackets, that they match in number and type
#the only thing you are indexing here/putting brackets is "tt"-time. that's because time is the input that is changing, and being the source of each output
#^right?


plot(1:(50+1), NN, xlab="time", ylab="N", type="b", col='blue')
#again with putting a real number in for time, vs. ttMax+1
#something about it being inside or outside of the function - WHY??


#
#converting script to a function
#

discretelogisticfun<- function(N0, ttMax, rr){
  NN<-matrix(NA, nrow=1, ncol=ttMax+1)
  NN[1]<-N0
  for (tt in 1:ttMax){
    NN[tt+1]<-NN[tt]*
      (1+(rr*(1-(NN[tt]/KK))))
  }
  return(NN)
}

#testing functionality
#REMEMBER that you have to "pull" the return/result out from the function. Like, answer<-function(thisScript,theseparameters)
#here, NN is your answer/return
#so,

NN<-discretelogisticfun(N0=15, ttMax=25, rr=0.1)
#add in how to plot:
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='green')

#SUCCESS!

#TIP: be VERY CAREFUL with matching values, variables, parameters, etc.



