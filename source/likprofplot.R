#----likprofplot()
# Plots a negative log likelihood, likelihood, or likelihood ratio profile using
# the output from likprofile() with optional likelihood levels and intervals
# shown.
#
# Arguments

# lp:        The output object from the likprofile function, or a list with two
#            vectors: 1) nllprof, the negative log-likehood profile, 2) pargrid, 
#            the grid of parameter values.
# type:      Character; type of profile to plot: "nll", "lik", "likratio".
# minnll:    Scalar; if type="likratio", the negative log likelihood of the
#            best fitting model.
# liklev:    Scalar; nll, likelihood, or ratio level to plot, depending on type.
# interval:  Vector; lower and upper limit of interval.
# pname:     Character or expression; display text of parameter that was profiled.
#
# Returns
# Plots the profile with level and interval.
#
# Brett Melbourne
# brett.melbourne@colorado.edu
# 1 Oct 18
#
likprofplot <- function(lp, type = "nll", minnll = NULL, liklev = NULL, 
                        interval = NULL, pname=NULL) {
    if ( !is.null(interval) & is.null(liklev) ) {
        stop("liklev is also required when an interval is given")
    }
    if ( type == "nll" ) {
        prof <- lp$nllprof
        ylab <- "Negative log-likelihood"
        txtpos <- liklev + 0.3
        #txtpos <- min(prof) + 2.3
    } else if ( type == "lik" ) {
        prof <- exp(-lp$nllprof)
        ylab <- "Likelihood"
        txtpos <- liklev / exp(0.3)
        #txtpos <- exp(-min(lp$nllprof)-2.3)
    } else if ( type == "likratio" ) {
        if ( is.null(minnll) ) stop("minnll is needed")
        prof <- exp( minnll - lp$nllprof )
        ylab <- "Likelihood ratio"
        txtpos <- liklev - 0.05
    } else {
        stop("Type of profile to plot not set correctly")
    }
    
    plot(lp$pargrid, prof, xlab=pname, ylab=ylab, type="l", col="#56B4E9")
    if ( !is.null(liklev) ) {
        abline(h=liklev,col="#E69F00")    
    }
    if ( !is.null(interval) ) {
        abline(v=interval[1], col="#E69F00", lty=2)
        abline(v=interval[2], col="#E69F00", lty=2)
        text(interval[1], txtpos, round(interval[1], 4), pos=4)
        text(interval[2], txtpos, round(interval[2], 4), pos=2)
    }
    
}