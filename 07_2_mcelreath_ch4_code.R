# Code for McElreath Ch 4, from section 4.3.5

# You may encounter an error from time to time that says "Start values for
# parameters may be too far from MAP". This is a familiar problem in training a
# model. Here the algorithm is randomly initializing start values that are too
# far from the high-probability region. We just need to try again until we get
# better start values. The error may cause R studio to enter debug mode. Hit Esc
# to get out of debug mode then run the block of code again.

# R code 4.24
library(rethinking)
data(Howell1)
d <- Howell1
d2 <- d[d$age >= 18,]


# Add the new function sampost
# To sample posterior
sampost <- function(flist, data, n=10000) {
    quadapprox <- map(flist, data)
    posterior_sample <- extract.samples(quadapprox, n)
    return(posterior_sample)
}


# R code 4.25
flist <- alist(
    height ~ dnorm(mu, sigma),
    mu ~ dnorm(178, 20),
    sigma ~ dunif(0, 50)
)

# R code 4.26
m4.1 <- sampost(flist, data=d2)

# R code 4.27
precis(m4.1)
head(m4.1)
hist(m4.1$mu, breaks=100, freq=FALSE, col="lightblue")
hist(m4.1$sigma, breaks=100, freq=FALSE, col="lightblue")

# R code 4.29
m4.2 <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu ~ dnorm(178, 0.1),
        sigma ~ dunif(0, 50)
    ),
    data=d2 )
precis(m4.2)
hist(m4.2$mu, breaks=100, freq=FALSE, col="lightblue")
hist(m4.2$sigma, breaks=100, freq=FALSE, col="lightblue")

# R code 4.32
head(m4.1)

# R code 4.33
precis(m4.1)

# R code 4.37
plot(d2$height ~ d2$weight)

# R code 4.38

# Fit model
m4.3 <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu <- a + b * weight,
        a ~ dnorm(156, 100),
        b ~ dnorm(0, 10),
        sigma ~ dunif(0, 50)
    ),
    data=d2 )

# R code 4.40
precis(m4.3)
hist(m4.3$a, breaks=100, freq=FALSE, col="lightblue")
hist(m4.3$b, breaks=100, freq=FALSE, col="lightblue")
hist(m4.3$sigma, breaks=100, freq=FALSE, col="lightblue")

# R code 4.41
round(cor(m4.3), 2)

# R code 4.42
d2$weight.c <- d2$weight - mean(d2$weight)

# R code 4.43
m4.4 <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu <- a + b * weight.c,
        a ~ dnorm(178, 100),
        b ~ dnorm(0, 10),
        sigma ~ dunif(0, 50)
    ),
    data=d2 )

# R code 4.44
precis(m4.4)
round(cor(m4.4), 2)

# R code 4.45
plot(height ~ weight, data=d2)
abline(a=mean(m4.3[,"a"]), b=mean(m4.3[,"b"]))

# R code 4.47
m4.3[1:5,]

# R code 4.48
N <- 10  #N <- 352 is the full dataset
dN <- d2[1:N,]
mN <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu <- a + b * weight,
        a ~ dnorm(178, 100),
        b ~ dnorm(0, 10),
        sigma ~ dunif(0, 50)
    ),
	data=dN )

# R code 4.49

# display raw data and sample size
plot(dN$weight, dN$height, xlim=range(d2$weight), ylim=range(d2$height),
     col=rangi2, xlab="weight", ylab="height")
mtext(concat("N = ", N))

# plot the lines, with transparency
for ( i in 1:20 ) {
    abline(a=mN$a[i], b=mN$b[i], col=col.alpha("black", 0.3))
}

# R code 4.50
mu_at_50 <- m4.3$a + m4.3$b * 50

# R code 4.51
hist(mu_at_50, breaks=100, freq=FALSE, col="lightblue")

# R code 4.52
HPDI(mu_at_50, prob=0.89)

# Replacement code for credible intervals and plotting
w <- seq(from=25, to=70, by=1) #or 25:70
n <- length(w)
hpdi_m <- matrix(NA, nrow=n, ncol=2) #matrix to store hpdi values
colnames(hpdi_m) <- c("low89","high89") #optional but nice
for ( i in 1:n ) {
    mu <- m4.3$a + m4.3$b * w[i] #the posterior sample of mu at weight w
    hpdi_m[i,] <- HPDI(mu, prob=0.89) #hpdi of the sample
}
hpdi_m

plot(height ~ weight, data=d2, col = "blue")
abline(a=mean(m4.3[,"a"]), b=mean(m4.3[,"b"]))
lines(w, hpdi_m[,"low89"], col="grey")
lines(w, hpdi_m[,"high89"], col="grey")

# Replacement code for prediction intervals and plotting
w <- seq(from=25, to=70, by=1) #or 25:70
n <- length(w)
pred_hpdi_m <- matrix(NA, nrow=n, ncol=2) #matrix to store hpdi values
colnames(pred_hpdi_m) <- c("low89","high89")
for ( i in 1:n ) {
    mu <- m4.3$a + m4.3$b * w[i] #the posterior sample of mu at weight w
    #Here is the new bit: the normal distribution sample
    newdat <- rnorm(n=length(mu), mu, sd=m4.3$sigma)
    pred_hpdi_m[i,] <- HPDI(newdat, prob=0.89) #hpdi of the sample
}
pred_hpdi_m

plot(height ~ weight, data=d2, col = "blue")
abline(a=mean(m4.3[,"a"]), b=mean(m4.3[,"b"]))
lines(w, hpdi_m[,"low89"], col="grey")
lines(w, hpdi_m[,"high89"], col="grey")
lines(w, pred_hpdi_m[,"low89"], col="grey")
lines(w, pred_hpdi_m[,"high89"], col="grey")


# R code 4.64
library(rethinking)
data(Howell1)
d <- Howell1
str(d)

# R code 4.65
d$weight.s <- ( d$weight - mean(d$weight) ) / sd(d$weight)

# R code 4.66
d$weight.s2 <- d$weight.s ^ 2
m4.5 <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu <- a + b1 * weight.s + b2 * weight.s2,
        a ~ dnorm(178, 100),
        b1 ~ dnorm(0, 10),
        b2 ~ dnorm(0, 10),
        sigma ~ dunif(0, 50)
    ),
    data=d )

# R code 4.67
precis(m4.5)


# Modify code above for HPDI of credible intervals and prediction intervals


# R code 4.70
d$weight.s3 <- d$weight.s ^ 3
m4.6 <- sampost(
    alist(
        height ~ dnorm(mu, sigma),
        mu <- a + b1 * weight.s + b2 * weight.s2 + b3 * weight.s3,
        a ~ dnorm(178, 100),
        b1 ~ dnorm(0, 10),
        b2 ~ dnorm(0, 10),
        b3 ~ dnorm(0, 10),
        sigma ~ dunif(0, 50)
    ),
    data=d )

precis(m4.6)

# R code 4.71
plot(height ~ weight.s, data=d, col=col.alpha(rangi2, 0.5), xaxt="n")

# R code 4.72
at <- c(-2,-1,0,1,2)
labels <- at * sd(d$weight) + mean(d$weight)
axis(side=1, at=at, labels=round(labels, 1))

# R code 4.73
plot(height ~ weight, data=Howell1, col=col.alpha(rangi2, 0.4))
