Likelihood inference for Normal linear model
================
Brett Melbourne
2020-09-18

Note: The .md version of this document is best for viewing on GitHub.
See the .Rmd version for the latex equation markup. The .Rmd version
does not display the plots in GitHub and is best for viewing within
RStudio.

<!-- This version is slightly abbreviated. Can add more material from the lecture slides as well. -->

I outline model, training, and inference algorithms for maximum
likelihood analysis. These algorithms can be applied to a wide range of
models, including nonlinear and process-based models, so these
algorithms are quite general, although it becomes increasingly difficult
to optimize nonlinear and hierarchical models as the number of
parameters goes up. Here, it is applied to the simple Normal linear
model, just as we have so far applied `lm()`. We will use the same
dataset as before. Compare the results here to those we obtained from
`lm()`. The main learning goal is to gain an intuition for model,
training and inference algorithms from a pure likelihood perspective (in
contrast to frequentist or Bayesian).

## Data

First we’ll generate some fake data for illustration. Since we set the
same random seed, these are the same fake data we used in the `lm()`
example.

``` r
set.seed(4.6) #make example reproducible
n <- 30 #size of dataset
b0 <- 50
b1 <- 10
s <- 40
x <- runif(n, min=0, max=25)
y <- b0 + b1 * x + rnorm(n, sd=s)
plot(x, y)
```

