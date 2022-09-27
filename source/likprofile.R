#----likprofile()
# Profile the negative log-likelihood for a parameter from a maximum likelihood
# fit using optim.
#
# Arguments
# pars:      Vector of starting values for parameters.
#            This should generally be the MLEs.
# profpar:   Index of the parameter to profile (i.e. which element of pars?)
# nllfn:     Function to calculate the nll.
# plim:      Vector; lower and upper limit of parameter to profile.
# n:         Number of increments in the profile.
# monitor:   TRUE prints progress
# ...:       Arguments to pass to optim (and optim to pass to nllfn).
#            This will usually be the data and any ancillary parameters.
#            Can specify method="BFGS" here if one dimensional.
# Returns
# nllprof:   The negative log-likehood profile as a vector.
# pargrid:   The grid of parameter values.
#
# Brett Melbourne
# brett.melbourne@colorado.edu
# 1 Oct 18
#
likprofile <- function(pars, profpar, nllfn, plim, n=50, monitor=FALSE, ...) {

#   Index parameters
    iprof <- profpar      #parameter to profile
    MLEprofpar <- pars[iprof]
    pars[iprof] <- NA
    iother <- which(!(is.na(pars)))  #other parameters
    np <- length(pars)
    
#   Wrapper nll function to hold the profiled parameter fixed.
    fnwrp <- function(pp, ...) {
        ppp <- rep(NA,np)
        ppp[iother] <- pp
        ppp[iprof] <- par  #par has scope confintprof()
        return( nllfn(ppp,...) )
    }

#   Profile the parameter (starting near the MLE and working outward)
    nllprof <- rep(NA, n)
    pargrid <- seq(plim[1], plim[2], length.out=length(nllprof))
    starti <- which.min(abs(pargrid - MLEprofpar)) #Closest to MLE
    
    #Midpoint
    par <- pargrid[starti]
    otherpars <- pars[iother]
    opt <- optim(otherpars, fnwrp, ...)
    nllprof[starti] <- opt$value
    otherpars_start <- opt$par
    
    #High range
    otherpars <- otherpars_start
    for ( i in (starti+1):n ) {
        par <- pargrid[i]
        opt <- optim(otherpars, fnwrp, ...)
        nllprof[i] <- opt$value
        otherpars <- opt$par #Better start values for next loop
        if ( monitor ) print(i) #Monitor progress
    }
    
    #Low range
    otherpars <- otherpars_start
    for ( i in (starti-1):1 ) {
        par <- pargrid[i]
        opt <- optim(otherpars, fnwrp, ...)
        nllprof[i] <- opt$value
        otherpars <- opt$par #Better start values for next loop
        if ( monitor ) print(i) #Monitor progress
    }
    return( list(nllprof=nllprof, pargrid=pargrid) )
}