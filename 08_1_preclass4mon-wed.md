### Week 8: Preclass preparation for Mon-Wed

Bayesian algorithms continued, including MCMC. I'm going to give you all the homework for the week up front and you can work at your own pace. It's mostly Chapter 8 of McElreath, so try to get through about half or more of that by Monday.

We have a lot of installing to do and that can involve some troubleshooting. I don't have a Mac to verify these instructions so if those with Macs could try as soon as possible that would be great! If you run into a problem please post on Piazza so we can brains-trust a solution.

#### 1. Skill of the week: render a `.R` script to markdown

* See [repsci03_r2markdown.md](skills_tutorials/repsci03_r2markdown.md)
* Do this for any script you submit this week (i.e. submit both the `.R` script and the `.md` version)

#### 2. Set up RStan

This can be fussy if you previously installed an older version of Stan or another package that depended on Stan. The instructions below assume you have **R version 4.2** installed and are based on the more comprehensive instructions at [RStan Getting Started](https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started), which you can consult for troubleshooting (or if you are working with an earlier version of R).

##### Step 1. Uninstall Rstan

The `rstan` package was installed when you installed McElreath's `rethinking` package. It's necessary to uninstall this and start clean. Open Rstudio and do this:

```r
remove.packages("rstan")
if (file.exists(".RData")) file.remove(".RData")
```

Then, close Rstudio.

##### Step 2. Configure C Toolchain

**Microsoft Windows**

