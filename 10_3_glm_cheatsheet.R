#' --- Frequentist Poisson-log-link GLM cheatsheet
#' for one continuous (x1) + one categorical (x2) variable with 2 levels ("cat1",
#' "cat2")

dat #a dataframe with x1, x2, y
dat$x2 <- factor(dat$x2)
ggplot(data=dat, mapping=aes(x=x1, y=y, col=x2)) +
    geom_point()
fit <- glm(y ~ x1 + x2 + x1:x2, family=poisson(link="log"), data=dat)
summary(fit) #Estimates and standard errors, etc
plot(fit, 1:6, ask=FALSE) #Diagnostic plots
confint(fit) #confidence intervals for parameters (uses likelihood profiling)
?confint.glm #in package MASS
cov2cor(vcov(fit)) #Correlation matrix for parameters
logLik(fit)  #The log likelihood

#' For GLMs, there is no `interval="confidence"` option in `predict()`, so
#' we have to construct regression intervals from the standard errors. This is
#' approximate. We use 2 * s.e. here. More accurate intervals can be obtained by
#' parametric bootstrap (I'll demonstrate later).

newd <- data.frame(x1=rep(seq(min(dat$x1), max(dat$x1), length.out=100), 2), 
                   x2=factor(rep(c("cat1","cat2"), each=100)))
preds <- predict(fit, newdata=newd, se.fit=TRUE)
mnlp <- preds$fit         #mean of the linear predictor
selp <- preds$se.fit      #se of the linear predictor
cillp <- mnlp - 2 * selp  #lower of 95% CI for linear predictor
ciulp <- mnlp + 2 * selp  #upper
cil <- exp(cillp)         #lower of 95% CI for response scale
ciu <- exp(ciulp)         #upper
mu <- exp(mnlp)           #mean of response scale

preds <- cbind(newd, preds, cil, ciu, mu)
preds

#' Plot model with data

ggplot() +
    geom_ribbon(data=preds, mapping=aes(x=x1, ymin=cil, ymax=ciu, fill=x2), 
                alpha=0.2) +
    geom_line(data=preds, mapping=aes(x=x1, y=mu, col=x2)) +
    geom_point(data=dat, mapping=aes(x=x1, y=y, col=x2)) +

#' For prediction intervals, we have to simulate the full fitted model. Again,
#' this is most accurate as a parameteric bootstrap. Later.



#' --- Bayesian Poisson-log-link GLM cheatsheet for rstanarm

library(rstan) #for extract function
library(rstanarm)
theme_set(theme_grey()) #rstanarm overrides default ggplot theme: set it back
source("source/hpdi.R")

fit <- stan_glm(y ~ x1 + x2 + x1:x2, family=poisson(link="log"), data=dat)
# Default priors are weakly informative

#' The samples themselves
#' You can do anything with these, as explained in McElreath, including
#' everything in the convenience functions below.

samples <- extract(fit$stanfit)
class(samples)
str(samples)
names(samples)
hist(samples$beta[,1]) #e.g. histogram of \beta_1
hpdi(samples$beta[,1], prob=0.95) #e.g. HPDI of \beta_1
quantile(samples$beta[,1], prob=c(0.025,0.975)) #e.g. CPI of \beta_1

#' Convenience functions for parameter estimates from the samples

summary(fit, digits=4) #Estimates and standard errors, etc
posterior_interval(fit, prob=0.95) #n.b. CPI (not HPDI), nb default=0.9
vcov(fit, correlation=TRUE) #Correlation matrix
