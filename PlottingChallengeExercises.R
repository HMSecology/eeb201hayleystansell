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
chisqs=apply(snps,1,compute_chisquare)
chisqs2=apply(snps,1,compute_chisquare_2)

#check to see that the chisquare statistcs are the same:
#first do this by computing Pearson's correlation coefficient:
cor.test(chisqs,chisqs2)

#we can also do a quick scatterplot:
plot(chisqs,chisqs2)


#####SUCCESS! Got basic plot




###############################################

# sapply: Apply function to each element of a list or dataframe
x <- list(a = 1:10, beta = exp(-3:3), logic = c(TRUE,FALSE,FALSE,TRUE))
sapply(x,mean)