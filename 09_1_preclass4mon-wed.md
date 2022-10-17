### Week 9: Preclass preparation for Mon-Wed

This week we will cover checking model assumptions (a.k.a diagnostics), introduction to GLM, and visualization theory. Again this is all the homework for the week up front and you can work at your own pace. Do at least (2) & (3) by Monday, preferably also (4). We will talk about visualization theory and `ggplot`on Wednesday, so be sure to have read the paper by then.

#### 1. Homework revisions for weeks 1-4

I have returned feedback on your repositories through week 4. This feedback tells you what you have successfully completed. If there are incomplete items, you'll need to revise to get completion credit. See [00_feedback_revision.md](00_feedback_revision.md) for how to see and revise those. This is also practice for collaboratively working using git and GitHub. There is no particular timeline for revisions but you can revise as many times as you like until you get to completion. Email me when you push your revisions back to GitHub.

#### 2. Model diagnostics

View and listen to the lectures on model diagnostics (for Normal linear and generalized linear models). The audio is separate; advance the slides manually yourself. This recording is from a previous year. Explore the code.

* Slides: [09_2_diagnostics_slides.pdf](09_2_diagnostics_slides.pdf)
* [Audio (30 mins)](https://www.dropbox.com/s/xcg22i5vrwcdy53/09_aud1_diagnostics.mp3?dl=0)
* Code: [09_3_diagnostics1.R](09_3_diagnostics1.R), [09_4_diagnostics2.R](09_4_diagnostics2.R)

There is a separate R tutorial for QQ plots (there is no accompanying lecture material). 

* tutorial: [09_5_quantiles-qqplots.md](09_5_quantiles-qqplots.md)

An issue that is not covered in these lectures is **leverage**. Currently there are no widespread methods available for this in multilevel models, so it is a bit of a specialist thing for simple linear models and GLMs, so I'm going to skip the theory for it. The general idea is that a point with high leverage is an influential point in a special way: typically it is at one end of the independent variable and it is far from the fitted line relative to other points. Because of the geometry, the point "pulls" on the line like a lever, thus affecting the estimate of the slope. For Normal linear models and some other GLMs leverage can be visualized like this (where `fit` is the saved fitted-model object from `lm()` or `glm()`):

```r
plot(fit, 5)
```

#### 3. Diagnostics with naive ants analysis and your linear data

We will continue working with the ants data on Monday, sharing your ideas for analysis. Each group noticed different things and had great ideas for analysis. You also identified features of the data that would make a straight-up linear regression problematic. Here in the homework, we will dive deeper into identifying problems with the assumptions of a standard Normal linear regression model for these data.

* Read in the ants data and convert the habitat variable to a factor:
  
  ```r
  # Read in data
  ant <- read.csv("data/ants.csv")
  
  # Quick view of the dataframe
  head(ant)
  
  # Set habitat to be a factor
  ant$habitat <- factor(ant$habitat)
  
  # Print the habitat column. The factor levels are shown at the end.
  ant$habitat
  ```

* A  factor is an R data structure for categorical variables. See `?factor`. One attribute of a factor is the *levels* of the factor, sorted alphabetically by default.

* Using a `.R` file (i.e. not `.Rmd`) fit a Normal linear model to the ants data that would best address the scientific questions posed in class. The appropriate model is a multiple regression with an interaction of latitude and habitat. We will not include the `elevation` or `site` variables for now. It's easiest to fit this model with `lm()`.
  
  ```r
  fit <- lm(richness ~ habitat + latitude + habitat:latitude, data=ant)
  ```

* Don't attempt to fix any problems with the model (i.e. don't transform the data or use a different distributional assumption or nonlinear model).

* Construct diagnostic plots for this model. To extract some basic information used to construct the plots, you can use

  ```r
  r <- fit$residuals
  fv <- fit$fitted
  cooks <- cooks.distance(fit)
  ```

* Describe the patterns in the diagnostic plots. What assumptions of the Normal linear model are violated according to these patterns?

* In a separate `.R` file, do the same for your dataset that you have been using for linear models so far.

* **Knit** each analysis to a **markdown report** and **push to GitHub.**

#### 4. McElreath Ch 9: Introduction to generalized linear models

The models we have encountered so far are a special case of generalized linear models (GLMs). We are going to extend now to the general case of a GLM: a linearly-transformed model with a range of possible distributions for the data. This is within the assumed prerequisite for this class, so hopefully some of this is revision, reinforcement, or another perspective for most of you.

* Read section 9.2, pp 280 - 288.

* Skip 9.2.4. The information here is incorrect: you can indeed compare models with different likelihoods via AIC, although you need to be careful to do it right.

* **Optionally**, the perspective on maximum entropy in section 9.1 is quite interesting and somewhat unique (this perspective is heavily influenced by Jaynes 2003 Probability Theory) but you don't need to understand this. If this is your first time encountering GLMs, skip it since it is more likely to be bewildering than helpful.

#### 5. Skill of the week: Visualization

* Theory and concepts behind `ggplot`. Read Wickham's paper:
* http://vita.had.co.nz/papers/layered-grammar.pdf
* Work through Chapter 3 of R for Data science, including the exercises:
* http://r4ds.had.co.nz/data-visualisation.html
* We will be using `ggplot` a lot from now on.
