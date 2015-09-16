#B.3.4 MATRICES
#
matrix(letters[1:4], ncol=2)
M<-matrix(1:4, nrow=2)
#ncol, nrow just says number of columns or rows
M
#the command "M" is needed here because you gave the number matrix a name/variable, so now it is matrix "M" - show "M"
#R creates matrices that are filled in by columns, aka column major order, aka columns are prioritized. whether you tell it how many rows *or* columns you want, it will fill in the data going down the columns, THEN over
M2<-matrix(1:4, nrow=2, byrow=TRUE)
M2
#telling it that byrow=TRUE indicates you want it to fill in the data going along the rows instead of down columns as a priority
#compare M and M2 matrices
I<-diag(1,nrow=2)
I
#generates a matrix square with 2 rows with 1's on the diagonal
#this is an identity matrix (1's on diagonals)
#a matrix multiplied by its inverse produces an identity matrix
Minv<-solve(M)
M%*%Minv
#^example of M*(1/M) yielding an identiy matrix
#??? what is "QR DECOMPOSITION"?
#
#EXTRACTION IN MATRICES
#
M[1,2]
M[1,1:2]
M[,2]
#returns value in location [x,y], where x and/or y can be one location, a specified range, or full range
M[,]
#because no specifics entered, just returns the whole matrix
#
#SKIP SIMPLE MATRIX ALGEBRA
#
#B.3.5 DATA FRAMES
#
#A data frame is somewhere between a spreadsheet and a matrix. Column number matches row number (IS THIS REQUIRED?), BUT it's not expected that all data types with in the frame will be of the same class (e.g. you can mix numbers and logical info.)
dat<- data.frame(species= c("S.altissima", "S.rugosa", "E.graminifolia", "A.pilosus"), treatment= factor(c("Control", "Water", "Control", "Water")), height = c(1.1,0.8,0.9,1), width=c(1,1.7,0.6,0.2))
dat
dat[2,]
dat[3,4]
#to return specific data or a subset, specify the location just as you do in a matrix
dat[,2]=="Water"
dat[dat[,2]=="Water",]
#NOTE THE LAST COMMA AFTER WATER, which returns all species treated with water. Without it, you get the treatment and width columns!!
subset(dat,treatment=="Water")
#^MUCH MUCH SIMPLER FORMATTING TO DO THE SAME THING