![](06_3_likelihood_inference_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

## Model algorithm

Ultimately, the model is stochastic but it includes both deterministic
and stochastic components.

$$\begin{aligned}
y_i &\sim \mathrm{Normal}(\mu_i,\sigma) \\
\mu_i &= \beta_0 + \beta_1 x_i
\end{aligned}$$

where $\mu_i$ is the expected value of $y_i$. The model has three
parameters, the intercept $\beta_0$, the slope $\beta_1$, and the
standard deviation of the Normal distribution $\sigma$, which is the
parameter describing the stochasticity of $y_i$. This model is
equivalent to the model we considered for `lm()`:

$$\begin{aligned}
y_i &= \beta_0 + \beta_1 x_i + e_i \\
e_i &\sim \mathrm{Normal}(0,\sigma)
\end{aligned}$$

The only difference between the models is in how they are parameterized.

We will encapsulate the algorithm for this model in two functions. The
first function is the deterministic part of the model - the linear model
that determines the expected values of $y$:

``` r
lmod <- function(b0, b1, x) {
    return(b0 + b1 * x)
}
```

For given values of $\beta_0$ and $\beta_1$ this function will return
expected values for $y$ at the input $x$ values. Here, we’ll input the
values for $x$ from the dataset defined above. For example, for
$\beta_0=300$ and $\beta_1=-9$,

``` r
lmod(b0=300, b1=-9, x=x)
```

    ##  [1] 168.19493 297.98720 233.90859 237.59063 116.94580 241.40375 137.00867
    ##  [8]  96.12927  86.46595 283.54249 130.19812 235.64986 277.48796  85.33453
    ## [15] 206.48840 197.60196  81.51248 168.60270  83.50396 128.61696 139.23558
    ## [22]  75.76211 186.08905 189.76277 153.93869 113.06856 191.55022 110.60710
    ## [29] 184.41711 180.80005

<!-- ypred <- lmod(b0=100, b1=9, x=x) -->
<!-- ypred -->
<!-- plot(x, y) -->
<!-- points(x, ypred, pch=16, col="#E69F00") -->

The stochastic part of the model (the first equation above) takes the
expected values from the deterministic (linear) part of the model and
generates stochastic $y_i\mathrm{s}$ that are normally distributed with
stochasticity determined by $\sigma$.

``` r
ystoch <- function(mu, sigma) {
    return(rnorm(n=length(mu), mean=mu, sd=sigma))
}
```

Here are four realizations of this stochastic model with $\beta_0=300$,
$\beta_1=-9$, and $\sigma=30$.

``` r
par(mfrow=c(2,2), mar=c(5,4,0,2) + 0.1)
ylim <- c(0,400)
for ( realization in 1:4 ) {
    ysim <- ystoch(mu=lmod(b0=300, b1=-9, x=x), sigma=30)
    plot(x, ysim, ylim=ylim, ylab="y")
}
```

![](06_3_likelihood_inference_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

## Training algorithm

The training algorithm (or model fitting algorithm) for maximum
likelihood is structured similarly. Indeed, the deterministic part of
the model uses the same function. The stochastic part of the model is
now not given by a function that generates stochastic data but a
function that determines the probability of the data given the model
parameters $\beta_0$, $\beta_1$, and $\sigma$. This is the likelihood
function

$$P(y|\theta) = P(y|\beta_0,\beta_1,\sigma,x) = 
\prod_i^n\frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{1}{2}\frac{(y_i-\beta_0-\beta_1 x_i)}{\sigma^2}}$$

where the RHS of the equation is the product of the probabilities of
individual data points (assuming independence). The equation inside the
product operator is the probability density function (pdf) of the Normal
distribution. To train (fit) the model, we take the natural logarithm
and change sign to get the **negative log-likelihood**, which is
sometimes known as the support function. This transformation is not
conceptually necessary but it improves the accuracy and stability of the
optimization algorithm - instead of multiplying tiny probabilities
together it is more accurate and convenient to sum their logs. The
optimization algorithm minimizes functions by default, so we take the
negative. The R code for the negative log-likelihood is:

``` r
lm_nll <- function(p, y, x) {
    mu <- lmod(b0=p[1], b1=p[2], x=x) #call the linear model
    nll <- -sum(dnorm(y, mean=mu, sd=p[3], log=TRUE)) #-1 * sum of log-likelihoods 
    return(nll)
}
```

The first argument of this function, `p`, is a vector of the three
parameter values. We need to “parcel them together” like this for the
optimization algorithm. The other arguments are the data `y`, and the
independent variable `x`. The first line inside the function calculates
$\mu_i$, the expected value of $y_i$, by calling the linear model with
the first two parameters of the parameter vector `p`, which are
respectively $\beta_0$ and $\beta_1$. The second line uses the pdf of
the Normal distribution to calculate the log-likelihoods for each
datapoint using the R function `dnorm()`. The log-likelihoods are then
summed and made negative. Thus, this function returns the negative
log-likelihood for a given set of parameters. For example, let’s try the
model $\beta_0=70$, $\beta_1=8$, and $\sigma=30$ and get its negative
log-likelihood:

``` r
p <- c(70,8,30)
lm_nll(p, y, x)
```

    ## [1] 157.2619

The key to the training algorithm is to find the model that maximizes
the likelihood, that is, find the parameter combination such that the
negative log-likelihood is minimized. We’ll use the Nelder-Mead simplex
optimization algorithm. This is the default optimization algorithm in
the R function `optim()`, see `?optim`. The arguments to `optim()` are
start values for the parameters and the negative-log likelihood
function. We also pass the data `y` and the independent variable `x`.
The start values for the parameters are important - it is helpful if we
make a good guess that is not too far from the optimum. We can see from
the data that the slope is positive and roughly 200/25, while the
y-intercept is less than 100, maybe around 50. The standard deviation is
about half the range of the data in any slice through $x$, so maybe
about 75/2. We’ll optimize starting from these guesses:

``` r
fitlm <- optim(p=c(50, 200/25, 75/2), lm_nll, y=y, x=x)
fitlm
```

    ## $par
    ## [1] 74.186822  9.022487 35.161409
    ## 
    ## $value
    ## [1] 149.366
    ## 
    ## $counts
    ## function gradient 
    ##       96       NA 
    ## 
    ## $convergence
    ## [1] 0
    ## 
    ## $message
    ## NULL

The maximum likelihood estimates of the parameters are in `$par`:
$\beta_0=74.2$, $\beta_1=9.0$, and $\sigma=35.2$. The negative
log-likelihood of this model is in `$value`: 149.4. We can also see that
the function was evaluated 96 times, while the convergence code of 0
tells us that the Nelder-Mead algorithm converged to an optimum. There
is not a guarantee that this is the global optimum and we would want to
try a range of starting values to ensure that there is not a better
optimum.

## Inference algorithm

Likelihood inference is based on likelihood ratios. The likelihood ratio
of model 2 to model 1 measures the strength of evidence for model 2
compared to model 1:

$$ LR=\frac{P(y|\theta_2)}{P(y|\theta_1)} $$

From the likelihood ratio we can make claims such as “the data have 30
times higher probability for model 2 than for model 1”. This is an
entirely accurate statement because it is made in terms of **the
probability of the data**.

The intended inference, however, almost always concerns the
**probability of model 2** compared to model 1, rather than the
quantified **probability of the data given model 2** compared to the
probability of the data given model 1. Thus, while we might state that
“model 2 has higher **likelihood** than model 1”, we need to remember
that the technical definition of likelihood is “the probability of the
data given the model” and is **not synonymous** with “the probability of
the model”.

Nevertheless, Bayes’ rule comes to the rescue. It shows that if model 2
has higher likelihood, then model 2 does indeed also have higher
probability than model 1, and indeed the ratio of the model
probabilities **equals** the likelihood ratio, all else being equal
(i.e. no prior information to favor one model over the other). Bayes
rule shows that, in the absence of prior information, the probability of
a model $P(\theta|y)$ is proportional to the likelihood $P(y|\theta)$
through a constant:

$$P(\theta|y) = \frac{P(\theta)P(y|\theta)}{P(y)}=kP(y|\theta).$$

The constant $k$ arises because no prior information means that the
prior $P(\theta)$ is the same for any models being considered, while
$P(y)$ is also constant across models because we are integrating across
the same model space. The **ratio of the model probabilities** is thus

$$\frac{P(\theta_2|y)}{P(\theta_1|y)} = \frac{kP(y|\theta_2)}{kP(y|\theta_1)}= \frac{P(y|\theta_2)}{P(y|\theta_1)} = LR.$$

The constants cancel to give the likelihood ratio. Thus, while the
likelihood ratio is not generally synonymous with the ratio of the model
probabilities, it is **exactly equal to it** in an important situation
that we care about in science: judging the relative strength of evidence
for models or hypotheses in the absence of prior information about the
models.

An important question is how to judge the strength of evidence in a
likelihood ratio. We need some kind of scale or calibration. One way to
calibrate likelihood ratios is to consider scenarios where the intuition
is obvious. Royall (1997) considers the following scenario. Suppose
there are two bags, each containing many marbles. Bag 1 contains half
white and half blue marbles, while bag 2 contains all white marbles. We
are presented with one of the bags. We are not allowed to look inside
but we can draw marbles one at a time from the bag, putting them back
each time and giving the bag a shake. Let’s say we draw 3 white marbles
in a row. What is the evidence that we have been given bag 2, the bag
with only white marbles? For bag 2, the likelihood is 1, that is, the
probability of drawing 3 white marbles from bag 2 is 1 x 1 x 1 = 1. For
bag 1, the probability of drawing 3 white marbles is 1/2 x 1/2 x 1/2 =
1/8. The likelihood ratio for bag 2 compared to bag 1 is thus

$$\frac{P(3~\mathrm{white}|\mathrm{bag}~2)}{{P(3~\mathrm{white}|\mathrm{bag}~1)}}=\frac{1}{(\frac{1}{2})^3}=2^3=8$$

That is, it is 8 times more likely that we have been given bag 2 than
bag 1. Thus, a likelihood ratio of 8 is equivalent to drawing 3 white
marbles in a row. You can decide how strong that evidence is to you.
Perhaps you would need to see 5 marbles in a row before you consider it
to be strong evidence for the all white bag, which would be a likelihood
ratio of $2^5=32$. Perhaps you would consider 10 white marbles in a row
to be especially strong evidence, which would be a likelihood ratio of
$2^{10}=1024$. We can apply this intuition from the white marbles to
likelihood ratios in unfamiliar situations, such as comparing two
scientific hypotheses.

Given a set of trained models, the likelihood inference algorithm is
straightforward:

    for each pair of models in a set
        calculate likelihood ratio
    judge the relative evidence for the models

At the minimum we need two models in our candidate set, representing two
scientific models to judge. Likelihood ratios are thus distinct from
*p*-values, where there is only one model that is being judged,
typically the null model. To consider a null hypothesis in the pure
likelihood approach, we would compare the maximum likelihood model to
the null model. For our linear model above, we can consider the null
hypothesis that the slope is zero, which corresponds to the linear model

$$\begin{aligned}
y_i &\sim \mathrm{Normal}(\mu_i,\sigma) \\
\mu_i &= \beta_0.
\end{aligned}$$

Since $\beta_1=0$, this new model has only two parameters, $\beta_0$,
which will simply be the mean of the data, and $\sigma$. Here is the
algorithm, a simple function, for the deterministic part of the model:

``` r
nullmod <- function(b0, x) {
    return(b0 + 0 * x)
}
```

This function returns a vector the same length as `x` with all values
equal to $\beta_0$. The stochastic part of the model has not changed so
we can still use the `ystoch()` function we previously defined for that.
Here are four realizations of this null model with $\beta_0=200$ and
$\sigma=60$.

``` r
par(mfrow=c(2,2), mar=c(5, 4, 0, 2) + 0.1)
ylim <- c(0,400)
for ( run in 1:4 ) {
    ysim <- ystoch(mu=nullmod(b0=200, x=x), sigma=60)
    plot(x, ysim, ylim=ylim, ylab="y")
}
```

![](06_3_likelihood_inference_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

There is no longer any relationship between $y$ and $x$ in this model
but there is stochasticity in the value of $y$.

To train this null model, we need to write a new negative log-likelihood
function for it:

``` r
lm_slopenull_nll <- function(p, y, x) {
    mu <- nullmod(b0=p[1], x=x) #call the null model
    nll <- -sum(dnorm(y, mean=mu, sd=p[2], log=TRUE)) #-1 * sum of log-likelihoods 
    return(nll)
}
```

This function is very similar to `lm_nll()` but two things are
different: 1) we call the null model to calculate `mu`, 2) the `p`
vector now contains only two parameters, $\beta_0$ and $\sigma$. Next,
train the model with the Nelder-Mead simplex algorithm using sensible
starts. I started with $\beta_0=200$, eyeballed from the plot of the
data, and $\sigma=75$, about half the data range:

