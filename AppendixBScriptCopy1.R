#This Script is to practice writing in R as directed in the Appendix B of Primer in Ecology with R
#To run a given script, use ctrl+r when in Windows, or command+r when using Mac
'?'(mean)
# ^this brings up the help article in a NEW browser TAB on Arithmetic Mean, which tells you what it does, gives examples and how-to for usage of the function
help(mean)
# ^this brings up the same article
help("mean", htmlhelp=FALSE)
#gives an error stating there is an unused argument
help("mean", htmlhelp=TRUE)
#produces same error message
help(mean)
#^brings up the html help page as before. so, not sure what the command with the FALSE argument does. Is it supposed to close the help page?
options(htmlhelp=FALSE)
#^this command did not produce any error message. Thinking that the point of this and other commands is to prevent the help article from popping up in future runs of the script, like a cancellation
help.search("mean")
#^brings up any topics containing "mean" in Help
apropos("mean")
#apropos generally seems to mean concerning something specific. this command looks like it got the console to list all function commands that involve "mean"
Rsitesearch("violin")
#returned error saying 'could not find the function Rsitesearch'
RSiteSearch("violin")
#worked - illustrates that CASE MATTERS
RSiteSearch("violin", restrict = c("functions"))
#restricts or filters results to show fuctions with the term 'violin'
help(RSiteSearch)
#self explanatory
#
#B.2 ASSIGNMENT (is a pound sign needed to create empty lines or what...)
#
a<-2+3
a
# "a" is now 5
b<-a+a
b
# "b" is 10
a+a;a+b
# ^a semicolon can let you command multiple actions in one line of code/script
#
#B.3 DATA STRUCTURES
#
#B.3.1 VECTORS
#
Y<- c(8.3, 8.6, 10.7, 10.8, 11, 11, 11.1, 11.2, 11.3, 11.4)
Y
Y= c(8.3, 8.6, 10.7, 10.8, 11, 11, 11.1, 11.2, 11.3, 11.4)
Y
#for a VECTOR, you can assign info to the vector name using EITHER <- or = 
a= 2+4
a
#this works to get 5 as a result for "a", so...
b= a+a
b
#this also works, so WHEN is it importan to distinguish <- and = ????
1:4
#outputs 1 2 3 4 (sequence of integers 1:4)
4:1
#outputs 4 3 2 1
-1:3
# -1 0 1 2 3 
-(1:3)
#NOTE PARENTHESES - outputs -1 -2 -3
seq(from=1, to=3, by=0.2)
# ^make seq. from 1 to 3 in increments of 0.2
seq(1,3,by=0.2)
#equivalent statment
seq(1,3,length=7)
#tells R that you want a sequence of 7 numbers in equal increments between 1 and 3
rep(1,3)
rep(1:3,2)
rep(1:3, each=2)
# ^ the first tells it to rep 1, 3 times. second tells to rep sequence 1,2,3 two times, third tells to rep sequence 1,2,3, with each number repped 2 times
#
#B.3.2 GETTING INFORMATION ABOUT VECTORS
#
sum(Y)
# ^Y is the vector put in in the previous section
mean(Y)
max(Y)
length(Y)
summary(Y)
#summary tells you the min, 1st and 3rd quartiles, max, and median and mean
Names<- c("Sarah", "Yunluan")
Names
b<- c(TRUE, FALSE)
b
class(Y)
class(b)
# ^ "class(nameofvector)" tells you what class of data that vector belongs to. Here, Y is numeric, and b is logical
Y>10
#^asks whether a given number in Y is greater than 10, generating true/false responses for each
Y>mean(Y)
#like above, asking here "which numbers in Y are greater than the mean of Y?"
Y==11
Y!=11
#asking "for each number in Y, is that number equal to or not equal to 11", respectively. NOTE THE DOUBLE EQUALS SIGNS
#these commands (==, !=) can be useful in extracting subsets of data
#
#ALGEBRA WITH VECTORS
#
#Keep in mind that when doing operation/commands with vectors, R is acting on the elements/objects/numbers WITHIN the vectors, not the vectors themselves
a<- 1:3
b<- 4:6
a+b
#So here, you get 5,7,9 as result. 4+1, 5+2, 6+3
a*b
a/b
#self explanatory, mult. and div.
a+1
a*2
1/a
# ^these are scalars being applied to the contents of vector a. 1+1, 2+1, 3+1; 1*2, 2*2, 3*2, etc.
# ?? do not understand the comment about how R is "recycling the scalar"
a* 1:2
# ^this produces a WARNING message that "longer object length is not a multiplier of shorter object length"
# ?? need further explanation
a* c(1,2,1)
# ^this one DOES WORK, I am assuming because this is multiplying three objects against the three in "a", so it matches cleanly
1:4 * 1:2
1:4*1:2
1:4 * c(1,2,1,2)
#equivalent statments. These two vectors can be multiplied because 2 is a factor of 4 (four multiple of 2)
#^ the last version of that line shows the recyling of the short vector going on. it is getting reused to cover "3, 4" in the 1:4 sequence
#output of all three is always 1 4 3 8 (1*1, 2*2, 3*1, 4*2)
#
#B.3.3 EXTRACTION AND MISSING VALUES
#
Y[1]
Y[1:3]
# Y[1] means bring up the first value/object, Y[1:3] means bring up the first three values/objects
Y>mean(Y)
#remember, this is saying which values/objects in vector Y are greater than the mean value
#all but the first two are greater than the mean
Y[Y>mean(Y)] 
#as with Y[1], Y[anycondition] brings up whatever values/objects fit that condition, where, whichever values are greater than the mean
#brings up all values where the condition is TRUE
#
#LOOK FOR MISSING DATA WITH IS.NA COMMAND
#
a<-c(5,3,6, NA)
a
is.na(a)
#tells you if a value in your vector is NA. A true result tells you it matches that NA condition. Bad.
!is.na(a)
#tells you if a value is NOT NA (aka a REAL VALUE)
a[!is.na(a)]
#tells you which values satisfy the condition of being NOT NA
na.exclude(a)
attr(,"na.action")
attr(,"class")
#got a couple of error messages at the bottom of this string stating "ERROR IN ATTR(, "NA.ACTION/CLASS"): ARGUMENT 1 IS EMPTY"
mean(a)
mean(a, na.rm=TRUE)
#^ command "na.rm" translates as NA-REMOVE
d<-na.exclude(a)
mean(d)
#gives you the same result, but is handy because you have made a set D without the NA's from set A

