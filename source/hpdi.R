# Calculate the Bayesian credible interval from a simulated posterior. This
# is based on the function HPDinterval in the coda package.
#
# samp: the posterior samples.
# prob: default is 95% credible interval
#
# Brett Melbourne
# Dec 2008
#
hpdi <- function (samp, prob = 0.95) {
    vals <- sort(samp)
    nsamp <- length(vals)
    gap <- max(1, min(nsamp - 1, round(nsamp * prob)))
    init <- 1:(nsamp - gap)
    inds <- which.min(vals[init + gap,drop=FALSE] - vals[init, drop=FALSE])
    ans <- cbind(lower=vals[inds], upper=vals[inds + gap])
    return(ans)
}