``` r
fitlm_slopenull <- optim(p=c(200,75), lm_slopenull_nll, y=y, x=x)
fitlm_slopenull
```

    ## $par
    ## [1] 207.19050  72.77384
    ## 
    ## $value
    ## [1] 171.1874
    ## 
    ## $counts
    ## function gradient 
    ##       43       NA 
    ## 
    ## $convergence
    ## [1] 0
    ## 
    ## $message
    ## NULL

Compared to the full maximum likelihood model, this null model has a
higher negative log-likelihood of 171.2, indicating a lower likelihood.
What is the relative evidence for the maximum likelihood model compared
to the null model? The likelihood ratio for the full maximum likelihood
model versus the null slope model is

``` r
exp(-fitlm$value + fitlm_slopenull$value) #=exp(-fitlm$value)/exp(-fitlm_slopenull$value)
```

    ## [1] 2998558063

Thus, the MLE $\beta_1$ of 9 is about 3 billion times more likely than a
$\beta_1$ of 0. We might equally say that the evidence for a slope of 9
is about 3 billion times stronger than the evidence for a slope of 0, or
given equal prior weight on the models, that the probability that
$\beta_1=9$ is 3 billion times higher than the probability that
$\beta_1=0$. We don’t really need to consult the bags of marbles here
but if we did, this likelihood ratio corresponds to drawing about 31
white marbles in a row:

