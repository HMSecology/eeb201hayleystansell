#Writing a logistic growth model in continuous time

library(deSolve)

expGrowthODE<-function(tt,yy,pars){
  derivs<-pars['rr']*(1-(yy/pars['kk']))
  return(list(derivs))
}

init<-1
tseq<-seq(0,150, by =0.1)
pars<- c(rr=2, kk=100)
pars['rr']

expGrowthOutput<-lsoda(init, tseq, expGrowthODE, pars)
#output for this expGrowth model coming from the function expGrowthODE and its parameters


head(expGrowthOutput)
#yield:
#     time        1
#[1,] 0.00 1.000000
#[2,] 0.01 1.001001
#[3,] 0.02 1.002002
#[4,] 0.03 1.003005
#[5,] 0.04 1.004008
#[6,] 0.05 1.005013

plot(expGrowthOutput[,1], expGrowthOutput[,2],col="blue", type="l")
#the "type" is an L, not a 1

####SUCCESS!!!!##########
