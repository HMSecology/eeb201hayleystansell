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

NN<-discretelogisticfun(N0=15, ttMax=25, rr=0.8)
#add in how to plot:
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='green')

#SUCCESS!

#TIP: be VERY CAREFUL with matching values, variables, parameters, etc.


###########################
#3.3.2 MINI EXERCISE
variousR<-c(-0.3, 0.3, 1.3, 1.9, 2.2, 2.7)
variousR
rr<-variousR
par<-(mfrow=c(2,3))
NN<-discretelogisticfun(N0=10, ttMax=25, rr=variousR)
#DID I NEED TO ADD KK as a defineable variable?
#otherwise you get KK as an "unused argument" - I happened to set KK=100 right away in creating the function

plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='red')


warnings()
#TONS OF WARNINGS saying the number of items to replace is not a multiple of replacement length
#thinking I need to redefine my function, will edit below:

#converting script to a function
#

discretelogisticfunTEST<- function(N0, ttMax, rr=variousR){
  NN<-matrix(NA, nrow=1, ncol=ttMax+1)
  NN[1]<-N0
  variousR
  par<-(mfrow=c(2,3))
  for (tt in 1:ttMax){
    NN[tt+1]<-NN[tt]*
      (1+(rr*(1-(NN[tt]/KK))))
  }
  return(NN)
}
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='blue')
#did not work, probably because I haven't used the actual new function (which works on its own, or at least has no errors)

NN<-discretelogisticfunTEST(N0=10, ttMax=25)
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='blue')
#still no errors, but no iterations with various RR

NN<-discretelogisticfunTEST(N0=10, ttMax=25, rr=variousR)
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='blue')
#same as before, no errors but no new plot showing

#Editing function again

discretelogisticfunTEST<- function(N0, ttMax=25, rr){
  NN<-matrix(NA, nrow=1, ncol=ttMax+1)
  NN[1]<-N0
  variousR
  par<-(mfrow=c(2,3))
  for (rr in variousR){
    NN[variousR]<-NN[rr]*
    (1+(rr*(1-(NN[tt]/KK))))
  }
  return(NN)
}
plot(1:(25+1), NN, xlab="time", ylab="NN", type ="b", col='blue')
#????? the function should stay all the same, but I need to tell it that I want it to use a different rr each time. I want it to index by time to get it to plot at each time point?
#but also want to tell it to make multiple plots using each r

discretelogisticfunTEST<- function(N0, ttMax=25, rr=variousR){
  NN<-matrix(NA, nrow=1, ncol=ttMax+1)
  NN[1]<-N0
  variousR
  par<-(mfrow=c(2,3))
  for (tt in 1:ttMax && rr in variousR()){
    NN[tt+1]<-NN[tt]*
      (1+(rr*(1-(NN[tt]/KK))))
  }
  return(NN)
}

#?????still lost on this. information online about how to request two conditions in a for statement not useful


