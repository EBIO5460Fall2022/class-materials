# There are two programs that demonstrate diagnostic procedures for evaluating
# models fitted by likelihood methods. This is program 2 (`diagnostics2.R``).
# This program includes case deletion diagnostics that are useful for diagnosing
# influence and outliers in the general likelihood case.
#
# The model here is a nonlinear stochastic model for the population dynamics of
# a species of Tribolium beetle. Data are from Melbourne & Hastings (2008)
# Nature 454: 100-103. A potentially influential point is identified.
#
# Brett Melbourne 
# 18 Oct 2018
# 

# This model is set up for maximum likelihood estimation via `optim()`. The
# model has three parameters to estimate: R, alpha, dp. The deterministic part
# of the model is an ecological function for population growth as a function of
# density with parameters R and alpha. The stochastic part of the model is a
# negative binomial chosen because the outcome variable (number of beetles) is
# discrete and positive and potentially more variable than Poisson. The
# dispersion parameter dp of the negative binomial distribution accounts for the
# variance beyond Poisson and needs to be estimated also.

#----Function definitions-------------------------------------------------

#--Ricker model (this is the nonlinear part)
# The input variable is Nt (initial abundance) and the outcome variable is Nt+1
# (abundance after 1 generation). We are modeling the outcome.
# Parameters
# R:      density independent growth rate
# alpha:  intraspecific competition intensity
# 
Ricker <- function(Nt, R, alpha) {
    Ntp1 <- Nt * R * exp( -alpha * Nt )
    return(Ntp1)
}

#--Likelihood - Negative binomial distribution
# Parameters (p) are passed to this function on a ln scale, which constrains
# them positive and improves the performance of optim.
# Parameter dp is in `dnbinom()`.
#
Ricker_nbinom_nll <- function(p, Nt, Ntp1) {
    R <- exp(p[1])  #Backtransform the parameters
    alpha <- exp(p[2])
    dp <- exp(p[3])  #dispersion parameter of negative binomial distribution
    mu <- Ricker(Nt, R, alpha) #the mean
    nll <- -sum(dnbinom(Ntp1, size=dp, mu=mu, log=TRUE))
    return(nll)
}

#----Variance of the Negative binomial Ricker
# This is the formula for the theoretical variance, a function of mu (mean) and
# dp (dispersion parameter).
#
Ricker_nbinom.var <- function(Nt, R, alpha, dp) {
    mu <- Ricker(Nt, R, alpha)
    var <- mu + mu * mu / dp
    return(var)
}


#----Main program----------------------------------------------------------

data <- read.csv("data/tribolium.csv")
Nt <- data$Nt
Ntp1 <- data$Ntp1

# Setup
n <- nrow(data)
case <- 1:n
R <- 2.71
alpha <- 0.0038
dp <- 1.99
p <- c(log(R), log(alpha), log(dp)) #starting parameter values on ln scale

# Likelihood fit for full dataset.
# The BFGS method turns out to have better performance here than the default
# `optim()` method of Nelder-Mead.
fullfit <- optim(p, Ricker_nbinom_nll, Nt=Nt, Ntp1=Ntp1, method="BFGS")
fullphat <- exp(fullfit$par)
names(fullphat) <- c("R", "alpha", "dp")
fullnll <- fullfit$value

# Plot the data and fitted values (predictions)
plot(Nt, Ntp1, main="Ricker model with negative binomial process error",
     xlab="N[t]", ylab="N[t+1]")
fv <- Ricker(Nt, fullphat["R"], fullphat["alpha"])
lines(0:1000, Ricker(0:1000, fullphat["R"], fullphat["alpha"]), col="red")
segments(Nt, fv, Nt, Ntp1, col="green") #shows the residuals

# Residuals vs fitted
r <- Ntp1 - fv
plot(fv, r, xlab="Fitted values", ylab="Residuals")
abline(h=0, col="red")
text(fv[case==51], r[case==51], "51", cex=0.8, pos=3)

# Standardized residuals are the residuals divided by their theoretically
# expected standard deviation according to the negative binomial distribution.
# Standardized residuals vs fitted values plot suggests that smaller fitted
# values have larger residuals and there is a possible outlier.
sr <- r / sqrt(Ricker_nbinom.var(Nt, R, alpha, dp))
plot(fv, sr, xlab="Fitted values", ylab="Standardized residuals")
abline(h=0, col="red")
text(fv[case==51], sr[case==51], "51", cex=0.8, pos=4)


# Case deletion fits.
# This is simply refitting the model with each data point left out in turn. We
# record the new parameter estimates and nll.
casedel <- matrix(nrow=n, ncol=4)
colnames(casedel) <- list("R", "alpha", "dp", "nll")
p <- log(fullphat)
for ( i in case ) {
    Nt <- data$Nt[-i]
    Ntp1 <- data$Ntp1[-i]
    fit <- optim(p, Ricker_nbinom_nll, Nt=Nt, Ntp1=Ntp1)
    casedel[i,1:3] <- exp(fit$par)
    casedel[i,4] <- fit$value
    print(paste("Deleted", i, "of", n, sep=" ")) #Monitoring
}

# Likelihood displacement
LD <- 2 * ( casedel[,"nll"] - fullnll )

# Percent change in parameters
Rpc <- 100 * ( casedel[,"R"] - fullphat["R"] ) / fullphat["R"]
alphapc <- 100 * ( casedel[,"alpha"] - fullphat["alpha"] ) / fullphat["alpha"]
dppc <- 100 * ( casedel[,"dp"] - fullphat["dp"] ) / fullphat["dp"]

# Diagnostic plots
par(mfrow=c(2,2))

plot(case, abs(LD), xlab="Case", ylab="Likelihood displacement")
text(51, abs(LD)[51], "51", cex=0.8, pos=4)

plot(case, Rpc, xlab="Case", ylab="Percent change in R")
abline(h=0, col="gray")
text(51, Rpc[51], "51", cex=0.8, pos=4)

plot(case, alphapc, xlab="Case", ylab="Percent change in alpha")
abline(h=0, col="gray")
text(51, alphapc[51], "51", cex=0.8, pos=4)

plot(case, dppc, xlab="Case", ylab="Percent change in dp")
abline(h=0, col="gray")
text(51, dppc[51], "51", cex=0.8, pos=4)

mtext("Influence - case deletion diagnostics", 3, -2.5, outer=TRUE)

