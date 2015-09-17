#Working on an Ordinary Differential Equation (ODE)
#an "ordinary differential equation" is one where you're looking at changes happening to one and only on *independent* variable
#work from eeb201 handout

library(deSolve)

expGrowthODE<-function(tt,yy,pars){
  derivs<-pars['rr']*yy
  return(list(derivs))
}

init<-1
tseq<-seq(0,20, by =0.01)
pars<- c(rr=0.1)
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


###########
#alter values

init<-5
tseq<-seq(0,20, by =0.01)
pars<- c(rr=0.5)
pars['rr']

expGrowthOutput<-lsoda(init, tseq, expGrowthODE, pars)
#output for this expGrowth model coming from the function expGrowthODE and its parameters


head(expGrowthOutput)


plot(expGrowthOutput[,1], expGrowthOutput[,2],col="red", type="l")
#the "type" is an L, not a 1





