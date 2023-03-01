# This is a script to be run in the R Statistical Software.
# Any line beginning with # is commented and will not be run.
# Line not beginning with # are code that you are meant to run
# (i.e. input in the R Console) and see what happens (more details below).

# First, open R and RStudio on your device.

# We first have a look at the essentials to start with R programming 
# and we learn to import simple datasets in R and to compute summary statistics 
# and basic graphs.

# This is a very short overview of R basics, please refer to 
# online resources such as the introduction to R that can be found 
# at \url{https://cran.r-project.org/manuals.html} and R help to learn more.

# 1) Use of the command line

# You can use the R Console (command line) as a calculator. 

# Try typing in the following instructions, and press enter:

2+3
2*3
3*4
8/2
sqrt(2) # square root
exp(2) # natural exponential
2^3     # power

# but more often you will want to define and use variables:

a<-1
b<-2
a+b

# if you just write the variable in the console, its content will be printed at screen

a
b

# Technical comment: R variables are untyped (you don't need to
# specify in advance if the variable is going to contain a number, a character, etc..)
# but that does not mean that the object they reference is untyped:

typeof(a)

# This is important to remember because some 
# R functions behave differently depending on the type of the object 
# (e.g., numeric, character, boolean,...). 




# 2) Vector, matrices and data frame

# Vectors:

x<-c(5,2,6,1,4,1)
x

y<-c('a','b','c','d','e','f')
y

z<-1:6
z

v<-c(x,y,z)
v

# if you are using RStudio (and you should!), check out these objects in the Environment tab on the top right.

# Matrices:

A<-matrix(y,2,2)
A
A[1,2]
B<-matrix(z,2,3)
B
B[2,3]

# You can then overwrite elements:

B[1,2]<-1000

# Vectors and matrices need to contain objects of the same type. 

# Data frame can include vectors of different type, 
# but they need to be of the same length, 
# because each row of the data frame is interpreted as an observation:
x<-1:7
data<-data.frame(x,y,z)
data

head(data)

# You can then access the data frame as a matrix:

data[1,2] # element
data[1,] # row (observation)
data[,2] # column (variable)

# or using variables names:
data$x
data$y
data$z

colnames(data)
# 3) Functions in R

# In R it is possible to build your own functions
# but many useful ones are already available, such as

mean(x)
sum(x)
max(x)
sd(x)
table(y) # frequency table
hist(x)
pie(table(y))

# so when you need to do something, look out for the functions that can help you!

# try:

help(hist)

# to see the help instructions for a function of interest.

# 4) Data import and export:

# The first step of the data analysis is necessarily to import data in R. 
# For small examples, this can be done manually by defining vectors and data.frame 
# which contain the data. However, this is not feasible for real data size. 
# It is possible to import data in R using the most common file format such as 
# .txt or .csv, using the functions read.table(), read.csv() and similar. 
# The function parameters need to be set to specify the column separator, 
# decimal symbol used in your file, etc. See the help of these functions to get an idea:

help(read.table)

# IMPORTANT: Pay attention that the files need to be in your working directory 
# to be imported. This can be found with the command 

getwd()

current<-getwd() # save the name of the current working directory. 

# and set with the command

setwd(current)

getwd()

# EXERCISE: set a new working directory.

# Now download the file protein.csv from the module KEATS
# page (in the material for Week 1) and save it in your
# working directory.

# This dataset contains the consumption
# of different foods in various countries.

# Then, import the data in R:

protein<-read.csv("protein.csv")
head(protein)

attach(protein) # this allows us to access the named variables directly
mean(RedMeat) # mean  red meat consumption

# EXERCISE: Compute the mean of the consumption
# of other types of food.

# 5) Editor and graphical interface:

# Let's now draw a scatterplot of the consumption of Red Meat and Fish from
# the data above.

plot(RedMeat~Fish, col="lightblue", pch=19, cex=2, data=protein)
text(RedMeat~Fish, labels=Country,data=protein, cex=0.9, font=2)

