# TO DO
# Consider using splinefun() instead of approx().

# Could consider automatically getting the required resolution near the limit.
# This is really a root finding algorithm I think. That might work better than 
# approx. But it would require refactoring - profiling would need to be
# adaptive.

#----lik_interp_int()
# Calculate an interval from a negative log-likelihood profile and a cut level.
#
# Arguments
# lp:        The output object from the likprofile function, or a list with two
#            vectors: 1) nllprof, the negative log-likehood profile, 2) pargrid, 
#            the grid of parameter values.
# nll_lev:   The cut level in the negative log-likelihood that defines the
#            interval.
#
# Returns
# Vector; the interval
#
# Brett Melbourne
# brett.melbourne@colorado.edu
# 1 Oct 18
#

lik_interp_int <- function(lp, nll_lev) {
    
    prof <- lp$nllprof
    pargrid <- lp$pargrid
    
    if ( nll_lev > max(prof) ) {
        warning("Profile does not contain the interval. Re-profile with wider bounds.")
    }        
    nll_lo <- prof[1:which.min(prof)]
    par_lo <- pargrid[1:which.min(prof)]
    int_lo <- approx(nll_lo, par_lo, xout=nll_lev)$y
    nll_hi <- prof[which.min(prof):length(prof)]
    par_hi <- pargrid[which.min(prof):length(prof)]
    int_hi <- approx(nll_hi, par_hi, xout=nll_lev)$y

    return(c(int_lo, int_hi))
    
}