``` r
log(2998558063) / log(2) #number of white marbles
```

    ## [1] 31.48162

We can equally think of this in terms of the null model: the likelihood
of the null model is about one three-billionth of the maximum likelihood
model.

We can extend this idea of comparing pairs of trained models to examine
many values of a parameter at once and creating a likelihood profile for
the parameter. The general inference algorithm is

    for values of the parameter within a range
        train the model for the other parameters
        calculate the likelihood ratio against the MLE
    plot the profile of likelihood ratios
    judge the relative evidence for the models

Let’s see how this works for the slope parameter $\beta_1$. We need a
new negative log-likelihood that holds $\beta_1$ fixed while we optimize
over the other two parameters:

``` r
lm_slopefixed_nll <- function(p, b1, y, x) {
    mu <- lmod(b0=p[1], b1=b1, x=x) #call the linear model
    nll <- -sum(dnorm(y, mean=mu, sd=p[2], log=TRUE)) #-1 * sum of log-likelihoods 
    return(nll)
}
```

This `nll` function now has two parameters in the vector `p`, $\beta_0$
and $\sigma$. The slope parameter $\beta_1$ won’t be optimized because
it is not in the vector `p`. The way we will use this function to
produce a negative log-likelihood profile is to systematically vary
$\beta_1$ over a range of values while optimizing the other parameters.
We have to set a range over which to profile and decide on the
resolution of the grid within that range. After a bit of
experimentation, I set the range from 6 to 12 with 50 points in the
grid. In R code:

