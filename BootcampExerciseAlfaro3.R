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

bankAccounts<- c(10, 9.2, 5.6, 3.7, 8.8, 0.5) #had to remove the space between "bankAccounts" and "<-"

compounded<-rep(NA,6)


interestRate <- 0.0125;
for (i in 1:length(bankAccounts)) {
  compounded[i] <- interestRate*bankAccounts[i] + bankAccounts[i]; }

compounded
# [1] 10.12500  9.31500  5.67000  3.74625  8.91000  0.50625

#can also just define "compounded" not as rep(NA,6), but as the equation compounded<- interestRate*bankAccounts + bankAccounts
#can ALSO define compounded as c(1:6), which effectively creates a vector of 6 "blanks", or tells it 6 iterations
#btw, a vector that is a string of values can also be considered a matrix of one row. A vector can also be a multi-row matrix...
#therefore, you can also tell R that "compounded<-matrix[1:6]


#Exercise Number 6 ########################################################

interestRate<-0.0525
bankAccounts<- c(10, 9.2, 5.6) 
house<- c(4.8, 3.8, 5.7) #deduct
food<- c(3.5, 4.3, 5.0)    #deduct
fun<- c(7.8, 2.1, 10.5)  #deduct
expenses<-house+food+fun
#can probably write expenses as a function where you are adding via indexing?

# incomes (through TAships) of 
income <- c(21, 21, 21) #add this

for (j in 1:5) {
  for (i in 1:length(bankAccounts)){
    bankAccounts[i] <- bankAccounts[i]+income[i]-expenses[i]
    bankAccounts[i]<-  bankAccounts[i]*interestRate+bankAccounts[i]
  }
}
bankAccounts
    #step 1 modify bankAccounts so that amounts reflect income and expenses
    #step 2 get calculate interest and add to accounts from step 1
    #you can actually use the line you have already written if you
    #modify amounts in bankAccounts directly in step 1



#Exercise Number 7 #######################################################

#given estimates for 3 students' expense of housing, food, and fun
house<- c(4.8, 3.8, 5.7)
food<- c(3.5, 4.3, 5.0)
fun<- c(7.8, 2.1, 10.5)
expenses<-house+food+fun
bankAccounts<- c(10, 9.2, 5.6) 
#and incomes (through TAships) of 
income<- c(21, 21, 21)

interestRate<-0.0525

#Modify the 5-year interest-compounding code from #5 and #6 so that it runs from 2015-2020 
#and so that in odd numbered years students 1 and 3 get trust fund disbursements of $5000. 
#(hint the modulus function %% will be helpful )
# %% 2==0 sets the condition to if "even numbers", %% 2==1 sets it to if "odd aka not-even numbers" 
#I think this must be a true=0, false = 1


for (time in 2015:2020){
  for (i in 1:length(bankAccounts)) {
    bankAccounts[i]<- bankAccounts[i]+income[i]-expenses[i]
    if (time %% 2==1){
      if(i==1|i==3){
        bankAccounts[i]<-bankAccounts[i]+5
      }
    }
    bankAccounts[i]<-bankAccounts[i]*interestRate+bankAccounts[i]
  } 
}

bankAccounts




#Exercise Number 8 ###########################################################
#153 should be the final value
xx<-seq(1:17)

#trying without the sequence. This does not work because it is looking for any time xx is less than 17. 
#The highest xx value you get is 32 because it loops up until there is xx<-16+16, yielding a new xx of 32, which breaks the loop
xx<-0
total<-0
while(xx<17){
 xx<-xx+1
 total<-total+xx
 print(xx) 
}

total
#needed two variables (xx and total). XX was set to zero so that the output of the first loop would be 1 (vs xx<-1+1, <-2).
#total is used to tell R to work with the totals and not just add xx's together. You want to add a given xx value to an existing total.




#Exercise Number 9 ###########################################################


