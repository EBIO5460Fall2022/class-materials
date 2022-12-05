Ant data: Bayesian model checking
================
Brett Melbourne
7 Dec 2021 (updated 5 Dec 2022)

Sixth in a series of scripts to analyze the ant data described in
Ellison (2004). This script performs some basic model checking for the
best fitting Bayesian model, highlighting the use of posterior
predictive checks.

Set up for Bayesian analysis

``` r
library(ggplot2)
library(rstanarm)
options(mc.cores = parallel::detectCores())
theme_set(theme_bw())
```

Read in the data

``` r
ant <- read.csv("data/ants.csv")
ant$habitat <- factor(ant$habitat)
ant$site <- factor(ant$site) #grouping variable
ant$plot <- factor(1:nrow(ant)) #unit-level identifier for overdispersion
ant$elevation_s <- scale(ant$elevation)
ant$latitude_s <- scale(ant$latitude)
```

Fit the model (this was our best candidate model)

``` r
bayesHLE <- stan_glmer(richness ~ habitat + latitude_s + elevation_s + 
                        (1|site) + (1|plot), 
                        family=poisson, data=ant)
```

The shinystan app has a bunch of diagnostics.

``` r
launch_shinystan(bayesHLE)
```

Click diagnose. I suggest routinely checking these:

- NUTS (plots), “By model parameter”, top two plots. The left one is the
  trace plot of the chains to assess convergence. The right plot is the
  posterior (check it’s shape). Look at each parameter by changing from
  the pulldown. I usually look at all the fixed effect parameters and
  the variances for the different scales.

- R_hat, n_eff, se_mean. This is a quick graphical overview but I will
  usually check these by printing a summary table instead.

- Autocorrelation. This is useful to see how efficient your chains are.
  If the autocorrelation declines quickly with lag, that’s good.

- PPcheck. Look at all of these. As mentioned in the previous script,
  the idea of the posterior predictive check is to simulate data from
  the fitted model. Does the simulated data look like the real data?
  Check especially “Distribution of observed data vs replications” (both
  histograms and overlaid densities) and “Distributions of test
  statistics”.

You can replicate those diagnostic plots in code using `pp_check()`. I
prefer to use the code versions to keep a record of what I’ve checked
and to add any commentary.

``` r
# Distribution of observed data vs replications, overlaid densities
pp_check(bayesHLE, plotfun = "dens_overlay")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-1.png)<!-- -->

``` r
# Distribution of observed data vs replications, histograms
pp_check(bayesHLE, plotfun = "hist")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-2.png)<!-- -->

``` r
# Distribution of observed data vs replications, boxplots
pp_check(bayesHLE, plotfun = "boxplot", nreps=30)
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-3.png)<!-- -->

``` r
# Distributions of test statistic, mean
pp_check(bayesHLE, plotfun = "stat", stat = "mean")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-4.png)<!-- -->

``` r
# Distributions of test statistic, sd
pp_check(bayesHLE, plotfun = "stat", stat = "sd")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-5.png)<!-- -->

``` r
# Distributions of test statistic, max
pp_check(bayesHLE, plotfun = "stat", stat = "max")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-6.png)<!-- -->

``` r
# Distributions of test statistic, min
pp_check(bayesHLE, plotfun = "stat", stat = "min")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-7.png)<!-- -->

``` r
# Scatterplot of y vs. average yrep
pp_check(bayesHLE, plotfun = "scatter_avg")
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-8.png)<!-- -->

``` r
# Residuals
pp_check(bayesHLE, plotfun = "error_hist", nreps = 6)
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-5-9.png)<!-- -->

The above plots show that the fitted model produces data much like the
real data. The one exception is that the real data don’t contain
richness values less than 2, as revealed in the plot of `min` as the
test statistic. Although uncommon, we do sometimes see simulated
datasets with minimum richness of 2, so we are probably not concerned.
The real data may well be such a realization.

There are many other options for `pp_check()` graphics to be explored.
Some of the most useful, are the grouped versions. For example:

``` r
pp_check(bayesHLE, plotfun = "ppc_dens_overlay_grouped", group="habitat", nreps=30)
```

![](15_4_ants_bayes_diagnostics_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

The plots made by `pp_check()` use functions from the `bayesplot`
package, which you could alternatively use directly (useful if you want
to investigate something not covered by `pp_check()` or outside of
`rstanarm`). For example, here is code to replicate the previous
`pp_check()` plot.

``` r
bayesplot::ppc_dens_overlay_grouped(y=ant$richness, 
                                    yrep=posterior_predict(bayesHLE, draws=30), 
                                    group=ant$habitat)
```

Of note, for binomial data, plots show the proportion of successes
rather than the raw count, and `ppc_error_binned()` can be used for
binned residual plots.

See the help topics for more options:

``` r
?pp_check
bayesplot::available_ppc()
```