* First check if you have Rtools installed (most people won't) by going to the Windows Control Panel (start > type "control"). If it is installed and it is older than Rtools42, uninstall the old version first using the Windows Control Panel.

* Download the Rtools42 installer from here: https://cran.r-project.org/bin/windows/Rtools/rtools42/files/rtools42-5355-5357.exe. This is a large file, about 500MB.

* Run the installer. This will take a few minutes.

**Mac OS**

* The instructions on the [RStan wiki](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Mac) don't work for MacOS 11+. Use our confirmed process at [08_1_toolchain_MacOS.md](08_1_toolchain_MacOS.md).

##### Step 3. Install Rstan

**Microsoft windows**

Open Rstudio and run

```r
install.packages("StanHeaders", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
install.packages("rstan", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
```

**Mac OS**

Open Rstudio and run

```r
Sys.setenv(DOWNLOAD_STATIC_LIBV8 = 1)
install.packages("rstan", repos = "https://cloud.r-project.org/", dependencies = TRUE)
```

##### Step 4. Test RStan

Test that your RStan installation works by saving the following to a file called `8schools.stan` in your working directory (**include a blank line after the final brace**). Don't worry about understanding this code and don't be intimidated by it. This is Stan's underlying code language and we won't be using this language this semester (it is an advanced option that you might get into later). For now, we'll be using higher level interfaces (like `rstanarm`) that will abstract this away.

```stan
// save as 8schools.stan
data {
  int<lower=0> J;         // number of schools 
  real y[J];              // estimated treatment effects
  real<lower=0> sigma[J]; // standard error of effect estimates 
}
parameters {
  real mu;                // population treatment effect
  real<lower=0> tau;      // standard deviation in treatment effects
  vector[J] eta;          // unscaled deviation from mu by school
}
transformed parameters {
  vector[J] theta = mu + tau * eta;        // school treatment effects
}
model {
  target += normal_lpdf(eta | 0, 1);       // prior log-density
  target += normal_lpdf(y | theta, sigma); // log-likelihood
}
```

Then run the following in R

```r
library("rstan")
options(mc.cores = parallel::detectCores())

schools_dat <- list(J = 8,
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))

fit <- stan(file = '8schools.stan', data = schools_dat,
            iter = 1000, chains = 4)
print(fit)
```

You might need to wait 1 min or so for the Stan call to compile. There might be some error messages (probably all harmless). In particular, you could get a warning message involving `g++ not found` or that there were divergent transitions. These are nothing to worry about. If all is well, after `print(fit)` you should see output like this (your exact numbers will vary due to stochastic simulation but they should be very similar).

```
Inference for Stan model: 8schools.
4 chains, each with iter=1000; warmup=500; thin=1;
post-warmup draws per chain=500, total post-warmup draws=2000.

           mean se_mean   sd   2.5%    25%    50%    75%  97.5% n_eff Rhat
mu         7.67    0.15 4.96  -2.90   4.55   7.78  10.92  17.11  1142    1
tau        6.53    0.20 5.47   0.32   2.55   5.19   9.00  20.32   755    1
eta[1]     0.38    0.02 0.93  -1.47  -0.25   0.40   1.03   2.15  2000    1
eta[2]     0.02    0.02 0.87  -1.76  -0.55   0.03   0.61   1.74  2000    1
eta[3]    -0.17    0.02 0.94  -1.96  -0.80  -0.17   0.42   1.70  2000    1
eta[4]     0.00    0.02 0.94  -1.95  -0.57  -0.01   0.60   1.98  2000    1
eta[5]    -0.31    0.02 0.88  -1.88  -0.92  -0.36   0.25   1.55  1738    1
eta[6]    -0.22    0.02 0.86  -1.95  -0.79  -0.20   0.36   1.40  2000    1
eta[7]     0.37    0.02 0.87  -1.32  -0.18   0.40   0.92   2.02  2000    1
eta[8]     0.07    0.02 0.92  -1.78  -0.54   0.06   0.68   1.92  2000    1
theta[1]  11.11    0.19 8.01  -1.82   5.81  10.09  15.06  30.80  1719    1
theta[2]   7.77    0.14 6.20  -4.23   3.95   7.78  11.49  20.92  2000    1
theta[3]   6.16    0.17 7.52 -10.37   2.03   6.57  11.06  20.35  2000    1
theta[4]   7.68    0.15 6.72  -5.93   3.49   7.75  11.69  21.27  2000    1
theta[5]   5.10    0.14 6.21  -9.10   1.66   5.66   9.49  15.66  2000    1
theta[6]   6.06    0.15 6.64  -7.58   2.15   6.38  10.19  18.50  2000    1
theta[7]  10.65    0.15 6.68  -1.39   6.32  10.03  14.46  25.74  2000    1
theta[8]   8.31    0.18 7.88  -8.13   4.08   8.22  12.41  24.51  1947    1
lp__     -39.50    0.10 2.60 -45.09 -41.09 -39.31 -37.71 -34.98   719    1

Samples were drawn using NUTS(diag_e) at Thu Sep 20 07:25:36 2018.
For each parameter, n_eff is a crude measure of effective sample size,
and Rhat is the potential scale reduction factor on split chains (at
convergence, Rhat=1).
```

#### 3. Install cmdstan

This is for use with McElreath's `rethinking` package. We already installed the R package `cmdstanr` last week but now we need to install cmdstan itself, which involves compiling its C++ program. It's easiest to do this from R.

Open Rstudio and run (one line at a time)

```r
library(cmdstanr)
check_cmdstan_toolchain(fix = TRUE)
install_cmdstan()
```

Each step may take a while.

#### 4. Install rstanarm

This is an R package. First restart R. Then install `rstanarm` from CRAN in the usual way. `rstanarm` stands for "RStan for Applied Regression Modeling". It wraps `rstan` in such a way that models are expressed just as they are in the corresponding frequentist tools `lm()`, `glm()`, `glmer()` etc. We will be using this extensively for the rest of the semester to do all kinds of models from GLMs to multilevel models. It's the main tool we will use from now on!

#### 5. McElreath Chapter 8.

You can use the text in Google Drive. We are using the first edition. A second edition came out recently but I don't have it so I'm not sure how it aligns in case you have that copy.

Wherever it says to use `map()`, just use `sampost()`. Read in the `sampost` function first (as for last week).

```r
sampost <- function( flist, data, n=10000 ) {
    quadapprox <- map(flist,data)
    posterior_sample <- extract.samples(quadapprox,n)
    return(posterior_sample)
}
```

Wherever it says use `map2stan()`, go ahead and use that as directed.  As a small introduction to the `rstanarm` package, where it makes sense, also use `stan_glm()` on the same problem and compare the estimated parameters and their standard deviation to what you get from `map2stan()`. I don't want you to explore different priors in `rstanarm` yet, so if the question involves exploring priors, stick to `map2stan()` for that part. Specifying the linear model is just like `lm()`: 

```r
stan_glm(y ~ x1 + x2)
```

There is no need to specify priors (we will use the built in defaults for now). For example, 8.3.2 (Box: R code 8.5) will be:

```r
library(rstanarm)
m8.1rstanarm <- stan_glm( log_gdp ~ rugged + cont_africa + rugged:cont_africa )
# or more succinctly
m8.1rstanarm <- stan_glm( log_gdp ~ rugged * cont_africa )
```

Do the easy and medium problem sets. Render as a markdown report from the `.R` script. **At minimum, commit and push the medium problem solutions to GitHub.** Submit both the `.R` and `.md` files.