# Try using the graphical interface to save the plot on your device.

# Today, we will learn how to fit linear models in R and interpret the parts of the
# output related to estimation and inference about the parameters.
# We will work with a data set on the operation of an industrial chemical process.
# The variable of interest is the parts per thousand (i.e. 10 times the percentage) of
# ingoing ammonia that escapes (Stkloss); we want this to be low for environmental reasons.
# We also have data on three variables that might be related to the loss of ammonia:
#   the air flow rate at which the plant is run (Air); the temperature of the cooling water(Temp);
# and the acid concentration (Acid,in parts per thousand minus 500).


# The data are in the file Stackloss.txt on Keats. Download the file
# in your current working directory (ask for help with this if needed!)

Data<-read.table("Stackloss.txt",header=TRUE)
head(Data)
attach(Data)

# Let's start with some exploratory plot:

plot(Data)

# You can explore individual scatterplot, like:

plot(Air,Stkloss)
plot(Temp,Stkloss)
plot(Acid,Stkloss)

# Discussion point 1: 
# From the scatterplots, which variable(s) you expect will explain most of
# the variation in Stkloss?

# From the scatterplots, it looks like Air is the variable which better
# describes the variation in Stkloss, with smaller values of Air corresponding to
# smaller value of Stkloss and viceversa. Temp also explains a good amount of
# variation, while Acid not so much.

# We can fit the simple linear regression of ammonia loss on air flow using the
# command:

lm(Stkloss~Air)

# This gives the estimates of the parameters beta_0 and beta_1, labelled in an obvious way.
# However, having calculated and displayed these, R does not keep them. It is much
# more useful to type:

Model1 <- lm(Stkloss~Air)

# So far we have just seen the parameter estimates. R can give us a lot more information
# about the fitted linear model. For now, the most useful command is

summary(Model1)

# The output gives you a table where for each coefficient in the model
# you are given:
# Estimate
# Standard error (i.e. the estimated standard deviation of the estimator for beta_j)
# t-value: the test statistics T_j for the test H0: beta_j=0 vs H1: beta_j != 0
# Pr(>|t|): p-value of the above test.


# Discussion point 2:

# What conclusion will you draw about the test for the coefficient 
# in front of Air in Model1 and what does that mean for the relationship between 
# Air and Stkloss?

# At all usual levels of the test you can reject the null hypothesis that
# the coefficient is zero. This means that there is a relationship between Air and
# Stkloss and increasing Air by one unit will increase the average Stkloss by
# 0.102031.


# We can now fit a multiple linear regression model with all the variables in the dataset:

ModelFull <- lm(Stkloss~Air+Temp+Acid)
summary(ModelFull)

# Discussion point 3:

# On the basis of this fitted model, what would you suggest to decrease Stkloss?

# In reality, the answer will depend of course by the cost of changing
# each variable in the process. But assuming tis cost to be the same for any
# unitary change of the three variables, the best option looking only at the model
# output is to decrease the temperature and the air flow.

# Finally, we may want to include some basis functions/ variable transformations:

ModelPoly <- lm(Stkloss~Air+Temp+I(Temp^2)+Acid)
summary(ModelPoly)

# Discussion point 4:

# We have not talked about model comparison yest, but have a look at the output
# of model ModelPoly and ModelFull and discuss which one looks better and why.

# We will give a more rigorous answer to this in the secon part of the
# module, but at first glance ModelFull seems better because in ModelPoly you
# have two terms (the temperature and its square) which seem to be redundant,
# i.e. you could remove one of them from the model.



# Let us fit again the model

ModelFull <- lm(Stkloss~Air+Temp+Acid)
summary(ModelFull)

# 1) Inference for the parameters

beta<-ModelFull$coefficients # extract the coefficients value

beta_sd<-summary(ModelFull)$coefficients[,2] # extract the standard errors of the coefficients

# (You could have also read these value from the summary table)

