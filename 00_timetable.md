# Semester timetable
This is the timetable we followed last year. This year at the start we'll interweave learning to program, so the exact details may change especially at the beginning.


## Week 1
* Intro to class and pretest
* Homework: skills
  * Get set up with Git and GitHub.
* Homework: reading
  * How algorithms unite data science
* Structured programming
* The inter-relation of hypotheses, models, and algorithms
* 3 algorithm classes: model, training, inference

## Week 2
* Homework: skills
  * Git and GitHub: stage, commit, push, backtrack
* Homework: reflection/analysis
  * Linear regression workflow
* Homework: mini lecture
  * Algorithms in data science: 3 classes
* Analysis workflows
* Model algorithms intro
  * Simple linear model in math and code
  * Design matrix and parameterization
  * Linear model shorthand
* Homework: mini lecture
  * Training algorithms intro
* Class: Code a grid search training algorithm

## Week 3
* Optimization algorithms
  * Nelder-Mead simplex algorithm using `optim()`
  * SSQ QR decomposition algorithm used in `lm()`
* Inference algorithms intro
  * Inference problems/goals
  * Looking back or looking forward
  * Looking back: considering the ways data could have happened
* Frequentist inference algorithms
  * The sampling distribution algorithm - considering the ways a sample could have happened
  * Plug in principle
  * Inference algorithms for `lm()` simple linear model
  * Confidence intervals from the sampling distribution
  * Coverage algorithm
  * P-value algorithm
  * Prediction intervals
* Homework:
  * Coding optimization algorithms
  * Coding confidence and prediction intervals

## Week 4

* Homework: skills
  * Git and GitHub: branch, merge, amend, .gitignore, GUI
  * Using code styles
* Homework: reading
  * Bootstrap algorithm
* Bootstrap algorithm
  * Non-parametric, empirical, parametric
  * Bootstrapped confidence interval
  * Bootstrapped p-value
* Homework: 
  * Coding bootstrap algorithms

## Week 5

* Homework: skills
  * Reproducible science
  * Writing markdown documents
* Homework: reading
  * Pitfalls of p-values
  * Conceptual foundations of likelihood
  * Likelihood inference for the linear model

* Homework: mini lecture
  * Likelihood

* Homework: problem set
  * Likelihood problems from McElreath Ch 2

* Likelihood inference
  * Conditional probability: P(y|theta)
  * Likelihood principle, likelihood function, likelihood ratio
  * Training algorithm: maximum likelihood
  * Inference algorithm: likelihood profiles
  * Pure likelihood intervals
* Homework:
  * Coding likelihood intervals for the linear model

## Week 6

* Homework: skills
  * Practice git branch and merge with your own code
* Homework: reading and mini lecture
  * Bayes' theorem, prior, posterior
* Homework: problem set
  * Bayesian problems from McElreath Ch 2
* Homework: reading & active coding
  * Bayesian model notation
  * Bayesian inference algorithm
  * Coding problems from McElreath Ch 4
* Bayesian inference algorithms
  * Posterior sampling
  * Histograms as approximations to posterior distribution
  * Credible intervals: central posterior interval, highest posterior density interval
  * Prediction intervals
  * Inference for linear models

## Week 7

* Homework: skills
  * Reproducible workflow
  * Render an R script to markdown
* MCMC algorithms for Bayesian training
  * Metropolis-Hastings, Gibbs sampling, Hamiltonian Monte Carlo
  * Stan, rstan, rstanarm
  * MCMC diagnostics
* Further Bayesian topics
  * Choosing priors
  * Posteriors for derived quantities

* Homework: coding
  * McElreath Ch 8 problems
* Class: ant species richness dataset

## Week 8

* Homework: skills
  * Visualization
  * Theory and concepts behind ggplot
  * Using ggplot
* Model diagnostics
  * Checking model assumptions
  * Assessing training robustness
  * Residuals, influence, leverage, outliers, QQ plots, nonlinearity, non-constant variance
  * Case deletion diagnostics for influence
* Homework: coding
  * Diagnostics for the naive ants linear model

* Generalized linear models (GLMs)
  * Link functions
  * Data distributions in the exponential family

## Week 9

* Homework: skills
  * Data manipulation with `dplyr`
* GLMs: ant data case study
  * Frequentist/likelihood analysis using `glm()`
  * Bayesian analysis using `stan_glm()`


## Week 10

* Homework: skills
  * Tidy data
* Homework: individual project
  * Preproposal
* Data visualization
  * Exploratory data analysis of hierarchical data
  * Using `dplyr` and `ggplot`
* Model formulae in R
  * Shorthand notation for linear model design matrix
* Introduction to multilevel models (Normal, linear)
  * Grouping variables
  * Fixed vs random effects
  * Partial pooling and shrinkage
  * Using `lmer()` and `stan_lmer()`
* Workflow algorithm
  * Sketch the data design
  * Write the equations
  * Linear model syntax

Homework: reading

* Radon multilevel case study (Gelman & Hill Ch 12)

## Week 11

* Homework: skills
  * R markdown
* Homework: individual project
  * Project proposal
  * Begin EDA using dplyr and ggplot
* Radon multilevel case study
  * Likelihood and Bayesian algorithms
  * Predictor variables at different scales
  * Alternative parameterizations
  * Credible and prediction intervals

## Week 12

* Homework: skills
  * Using LaTeX to write equations
* Homework: individual project
  * Modeling predictors at different scales
    * Scales of grouping & predictor variables
    * Sketch data structure, write math, write R model formulae
* Multiple nested scales: math and R formulae
* How multilevel models account for autocorrelation
* Generalized linear mixed models (GLMM)
* Accounting for overdispersion using multilevel models
* Case study: revisiting the ants data as multilevel
  * Math and R formulae
  * Using `glmer()` and `stan_glmer()`

## Week 13

* Homework: individual project
  * Fit multilevel model
* Homework: reading & exercises
  * Experimental design
* Binomial GLMM
* Study design: experimental design and sampling design
  * Replication, randomization, control
  * Multiscale experimental and sampling design (randomized blocks, split plots etc)
  * Grouping models for multilevel designs

## Week 14

* Homework: individual project
  * Draft report
* Homework: reading
  * Cross validation
  * Model selection
* Model selection from various perspectives (frequentist, Bayesian, IC)
  * CV, AIC, BIC, WAIC, LOOIC
* Introduction to machine learning
  * Cross validation algorithm
* Either individual meetings about project or maybe these topics:
  * Priors in multilevel models
  * Zero inflated models

## Week 15

* Fake data simulation of multilevel designs
* Posterior predictive check in Bayesian (and potentially frequentist) models
* Leave-one-out influence check
* Homework: individual project
  * Advanced diagnostics
    * Fake data simulation
    * Posterior predictive check
    * LOO influence check

## Where next?

I am currently designing a full two-semester sequence of this course and am writing a textbook *Data Science for Ecology*. These topics will be covered in the book and a selection in future semesters and seminars:

* Bayes factors
* Permutation inference algorithms
* rstan - beyond GLMMs, general hierarchical models
* Machine learning (see my course website from [Spring 2022](https://github.com/EBIO5460Spring2022/class-materials))
  * regression trees, random forest, boosting, neural networks & deep learning
* Time series analysis
* Spatio-temporal models
* Structural equation models
* Unsupervised learning (aka "multivariate statistics")
* Ecological forecasting (see my course website from [Spring 2020](https://github.com/EBIO6100Spring2020/Class-materials))
