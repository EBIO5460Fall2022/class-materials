#----likint()
# Calculate likelihood interval and optionally plot the profile.
#
# Arguments
# likratio:  The likelihood ratio for the interval
# fit:       The object from the optim MLE fit
# profpar:   Index of the parameter to profile (i.e. which element of pars?)
# nllfn:     Function to calculate the nll.
# plim:      Vector; lower and upper limit of parameter to profile.
# n:         Number of increments in the profile.
# monitor:   TRUE prints progress
# do_plot:   TRUE plots the profile
# pname:     Character or expression; display name of parameter for plotting.
# ...:       Arguments to pass to optim (and optim to pass to nllfn).
#            This will usually be the data and any ancillary parameters.
#            Can specify method="BFGS" here if one dimensional.
#
# Returns
# Plots the profile and returns the confidence interval as a vector.
#
# Brett Melbourne
# brett.melbourne@colorado.edu
# 1 Oct 18
#
#
source("source/likprofile.R")
source("source/lik_interp_int.R")
source("source/likprofplot.R")

likint <- function(fit, profpar, nllfn, plim, n=50, likratio=1/8,
                   monitor=FALSE, do_plot = TRUE, pname = NULL, ...) {
    
#   Profile the parameter
    profile <- likprofile(fit$par, profpar, nllfn, plim, n, monitor, ...)
    
#   Find likelihood interval limits
    nll_lev <- fit$value - log(likratio)
    interval <- lik_interp_int(profile, nll_lev)
    
#   Plot the profile
    if ( do_plot ) {
        likprofplot(profile, type = "likratio", minnll = fit$value, 
                    liklev = likratio, interval, pname)
    }
    
#   Return the likelihood interval
    names(interval) <- c("lower", "upper") 
    return(interval)
    
}

