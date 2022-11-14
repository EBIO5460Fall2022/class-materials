#' ---
#' title: Ant data Generalized Linear Mixed Model
#' author: Brett Melbourne
#' date: 11 Nov 2020 (minor updates 14 Nov 2022)
#' output: github_document
#' ---

#' Third in a series of scripts to analyze the ant data described in Ellison
#' (2004). This script fits multilevel models to fully account for the design
#' structure. I will demonstrate both frequentist and Bayesian approaches.
#' 

#' Set up for Bayesian analysis (order is important):
#+ results=FALSE, message=FALSE, warning=FALSE
library(lme4)
library(ggplot2)
library(rstanarm)
options(mc.cores=parallel::detectCores())
theme_set(theme_bw())
source("source/hpdi.R") #For calculating credible intervals

#' Read in and plot the data:

ant <- read.csv("data/ants.csv")
ant$habitat <- factor(ant$habitat)
ant |>
    ggplot(mapping=aes(x=latitude, y=richness, col=habitat)) +
    geom_point() +
    ylim(0,18)

#' ## GLMM

#' Recall that our first analysis was a GLM with Poisson distribution and log
#' link. The multilevel model will do the same. In the design, at each site
#' there are a pair of plots, one plot is a bog while the other is a forest.
#'
#' ![ants_sketch](images/ants_sketch.svg)
#'
#' Thus, *site* is a grouping variable, while *plot* is the data scale.
#' *Habitat type* is a predictor at the plot scale. *Latitude* is a predictor
#' at the site scale.

ant$site <- factor(ant$site)

#' We'll first try a maximum likelihood fit using `glmer` but we'll see that the
#' algorithm fails to converge (although the failed fit is pretty close):

glmerHxL <- glmer(richness ~ habitat + latitude + habitat:latitude + (1|site),
                 family=poisson, data=ant)

#' We get a warning suggesting to rescale variables. If we look at the
#' correlation matrix (`Correlation of Fixed Effects`), we see a very high
#' correlation (-1.000) between the `intercept` and `latitude` parameters, and
#' the `habitat` and `habitat:latitude` parameters:

summary(glmerHxL)

#' So, indeed this correlation might be the problem. Scaling and centering
#' latitude fixes convergence.

ant$latitude_s <- scale(ant$latitude)
glmerHxL <- glmer(richness ~ habitat + latitude_s + habitat:latitude_s + (1|site),
                 family=poisson, data=ant)

#' In the summary, we see we have a random effect term: the variance at the site
#' scale, which is quite small.

summary(glmerHxL)

#' Let's compare to the fit without the site grouping structure. We see that
#' parameter estimates are almost the same.

summary(glm(richness ~ habitat + latitude_s + habitat:latitude_s,
    family=poisson, data=ant))

#' So, why should we include the grouping term? First, because it is part of the
#' sample design. Thus, we know it is a contributing factor. This is already a
#' fact of the design and we can't explain it away, for example, with a
#' non-significant hypothesis test for an effect of site. Second, we see that
#' the autocorrelation due to site has an effect on the uncertainty of the
#' latitude parameter. The mixed-effects model estimates more uncertainty in the
#' latitude parameter, and a larger p-value for its null hypothesis test. This
#' is because there is effectively less replication of latitude because latitude
#' occurs at the site scale and plots within sites are pseudoreplicates with
#' respect to latitude.
#' 

#' Now turning to the Bayesian model. We have the same likelihood but we now
#' have weakly informative priors as well (using here the sensible default
#' priors). If we did this analysis with the scaled latitude variable we would
#' see that the Bayesian analysis is substantially similar to the frequentist
#' one. However, recall that in `rstanarm`, the predictor variables are rescaled
#' automatically, so we'll use the unscaled latitude variable for convenience as
#' it will return results on the original scale, saving us from carrying out the
#' back-conversions.

bayesHxL <- stan_glmer(richness ~ habitat + latitude + habitat:latitude + (1|site), 
                       family=poisson, data=ant)
print(summary(bayesHxL)[,c("mean","sd","n_eff","Rhat")], digits=3)

#' Inspect diagnostics of the fit

#+ eval=FALSE
launch_shinystan(bayesHxL)

#' In particular, the posterior distributions for the linear coefficients
#' $\beta_i$ are all nicely symmetric, as expected for this type of model.
#' 

#' We could next form credible intervals and prediction intervals but we'll
#' defer that to the overdispersed model below.
#' 

#' ## Overdispersed model
#'
#' In the Poisson model, the variance is by definition equal to the mean. What
#' if there is more variance than this? This situation is called overdispersion.
#' We can include any extra variance by using a plot level error term, which
#' effectively makes the likelihood a Poisson-lognormal model.
#'
#' First define a plot-level indicator. Plot is the lowest level in this
#' dataset, so this is effectively the row number of the dataset.

ant$plot <- factor(1:nrow(ant))
#ant$plot <- 1:nrow(ant) #works just as well not as factor

#' Fit the mixed effects model now including the plot random effect. The
#' overdispersed GLMM using `glmer` with the unstandardized latitude again fails
#' to converge.

glmer_odHxL <- glmer(richness ~ habitat + latitude + habitat:latitude + (1|site) + (1|plot),
                        family=poisson, data=ant)

#' Unfortunately, the overdispersed GLMM using `glmer` with scaled latitude also
#' fails to end in a successful fit, now for a different reason.

ant$latitude_s <- scale(ant$latitude)
glmer_odHxL_s <- glmer(richness ~ habitat + latitude_s + habitat:latitude_s + (1|site) + (1|plot),
      family=poisson, data=ant)

