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

#exp_pvals<-(1:length(pvals))/pvals
#exp_pvals
#^tried after trying code below. generates what look more like real numbers, not sure if any approach one.
?max()
#max(exp_pvals, na.rm=TRUE)
#outputs a GIANT number as the maximum......not good.

#exp_pvals<-(1:length(num_pval))/num_pval
#exp_pvals
#still getting huge numbers

#exp_pvals<-(1:num_pval)/num_pval
#exp_pvals
#still huge.....?

#for (ii in 1:length(pvals)){
#  if (ii<=4013){
#   exp_pvals<-ii/pvals
#  
#  else if (ii<-4014)
#    exp_pvals<-pvals/pvals
#  }
#}
#exp_pvals
#successfully got some sort of output, but it's showing what looks like a bunch of ID's and values of 1. 

#exp_pvals<-(1:length(pvals))/pvals

#moving on for the sake of continuing

###############################################

#Exercise 1 Part E#

exp_pvals<-(1:num_pval)/num_pval
exp_pvals
#bumping this down

?sort()
sort_pvals<-sort(pvals, decreasing=FALSE)
sort_pvals
#THESE pvalues all are under 1, increasing to exactly one. 

###############################################

#Exercise 1 part F#

??"-log10"
??"sort_log"
??"sort"
??"sort&&log"
??"log10"

log_sort_pvals<- -(log10(sort_pvals))
head(log_sort_pvals)
log_exp_pvals<- -(log10(exp_pvals))
head(log_exp_pvals)

###############################################

#Exercise 1 part G#

??"QQplot"
#Internet tells me that a QQplot is effectively just showing deviance (or lackthereof) of sample values from expected values
#suggests theoretical values on the x, sample values on the y
?plot

plot(x=log_sort_pvals, y=log_exp_pvals, xlab="Actual P-values", ylab= "Expected P-values")
dev.off()
#no plot is showing with this one
#changing <- 's  to = 's  ---- THIS WORKED
#plot shows that data sits along a diagonal very well until the upper ends of the p-values
#added "Main" title, plot dissappeared.
#now getting no plot with "null device = 1" --- this happenes everytime I run "dev.off()" ....so, not running it for the moment


##############################################

#Exercise 1 part H - I#

#add diagonal line with slope of 1
abline(0, 1)
#create a line with slope of 1 and intercept of zero

###############################################

###################################################################################

#Exercise 2 part A#

getwd()

# Load a data set
phenoDataFrame=read.table('Day2dataset2PHENO.txt',header=TRUE)
#okay

dim(phenoDataFrame)

zz<-as.matrix(phenoDataFrame)
head(zz)

###############################################

#Exercise 2 part B#

#need to use quantile
#Find the value of the phenotype such that 25% of the individuals have a phenotype LESS than this value.
quantile(zz, 0.25)
#gives return of ~4.995
#Extract the row numbers(or individual IDs, whichever you prefer) of the individuals fulfilling
#this criterion. Store the row numbers for these individuals in vector called "controls." 
#need to extract individual ID's for ppl with mmolperL < 4.995119
controls<-c(quantile(zz,0.25))
?c()
?which()
controls<-which(zz[,2]<quantile(zz, 0.25))
controls
#success!

###############################################

#Exercise 2 part C#

#using another quantile
#Find the value of the phenotype such that 25% of the individuals have a phenotype GREATER than this value (looking for 0.75 quantile)
quantile(zz, 0.75)
#returns 30.25 as 75th percentile point

#Extract the row numbers (or individual IDs, whichever you prefer) of the individuals fulfilling this criterion. 
#Store the row numbers for these individuals in a vector called "cases"
#cases<-which(zz[,2]>quantile(zz, 0.75))
#cases
#getting "integer (0)" as return....
?integer()

#try switching direction ---same error--- UNTIL COMMENTED OUT THE GREATER-THAN CODE FOR CASES
#cases<-which(zz[,2]<quantile(zz, 0.75))
#cases
#commenting out for now

cases<-which(zz[,2]>quantile(zz[,2], 0.75))
cases
#had to specify in both which AND quantile that I want to look at values in column 2 only
#SUCCESS!


dim(zz)
#looks like I'm getting integer(0) because when I look at what's below the 75%, it shows ALL OF THE ID's. 

###############################################

#Exercise 2 part D#

#Make a density plot of the distribution of phenotypes (i.e. the blood glucose levels). 
#Add vertical lines to the plot to denote the 25% and 75% tails of the distribution.

plot(density(zz),col=2,lwd=4,xlab="Glucose Levels",xlim=c(-1,80),main="Glucose Level Distribution")

abline(v=quantile(zz,0.25),lty=2,lwd=3,col="green") 
abline(v=quantile(zz,0.75),lty=2,lwd=3,col="blue") 

dev.off()
#Interesting plot....not helping to explain the lack of apparent values above the 75% mark...

###############################################

#Exercise 2 part E#

#Extract the case genotypes from the "snpsDataFrame" for SNP "rs7584086_T". 
#Store these genotypes in the vector "case_genotypes".
head(snpsDataFrame)

case_genotypes<-snpsDataFrame["rs7584086_T",(cases[,1])]
#this gives "error in cases[,1]: incorrect number of dimensions

case_genotypes<-snps["rs7584086_T",]
case_genotypes
#?????????????????????????










###############################################

# sapply: Apply function to each element of a list or dataframe
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
sapply(x,mean)