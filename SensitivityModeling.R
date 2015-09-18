#Looking at sensitivity of various models

library(deSolve)
#Sensitivity to initial conditions

#Example
#copy/pasting continuous logistic model as base

continuousLogistic<-function(tt,yy,pars){
  derivs<-pars['rr']*(1-(yy/pars['kk']))
  return(list(derivs))
}

init<-1
tseq<-seq(0,150, by =0.1)
pars<- c(rr=.75, kk=100)
pars['rr']
pars['kk']

continuousLogisticOutput<-lsoda(init, tseq, continuousLogistic, pars)
#output for this logistic model coming from the function expGrowthODE and its parameters


head(continuousLogisticOutput)
#time        1
#[1,]  0.0 1.000000
#[2,]  0.1 1.197802
#[3,]  0.2 1.395209
#[4,]  0.3 1.592222
#[5,]  0.4 1.788841
#[6,]  0.5 1.985067

#########################everything works fine above here######################

#assuming all new code is just added in, and that the for loop regarding the ICVector is related to how the data are displayed

ICVector<-seq(0,200,by=10)

########################everything works fine above here#######################
kk<-100

plot(x=NULL, y=NULL, xlim=c(1,max(tseq)), ylim=c(0, (2*kk)), xlab="time", ylab="N", main="Logistic growth")
#inserting new plot code IN PLACE OF prior code
#fixed mismatch of parentheses
#ERROR: object "kk" not found
#add apostrophes around kk - produces ERROR IN 2*"kk" - non-numeric argument to binary operator
#add kk<-100 above plot. produces empty plot with full labels (have not tried to run with for(ii...) argument)



for(ii in 1:length(ICVector)){
  init<-ICVector[ii]
  logisticOutput<-lsoda(init, tseq, continuousLogistic, pars)
  lines(continuousLogisticOutput[,1], continuousLogisticOutput[,2], col="blue", type="l")
}

#######################currently produces a plot!!!####################SUCCESS?????######################################

#the "type" is an L, not a 1

#"make plots for a few values of r"


