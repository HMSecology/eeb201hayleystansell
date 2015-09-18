#Looking at sensitivity of various models

library(deSolve)
#Sensitivity to initial conditions

#Example
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

plot(continuousLogisticOutput[,1], continuousLogisticOutput[,2],col="red", type="l")
#the "type" is an L, not a 1


