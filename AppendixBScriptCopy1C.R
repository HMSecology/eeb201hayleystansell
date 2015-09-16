#continuation through selected sections of Appendix B
#
#B.4 FUNCTIONS
#
mean(1:4)
mean(1:4,trim=0)
#trim is used to "trim off" outliers in data that may skew the mean to a non-representative value. Trim defaults to =0 unless you say otherwise
class(1:10)
class(warpbreaks)
#class returns info on what type of data is within the set specified
summary(1:10)
summary(warpbreaks)
#^ self explanatory
#the summary of the data frame is noteworthy in that it includes the value for each factor/quality AND the NUMBER OF OCCURANCES of each factor/quality within the dataset
summary(lm(breaks~wool,data=warpbreaks))
#this is requesting the summary of a LINEAR MODEL (vs. a data frame), which has a lot more information output
#"Call:" appears to just tell what model/dataset you called up a summary for?
MyBogusMean<-function(x,cheat=0.05){SumOfX<-sum(x)n<-length(x)truemean<-SumOfX/n(1+cheat)*trueMean}
RealSales<-c(100,200,300)
MyBogusMean(RealSales)
#Typing out the BogusMean function as one line DID NOT WORK
MyBogusMean<-function(x,cheat=0.05){
SumOfX<-sum(x)
n<-length(x)
trueMean<-SumOfX/n
(1+cheat)*trueMean
}
RealSales<-c(100,200,300)
MyBogusMean(RealSales)
#following the formatting implied in the book DOES WORK. the plus signs are not necessary, it looks like the wavy brackets are what indicate that each line between them is to be included in the definition of the function, and each line therein is a specific definition or function
MyBogusMean(RealSales, cheat =0.1)
MyBogusMean(RealSales, cheat =0)