``` r
nll_b1 <- rep(NA, 50) #empty vector to hold nll for 50 different values of beta_1
b1_range <- seq(6, 12, length.out=length(nll_b1)) #grid of 50 values from 6 to 12
par <- c(74,35)  #starting values for beta_0 and sigma (I used the MLE here)
i <- 1 #to index the rows of nll_b1
for ( b1 in b1_range ) {
    nll_b1[i] <- optim(p=par, lm_slopefixed_nll, b1=b1, y=y, x=x)$value #b1 is set on each loop
    i <- i + 1 #next row
}
likprof_b1 <- exp(-nll_b1) #convert nll to likelihood
likratio_b1 <- exp(fitlm$value-nll_b1) #(profiled lik_b1) / (MLE lik_b1)
# Plot the profiles
par(mfrow=c(1,3))
plot(b1_range, nll_b1, xlab=expression(beta[1]), ylab="Negative Log-Lik", col="#56B4E9")
plot(b1_range, likprof_b1, xlab=expression(beta[1]), ylab="Likelihood", col="#56B4E9")
plot(b1_range, likratio_b1, xlab=expression(beta[1]), ylab="Likelihood Ratio", col="#56B4E9")
abline(h=1/8, col="#E69F00")
text(8, 1/8, "1/8", pos=3)
abline(h=1/32, col="#E69F00")
text(8, 1/32, "1/32", pos=3)
```

![](06_3_likelihood_inference_files/figure-gfm/unnamed-chunk-16-1.png)<!-- -->

The profile for the negative log-likelihood (left panel) shows the basin
that the optimization algorithm was seeking to find for $\beta_1$ when
all three parameters were in the search in our original optimization.
The MLE $\hat{\beta}_1$ is at the bottom of this basin. The likelihood
(middle panel) is the exponent of the log-likelihood. The extremely
small probabilities are apparent on the likelihood axis. The likelihood
ratio profile (right panel) is the likelihood divided by the maximum
likelihood so the profile is the same as the likelihood but scaled. On
this ratio scale we can easily judge the relative evidence for different
values of $\beta_1$ against the MLE. The horizontal lines correspond to
likelihood ratios of 1/8 (3 white marbles) and 1/32 (5 white marbles).
Values of $\beta_1$ less likely than these cutoffs are immediately
apparent. We can use these cutoffs to form likelihood intervals. Thus, a
1/8 likelihood interval is from about 7 to 11, while a 1/32 likelihood
interval is from about 6.5 to 11.5. We can interpolate within the
profile traces to extract precise values for these likelihood intervals
(see below). As a comparison with intervals you may be more familiar
with already, likelihood intervals of 1/8 and 1/32 turn out to be about
the same as frequentist 95% and 99% confidence intervals respectively.
However, despite similar numerical values, their interpretation is
different. Confidence intervals measure the reliability of a procedure,
whereas likelihood intervals directly measure the strength of evidence
in the data on hand. Finally, this likelihood profile is equivalent to
the Bayesian posterior distribution if the priors are flat (the
posterior would have the same shape but the y-axis would be a density
and the area under the curve would be normalized to 1).

The code above for likelihood profiling is quite involved and to
customize such code for each new model and parameter would be tedious.
This is a good situation to write a function to handle general cases. I
provide the functions `likprofile()`, `lik_interp_int()`, and
`likprofplot()`. These are designed to work for the general approach
that uses `optim()` to find the MLE, and they automatically handle
modifying the negative log-likelihood function to fix the parameter for
profiling, set starting values, interpolate interval limits, and plot
the profile. Normally you can just use the metafunction `likint()`,
which by default will call the other functions to profile and plot but
you can also use each separately. Here we use `likint()` to obtain the
**1/8 likelihood intervals** for $\beta_0$, $\beta_1$, and $\sigma$,
after a little experimentation with the profile bounds in `plim`. The
argument `profpar` tells `likint()` which parameter to profile while
optimizing the others.

