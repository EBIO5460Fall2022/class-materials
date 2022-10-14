# There are two programs that demonstrate diagnostic procedures for evaluating
# models fitted by likelihood methods. This is program 1 (diagnostics1.r), which
# is oriented toward Normal, linear, and generalized linear models and their
# multilevel counterparts. The second program (diagnostics2.r) has procedures
# for more general likelihood cases (including arbitrary data distributions and
# nonlinear models). Much of the advice here should in principle also apply to
# Bayesian models especially when strong priors are not used and the likelihood
# contains most of the information in the posterior.
# 
# It is important not to get confused by the different parts of this program.
# Generating fake data and linear regression are not part of the diagnostic
# methods. We need example datasets - so we'll make them up. We'll make up data
# where the true model is a simple linear or nonlinear function. Once we have
# fake data, we'll fit a linear model to it using lm(), then we'll consider
# diagnostics for the fitted model. Most of these methods extend from the Normal
# linear model to the rest of the linear model family (GLMM etc).
#
# In the program below, choose one of four possible scenarios for generating 
# fake data (run just the lines for that scenario), then skip to the rest of the
# code (from line starting with "#--Linear regression") to examine the
# diagnostic plots for a Normal linear model fitted to those data.
# 
# Brett Melbourne 18 Oct 2018
#

# 1) Generate some data (linear)
a <- 0    #y-intercept
b <- 3    #slope of linear predictor
v <- 1000    #error variance
x <- runif(100, 50, 100)    #an x variable
y <- a + b * x + rnorm(100, sd=sqrt(v)) #the y data


# 2) Generate some data (nonlinear)
a <- 0    #y-intercept
b <- 1    #slope of linear predictor
c <- 1    #quadratic parameter - controls degree of nonlinearity
v <- 10000    #error variance
x <- runif(100, 50, 100)    #an x variable
y <- a + b * x + c * x^2 + rnorm(100, sd=sqrt(v)) #the y data


# 3) Generate some data (linear with outlier)
a <- 0    #y-intercept
b <- 3    #slope of linear predictor
v <- 1000    #error variance
x <- runif(100, 50, 100)    #an x variable
y <- a + b * x + rnorm(100, sd=sqrt(v)) #the y data
y[which.min(x)] <- y[which.min(x)] * 2.5


# 4) Generate some data (linear but not Normal; instead lognormal)
a <- 0    #y-intercept
b <- 3    #slope of linear predictor
v <- 0.01  #error variance on log scale
x <- runif(100, 50, 500)    #an x variable
y <-  rlnorm(100, meanlog=log(a + b * x), sdlog=sqrt(v)) #the y data



#--Linear regression of the fake data 
# We are doing simple linear regression using `lm()` as a simple example of
# fitting a model.
fit <- lm(y ~ x)
plot(x, y, main="Linear model fitted to fake data")
abline(fit, col="blue")

#----Diagnostics-------------------------------------------------------------------

# So, now we have a fitted model, are there any problems with the model?

# Begin by calculating some basic quantities. Some of these are easily obtained
# from the object saved by `lm()` but we will instead calculate these here from
# first principles to illustrate how to go about it for more complex models.

# First we want the model predictions (also called the "fitted values"), which 
# we'll calculate by plugging the maximum likelihood estimates of the parameters
# into the equation for the linear model.
pars <- coef(fit)                  #These are the best fit parameters
pars                               #The parameter marked "x" is the slope
preds <- pars[1] + pars[2] * x 

# Then we will calculate the residuals (observed minus predicted)
segments(x, preds, x, y, col="green") #shows the residuals
r <- y - preds

# And here is a special diagnostic for linear normal models, called Cook's
# statistic, that measures the influence of a data point. We'll use the built in
# function to calculate it. This only works for an `lm()` fitted object.
cooks <- cooks.distance(fit) 

# Cook's statistic is what is called a "deletion diagnostic". In
# `diagnostics2.R` we will look at a more general algorithm for deletion
# diagnostics that can be applied to any model, including multilevel models.


#----Diagnostic plots-----------------------------------------------------------
par(mfrow=c(2,2))
# 1. histogram of residuals assessed against theoretical distribution
hist(r, xlab="Residuals", main="Histogram of residuals", freq=FALSE)
rseq <- seq(min(r), max(r),  length.out=100)
lines(rseq, dnorm(rseq, mean=0, sd=sd(r)), col="red")

# 2. Residuals vs predicted (fitted)
plot(preds, r, ylab="Residuals", xlab="Fitted values",
     main="Residuals vs fitted")
abline(h=0, col="red")

# 3. Quantile-quantile plot
qqnorm(r) #This plots the same graph using R's built in function
qqline(r)
# See quantiles_&_qqplots.R for a tutorial on quantiles and Q-Q plots

# 4. Cooks distance (case deletion diagnostic)
plot(1:length(cooks), cooks, ylab="Cooks distance", xlab="Index of data",
     main="Influence")

# Several of these, or variants, are also are produced by by R's linear
# regression tools.
par(mfrow=c(3,2))
plot(fit, 1:6, ask=FALSE)
?plot.lm
