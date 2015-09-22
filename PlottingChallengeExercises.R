#Plotting Challenge Exercises - Lohmueller#############################################################

setwd("C:/Users/Hayley/eeb201hayleystansell")
#gets error, cannot change working directory
#fixed - if includes from C-drive downward, no ~/ is required
#assuming that if you just want to put the folder name, then you need the ~/

#need to load HapMap and Pheno files
# Load a data set
snpsDataFrame=read.table('Day2dataset1HAPMAP.txt',header=TRUE)
#okay
dim(snpsDataFrame)

snps=as.matrix(snpsDataFrame)

# With row names we can easily extract certain SNPs using the id's
testSNP<-snps["rs218206_G",]

table(testSNP)
####################Not getting anything to work due to "object 'snps' [and therefore testSNP] not found" error
#Fixed by defining the object "snps" as a matrix of the "snpsDataFrame"


## APPYLING A CHI-SQUARE TEST TO EACH SNP TO FORMALLY LOOK FOR DEPARTURES FROM HARDY-WEINBERG EXPECTATIONS ###

compute_chisquare=function(x){
  freq=sum(x,na.rm=TRUE)/(2.0*sum(!is.na(x)))
  cnt0=sum(x==0,na.rm=TRUE)
  cnt1=sum(x==1,na.rm=TRUE)
  cnt2=sum(x==2,na.rm=TRUE)
  obscnts=c(cnt0,cnt1,cnt2)
  #print(obscnts)
  n=sum(obscnts)
  expcnts=c((1-freq)^2,2*freq*(1-freq),freq^2)*n
  chisq=sum((obscnts-expcnts)^2/expcnts)
  return(chisq)
}

#let's make a second funtion that makes use of R's built in chisq.test function

compute_chisquare_2=function(x){
  freq=sum(x,na.rm=TRUE)/(2.0*sum(!is.na(x)))
  cnt0=sum(x==0,na.rm=TRUE)
  cnt1=sum(x==1,na.rm=TRUE)
  cnt2=sum(x==2,na.rm=TRUE)
  obscnts=c(cnt0,cnt1,cnt2)
  #print(obscnts)
  n=sum(obscnts)
  #here we use the built-in function for the chi-sq distribution:
  exp_probs=c((1-freq)^2,2*freq*(1-freq),freq^2) #note, here we don't multiply by n
  chisq<-chisq.test(obscnts,p=exp_probs, correct = FALSE)$statistic
  return(chisq)
}


# Apply the compute_chi_square function to each snp
chisqs<-apply(snps,1,compute_chisquare)
chisqs2<-apply(snps,1,compute_chisquare_2)

#check to see that the chisquare statistcs are the same:
#first do this by computing Pearson's correlation coefficient:
cor.test(chisqs,chisqs2)

#we can also do a quick scatterplot:
plot(chisqs,chisqs2)


#####SUCCESS! Got basic plot

#add in a vector for P-values, using pchisq() function
#don't completely understand this
?pchisq

pvals<-pchisq(chisqs,1,lower.tail=FALSE)
head(pvals)
###############################################

#Exercises Part B#

#what proportion of p-values (aka vector pvals) are <0.05, <0.01, <0.001?
#Count the number of pvals smaller than the significance threshold

# code below taken from earlier class notes. Not positive what the "mean" means, 
#other than assuming it's giving you the arith. mean p-value for all the ones that are below that significance threshold.
signifthres<-0.05
sum(pvals<signifthres) 
mean(pvals<signifthres) 
#Here, sum is 181 (181 p-values below that threshold)

signifthres<-0.01
sum(pvals<signifthres)
#Here, sum is 41

signifthres<-0.001
sum(pvals<signifthres)
#Here, sum is 5

################################################

#Exercise 1 Part C#

#find out how many SNPs were tested for departures from HW-equilib. How many p-vals do you have? Try using length function.
#Save variable as a value called "num_pval"

?length()
length(pvals)
#4014 p-values
#not sure about syntax
#num_pval<-function(length(pvals)) -----nope
num_pval<-c(length(pvals))
num_pval
#success!!!

###############################################

#Exercise 1 Part D#

#you have num_pval total p-values (4014). #if HWequilib is occuring/true, the smallest p-value is expected to be 1/num_pval
#second smallest expected to be 2/num_pval
#third smallest expected to be 3/num_pval
#etc. 
#LARGEST p-value is expected to be num_pval/num_pval - aka "1". 
#calc/make a vector for expected p-values and name it "exp_pvals"

for (ii in 1:length(pvals)){
  if (ii<=4013){
    exp_pvals<-ii/pvals
  
  else if (ii<-4014)
    exp_pvals<-pvals/pvals
  }
}
exp_pvals

#successfully got some sort of output, but it's showing what looks like a bunch of ID's and values of 1. 



###############################################

# sapply: Apply function to each element of a list or dataframe
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
sapply(x,mean)