# Apply the formula for a 95% confidence interval for the coefficient in front of Air:

beta[2]-qt(0.975,17)*beta_sd[2]
beta[2]+qt(0.975,17)*beta_sd[2]

# the function qt(0.975,17) gives us the 0.975 quantile of a student-t with 17 degrees of freedom.

# There is of course also a function to produce all the intervals automatically:

confint(ModelFull,level = 0.95)

# check that is giving you the same result!

# We can also compute confidence intervals for the error variance sigma^2:

s2<-summary(ModelFull)$sigma^2


# Lower bound
(17*s2)/qchisq(0.975,17)

# Upper bound:
(17*s2)/qchisq(0.025,17)

# where again qchisq() is giving us the qualtiles of a chi-squared distribution.


# 2) Confidence and prediction interval for the response 

# Confidence and prediction intervals for the response variables can be obtained
# using the function predict().


# First note that 

predict(ModelFull)

# only give you the fitted values, same as

ModelFull$fitted.values

# However, what you can do is to give new values of the predictor to the function:

New.Values <- data.frame(Air=60,Temp=20,Acid=59)
predict(ModelFull, New.Values)

# Using the parameter interval in the function, you can also produce
# confidence interval:

predict(ModelFull, New.Values, interval="confidence")

# and prediction intervals:

predict(ModelFull, New.Values, interval="prediction")

# The default level is 95%, but you can change it:

predict(ModelFull, New.Values, interval="prediction", level=0.99)

# Try doing the same for the confidence interval!

predict(ModelFull, New.Values, interval="confidence", level=0.99)

# 3) The ANOVA table  

# The function anova() allows us to compute ANOVA tables.
# However, simply typing 

anova(ModelFull)

# does something different than what we have seen in the lecture. 
# The reason is that this ANOVA table is doing a further decomposition
# of the sum-of-squares for a sequence of nested plots - we are going
# to see this in future weeks.

# To replicate the ANOVA table seen in the lecture we need to force R to compare
# the fitted model only with the so called null model, ie. the model with only the
# intercept:

ModelNull <- lm(Stkloss~1)
anova(ModelNull,ModelFull)


# Discussion point 1: interpret the output of this function, can you recognise all 
# the quantities in the ANOVA table seen in the lecture? Is anything missing?
# Is anything in a different order?

# The degrees of freedom column (Res.Df) comes before the sum of squares column (RSS).
# There is an additional column called Df, which contains the
# difference in degrees of freedom between the row before and the current row (in this case 20 − 17 = 3). The
# Sum of Sq column contains the mean square errors (MSE), then you have the F-statistics and the p-value of
# the global F-test.

# Discussion point 2: what decision would you take on the global F-test for this
# model? What does it mean in practice?

# In this case the p-value of the global F-test is very small, so at all usual level you
# should reject the null hypothesis that the data are generated from the model with only the intercept. In
# practice, this means that at least one of the predictors should be included in the model.



# 4) Coefficients of determinations

# Have a look at the summary of the model

summary(ModelFull)

# and find out the values of the R^2 (called multiple R^2 in R) and the
# adjusted R^2. Is the model a good fit for the data based on these quantities?
# Which is the most appropriate to look at in this case?

# The predicted R2 is high enough and also not too smaller than the adjusted R2,
# so it supports the idea that the model is predicting the response well

# Unfortunately, R does not provides us with the predictive R^2 (at least that I know of)
# We need to compute it manually:

X<-model.matrix(ModelFull) # to obtain the design matrix X of the model.
H<-X%*%solve(t(X)%*%X)%*%t(X)  # this computes the projection matrix H
h<-diag(H)                    # this extracts the diagonal of the matrix (elements h_ii)
PRESS<-sum((ModelFull$residuals/(1-h))^2) # this computes the Predictive residuals 
SST<-sum((Stkloss-mean(Stkloss))^2)                # this computes explicitly the total sum of squares  

# And finally, the predictive R^2:
Rp<-1-PRESS/SST
Rp


