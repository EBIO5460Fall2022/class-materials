# This program trains (fits) a simple linear model using the Nelder-Mead
# algorithm to find the minimum sum of squares.
# Brett Melbourne
# 1 Sep 2021
#
# Model fitting has three components:
# 1) A function for the linear model.
# 2) A function to calculate SSQ.
# 3) The call to optim.

# In this particular example, there is no strong advantage to separating out the
# model from the SSQ function but this program structure generalizes to more
# complex models (e.g. nonlinear dynamical models) so I demonstrate it here.


#----Function definitions------------------------------------------------------

#----linmod()-----------------------
# A function for the linear model. This is the model algorithm.
# Returns a vector of y for the model:
#    y = b_0 + b_1 * x
# b_0: y intercept
# b_1: slope
#
linmod <- function(b_0, b_1, x) {
    y <- b_0 + b_1 * x
    return(y)
}


#----ssq_linmod() ------------------
# Returns the sum of squares for the linear model. This is set
# up for use with optim(). The first argument must be a vector of parameters.
# p:  vector of parameter values c(b_0, b_1) 
# y:  vector of data for y
# x:  vector of data for x
#
ssq_linmod <- function(p, y, x) {
    #In the next line we refer to the parameters in p by name so that the code
    #is self documenting
    y_pred <- linmod(b_0=p[1], b_1=p[2], x) #predicted y
    e <- y - y_pred #observed minus predicted y
    ssq <- sum(e^2)
    return(ssq)
}


#----Main Program--------------------------------------------------------------

#----Read in the data
# These are the same data used in the lectures.
linear_data <- read.csv("data/linear_data.csv")

#----Plot the data
plot(linear_data$x, linear_data$y)

#----Train the model on the data using the Nelder-Mead descent algorithm
# We have to choose starting values for the parameters. How do we choose
# starting values? We can apply some logic. Looking at the plot, we can gauge
# the y intercept as around 200. The slope is rise over run, and that looks to
# be about -200 / 50 (we can see that it's going to be negative). Then we'll
# also want to try different starting values to check that the algorithm is
# robust to where it starts and consistently finds the minimum.

# Initialize parameters: ****TRY DIFFERENT STARTING VALUES TOO****
b_0_start <- 200
b_1_start <- -4

# Optimization: finding the minimum SSQ
# Read the help for optim(), noting how to pass parameters and data. Parameters
# need to be in a vector and data need to be passed through the "..." part of
# optim().
?optim
par <- c(b_0_start, b_1_start)  #Put the starting parameters in a vector
fit <- optim(par, ssq_linmod, y=linear_data$y, x=linear_data$x)
fit
# $par gives the optimized parameter values
# $value gives the minimum SSQ
# $counts gives the number of times the function was evaluated
# $convergence signals whether the algorithm converged (0 if it did converge)

# Calculate fitted model for best parameter values.
# Also called "fitted values".
y_pred <- linmod(b_0=fit$par[1], b_1=fit$par[2], linear_data$x)

# Plot fitted model with the data
points(linear_data$x, y_pred, col="red")
abline(fit$par[1], fit$par[2], col="red")
# Add the deviations if you want to be fancy
segments(linear_data$x, y_pred, linear_data$x, linear_data$y, col="green")

# As we saw, R's lm() function uses a different algorithm (householder algorithm
# for QR decomposition to solve the system of linear equations) to find the
# minimum SSQ. Here's lm() for comparison.
lmfit <- lm(y ~ x, data=linear_data)
lmfit #Estimated coefficients are the same
anova(lmfit) #The minimum SSQ is the same (See Residuals: Sum Sq)
