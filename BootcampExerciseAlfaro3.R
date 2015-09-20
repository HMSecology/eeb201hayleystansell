#Exercise Number 3 on "Bootcamp Exercises" sheet from day 1 ###################

#"by hand, figure out the initial values of these variables and values at the start and end of each iteration of the loop

#dogs1 - initial value set at 10, outputs final value of 11
#dogs2 - initial value set at 11, outputs final value of 12
#dogs3 - initial value set at 12, outputs final value of 13
#dogs4 - initial value set at 13, outputs final value of 14
#dogs5 - initial value set at 14, outputs final value of 15


#meatloaf1 - inital value set at 0, outputs (0-5+1) final value of -4
#meatloaf2 - inital value set at -4, outputs (-4-6+1) final value of -9
#meatloaf3 - inital value set at -9, outputs (-9-7+1) final value of -15
#meatloaf4 - inital value set at -15, outputs (-15-8+1) final value of -22
#meatloaf5 - inital value set at -22, outputs (-22-9+1) final value of -30


#bubbles1 - initial value set at 12, BUT does not factor into the loop; therefore, output is -1
#bubbles2 - initial value set at -1, BUT does not factor into the loop; therefore, output is -2
#bubbles3 - initial value set at -2, BUT does not factor into the loop; therefore, output is -3
#bubbles4 - initial value set at -3, BUT does not factor into the loop; therefore, output is -4


#Exercise Number 4 ############################################################

###you can use the if statement with the modulus operator to conditionally perform operations
years <- c( 2015, 2016, 2018, 2020, 2021)


for(ii in 1:length(years)){
  if(years[ii] %% 2 ==0){
    cat(years[ii], "Hooray, congressional elections!", sept="\t", fill=T)
  }
  else{
  cat(years[ii], "Say what? It's a presedential election!", sept= "\t", fill=T)
  }
}



#Exercise Number 5 ###########################################################

#