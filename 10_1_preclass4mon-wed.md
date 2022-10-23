### Week 10: Preclass preparation for Mon-Wed

Visualization and data manipulation skills. Bayesian generalized linear models using `rstanarm`. Aim for (1)-(3) for Monday and (4)-(5) for Wednesday; **nb (4) is mandatory submission before class on Wednesday** and will follow frequentist and likelihood GLMs in class on Monday.



#### 1. Skill of the week 1: Designing a visualization with ggplot

Use `ggplot` to plot the ants data together with the naive linear regression model that you fit previously (for now you can use `geom_abline()` to add the lines for the fitted model but we will soon see a more sophisticated way to plot the model). Explain and justify your design choices in terms of the principles of visualization (see lecture slides [09_7_wed_vis_ggplot.pdf](09_7_wed_vis_ggplot.pdf)).

**Knit to GitHub markdown format and push to GitHub**



#### 2. Skill of the week 2: Data manipulation with dplyr

As we move into data with more complex structure it helps to have a good tool like the `dplyr` package for quickly and consistently manipulating data. Work through chapter 5 of R for Data Science, including the exercises.

* http://r4ds.had.co.nz/transform.html



#### 3. Video lecture: model formulae

* [10_2_slides_model_formulae.pdf](10_2_slides_model_formulae.pdf)
* [10_2_video_model_formulae.md](10_2_video_model_formulae.md) - 8 mins



#### 4. Bayesian analysis of the ant data using `stan_glm()` from rstanarm

This can't be done until after Monday's class. The Bayesian analysis will mimic the frequentist analysis (demonstrated in Monday's class) but now using `stan_glm()`. See the [glm cheatsheet](10_3_glm_cheatsheet.R) (posted after Monday's class) and refer back to what you learned for Bayesian ordinary linear models in McElreath Ch 4.

* `stan_glm()` has good default priors for the parameters. We don't need to specify them as we have up until now. We'll take a look at those choices in class.
* Focus on estimates of the $\beta$s. Regression intervals (credible intervals and prediction intervals) are somewhat more involved coding wise, so I'll demonstrate these later.
* Compare the estimates of uncertainty in the $\beta$s with those from the frequentist analysis done in class.

**Knit to GitHub markdown format and push to GitHub before class on Wednesday.**



#### 5. Poisson distribution

Read the short section on the Poisson distribution, from Chapter 4 of Ben Bolker's book. This reading is in the [Google Drive](https://drive.google.com/drive/folders/1hwgN0sMifgYSMrf8aOi4cJbjRKyTEKoT?usp=sharing) under Texts. The section called *Bestiary of distributions* is a handy reference going forward.