#' Failure to fit often happens with `glmer`. In this case, it's because the
#' overdispersion variance is close to zero (i.e. near the boundary of parameter
#' space) and the training algorithm is not coping with that. The best we can do
#' for a maximum likelihood fit is to assume the overdispersion term is close
#' enough to zero to not matter and thus leave it out of the model.
#' 

#' We don't have any such problems with the Bayesian model, which takes the
#' overdispersion term in stride (the prior regularizes the estimate).

bayes_odHxL <- stan_glmer(richness ~ habitat + latitude + habitat:latitude + (1|site) + (1|plot),
                        family=poisson, data=ant)
print(summary(bayes_odHxL)[,c("mean","sd","n_eff","Rhat")], digits=3)

#' Inspecting the posterior distribution for the parameters reveals nice
#' symmetric distributions, except for the Sigma parameters (variances of the
#' random effects), which is expected. Sigma_plot in particular has a high
#' probability mass near zero.

#+ eval=FALSE
launch_shinystan(bayes_odHxL)

#' ## Intervals
#'
#' The code for the GLMM is substantially the same as the GLM. First form a new
#' dataset for prediction.

newd <- data.frame(latitude=rep(seq(from=41.92, to=45, length.out=50), 2),
                   habitat=factor(rep(c("bog","forest"), each=50)))

#' Then derive samples for the posterior distribution of the inverse link
#' function, i.e. Dist($\mu$), which we'll call `pmu`. In the GLMM we can choose
#' whether we want predictions to include the specific grouping terms or not (in
#' other words, do we want to predict for a specific site?). Here, we want to
#' predict for generic new sites, so we don't include the specific sites. To do
#' that, we use the argument `re.form=NA`, which means "don't form the random
#' effects").

#+ message=FALSE
pmu <- posterior_linpred(bayes_odHxL, transform=TRUE, re.form=NA, newdata=newd)

#' This is a matrix with samples in rows and the variable combinations in
#' columns. The estimated means are then:

mnmu <- colMeans(pmu)

#' and the 95% credible intervals for the mean are:

n <- ncol(pmu) #or nrow(newd)
regression_intervals <- data.frame(mulo95=rep(NA,n), muhi95=rep(NA,n))
for ( i in 1:n ) {
    regression_intervals[i,] <- hpdi(pmu[,i], prob=0.95)
}

#' For predictions, first derive samples for the posterior predictive
#' distribution, which we'll call ppd:

ppd <- posterior_predict(bayes_odHxL, re.form=NA, newdata=newd)

#' and the prediction intervals (here CPI) are then:

n <- ncol(ppd) #or nrow(newd)
prediction_intervals <- data.frame(ppdlo95=rep(NA,n), ppdhi95=rep(NA,n))
for ( i in 1:n ) {
    prediction_intervals[i,] <- quantile(ppd[,i], prob=c(0.025,0.975))
}

#' The plot shows that the credible intervals for the means are a little wider
#' than the fit that did not include the site-level grouping term or the
#' overdispersion term (compare to `10_8_ants_bayesian_GLM.md`).

preds <- cbind(newd, mnmu, regression_intervals, prediction_intervals)
bfc <- c("#d95f02", "#1b9e77") #bog & forest colors
preds |>
    ggplot() +
    geom_ribbon(mapping=aes(x=latitude, ymin=mulo95, ymax=muhi95, fill=habitat), alpha=0.2) +
    geom_point(data=ant, mapping=aes(x=latitude, y=richness, col=habitat)) +
    geom_line(mapping=aes(x=latitude, y=mnmu, col=habitat)) +
    geom_line(mapping=aes(x=latitude, y=ppdlo95, col=habitat), lty=2) +
    geom_line(mapping=aes(x=latitude, y=ppdhi95, col=habitat), lty=2) +
    geom_text(aes(x=42.7, y=3.3, label="Bog"), col=bfc[1]) +
    geom_text(aes(x=43.85, y=9.5, label="Forest"), col=bfc[2]) +
    scale_fill_manual(values=bfc) +
    scale_color_manual(values=bfc) +
    scale_y_continuous(breaks=seq(0, 20, 4), minor_breaks=seq(0, 20, 2)) +
    xlab("Latitude (degrees north)") +
    ylab("Ant species richness") +
    theme(legend.position="none")

#' To derive the differences between forest and bog across latitude using the
#' output from the `posterior_linpred` convenience function we have to consider
#' how we set up the `newd` dataframe. We asked for 50 increments of bog across
#' latitude followed by 50 increments of forest. So to obtain derived samples of
#' the difference between forest and bog we'll subtract the first 50 columns
#' from the second 50 columns of the `pmu` matrix.

diff <- pmu[,51:100] - pmu[,1:50]
diff_mn <- colMeans(diff)
n <- ncol(diff)
diff_cpi <- data.frame(difflo95=rep(NA,n), diffhi95=rep(NA,n))
for ( i in 1:n ) {
    diff_cpi[i,] <- quantile(diff[,i], prob=c(0.025,0.975))
}
diff_df <- data.frame(cbind(diff_mn, diff_cpi, latitude=newd$latitude[1:50]))

#' The plot shows similar estimates compared to the fit that did not include the
#' site-level grouping term or the overdispersion term (compare to
#' `10_8_ants_bayesian_GLM.md`). However, the decline with latitude is a little
#' less steep and the credible interval is a little wider after accounting for
#' the spatial structure and overdispersion.

diff_df |> 
    ggplot() +
    geom_ribbon(mapping=aes(x=latitude, ymin=difflo95, ymax=diffhi95), alpha=0.2) +
    geom_line(mapping=aes(x=latitude, y=diff_mn)) +
    coord_cartesian(ylim=c(0,8)) +
    xlab("Latitude (degrees north)") +
    ylab("Difference in species richness (forest - bog)")