``` r
source("source/likint.R")
par(mfrow=c(2,2), mar=c(5, 4, 0, 2) + 0.1 )
beta0_int <- likint(fitlm, profpar=1, lm_nll, plim=c(35,115), pname=expression(beta[0]), y=y, x=x)
beta1_int <- likint(fitlm, profpar=2, lm_nll, plim=c(6.5,11.5), pname=expression(beta[1]), y=y, x=x)
sigma_int <- likint(fitlm, profpar=3, lm_nll, plim=c(25,50), pname=expression(sigma), y=y, x=x)
```

![](06_3_likelihood_inference_files/figure-gfm/unnamed-chunk-17-1.png)<!-- -->

Notice the asymmetric profile for $\sigma$, which is typical. By
default, a 1/8 likelihood interval is calculated and the profile is
plotted but you can change that. Here is a 1/32 likelihood interval for
$\beta_1$ without the plot and with finer increments in the profile.

``` r
likint(fitlm, profpar=2, lm_nll, plim=c(6,12), likratio=1/32, n=100, do_plot=FALSE, y=y, x=x)
```

    ##     lower     upper 
    ##  6.483824 11.560674

For standard linear models, such as those from `lm()`, `glm()`, and
others, the `ProfileLikelihood` package can also automate the process of
profiling likelihoods. Several other packages include profiling
functions, such as Ben Bolker’s `bbmle`.

As we will see later, we can also co-opt likelihood in frequentist
inference to calculate *p*-values and confidence intervals but then we
are working with the sampling distribution of the likelihood ratio,
which is a different concept. In the frequentist context, the likelihood
ratio is merely a sample statistic rather than a measure of the strength
of evidence. It is worth comparing here the 1/8 likelihood intervals to
the frequentist 95% confidence intervals for $\beta_0$ and $\beta_1$
from the sum of squares inference from `lm()` ($\sigma$ does not have a
confidence interval because it does not have an inference algorithm in
the SSQ framework). The 95% confidence intervals are very similar to the
1/8 likelihood intervals shown in the plot above.

``` r
confint(lm(y ~ x))
```

    ##                 2.5 %    97.5 %
    ## (Intercept) 42.683909 105.70033
    ## x            7.094813  10.94976

## Summary

We have seen how the Normal linear model is viewed in a pure likelihood
paradigm. The situation is the same as the Bayesian perspective with
flat priors. All of the information about the model is in the likelihood
function. The model is fitted (trained) by minimizing the negative
log-likelihood, in effect maximizing the likelihood. Inferences are made
through likelihood ratios, which measure the relative evidence in the
data for different models.

The basic steps for likelihood analysis are recapitulated here:

``` r
plot(x, y)
lmod <- function(b0, b1, x) {
    return(b0 + b1 * x)
}
lm_nll <- function(p, y, x) {
    mu <- lmod(b0=p[1], b1=p[2], x=x) #call the linear model
    nll <- -sum(dnorm(y, mean=mu, sd=p[3], log=TRUE)) #-1 * sum of log-likelihoods 
    return(nll)
}
fitlm <- optim(p=c(50, 200/25, 75/2), lm_nll, y=y, x=x)
fitlm
beta0_int <- likint(fitlm,profpar=1, lm_nll, plim=c(35,115), pname=expression(beta[0]), y=y, x=x)
beta1_int <- likint(fitlm,profpar=2, lm_nll, plim=c(6.5,11.5), pname=expression(beta[1]), y=y, x=x)
sigma_int <- likint(fitlm, profpar=3, lm_nll, plim=c(25,50), pname=expression(sigma), y=y, x=x)
# model diagnostics should be included too!
```

## Where to from here?

In turns out that the strategy above, while rigorous and coherent, does
not scale well to more complex inferences. Pure likelihood based on
likelihood ratios continues to work well in more complex models only in
relation to the marginal inference on a single model parameter. When
inferences involve combinations of parameters, such as in the case of
regression intervals or prediction intervals, then things get tricky
very quickly. The problem is that we now need multidimensional profiles,
we can’t simply optimize over the other parameters. Multidimensional
profiling becomes too high of a computational burden to be practical. To
proceed, we need new algorithms, such as MCMC, to sample from the
likelihood surface. Once we start doing that, we might as well go
Bayesian.
