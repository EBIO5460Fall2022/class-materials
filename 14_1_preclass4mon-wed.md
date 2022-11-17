### Week 14: Preclass preparation for Mon-Wed

Skill of the week: LaTex for mathematical equations. Reading: binomial and other distributions; study design. Independent project: writing the mathematical model, writing the linear model formula, a first attempt at fitting a model.



#### 1. Skill of the week: LaTeX for mathematical equations

* Tutorial: [repsci06_markdown_equations.md](skills_tutorials/repsci06_markdown_equations.md)



#### 2. Binomial distribution and others

I introduced binomial models in week 13 (see [13_6_swissbbs.md](13_6_swissbbs.md)). Further reading on the binomial distribution is the short section from Chapter 4 of Ben Bolker's book. This reading is in the [Google Drive](https://drive.google.com/drive/folders/1hwgN0sMifgYSMrf8aOi4cJbjRKyTEKoT) (Texts). The section called *Bestiary of distributions* is a handy reference. If you haven't already read it from the earlier homework, it is worth reading through the whole of *Bestiary of distributions* to get a sense of what distributions might be relevant to your individual project.



#### 3. Writing the mathematical model and linear model formula

You may find this challenging but it is important to try to do this. It will help you greatly to understand the model(s) that you are attempting to train and use for inference.

1. Write down the statistical model for the data structure of your independent project using mathematical notation. I typically start with pencil and paper.
   * Write down two parameterizations of the model: the multilevel parameterization and the alternative parameterization, as we covered in class.
   * Review Gelman & Hill Ch 12.5 (Five ways to write the same model).
   * Review lecture notes on models for radon ([12_4_slides_mon_multilevel_M2.pdf](12_4_slides_mon_multilevel_M2.pdf), [12_6_slides_wed_multilevel_M3.pdf](12_6_slides_wed_multilevel_M3.pdf)) and ants ([13_4_slides_mon_ants_GLMM.pdf](13_4_slides_mon_ants_GLMM.pdf)).
2. Translate the equations to LaTeX in a markdown `.md` document (generated from `.R` or `.Rmd`).
3. Include parameter and variable definitions and notes about your model with your equations.
4. **Push your markdown to GitHub**

Don't be concerned if you feel uncertain about this. This is a first draft of the model! I have almost never written down the best model the first time and we have continually iterated models for some designs (e.g. the Wog Wog experiment) over many years. Tips:

* The data scale might not be Normal (e.g. might be Poisson or binomial)
* The grouping scales will always be Normal for GLMMs by definition
* If you have multiple scales of nesting, it's not too hard - just think about how it should work - it is quite logical. Refer to the [lecture slides on nested scales](13_2_slides_mon_nested_scales.pdf).
* If your intended model is complicated, dial back your first attempts. Start with a simpler model, e.g. with fewer predictors, or fewer scales.



#### 4. Linear model formula

Write down the corresponding linear model formula for `stan_lmer()`/`stan_glmer()`, or if you have a more complicated project, whatever is appropriate. Add this to the above markdown document and **push to GitHub**.



#### 5. Have a go at fitting a multilevel model in your individual project

Now that you have scales of predictors and grouping variables identified, and have figured out the math of your model, fit the model in a Bayesian framework using `stan_lmer()` or `stan_glmer()` from `rstanarm`. If your project is not suitable for `lmer`/`glmer` let me know so we can figure out an alternative. You might find it convenient to prototype (i.e. quickly fit) using the frequentist`lmer()` or `glmer()` from `lme4`. However, quite often `lmer()` or `glmer()` will choke on typical ecological datasets (i.e. has convergence issues or worse). As with the Bayesian MCMC algorithm, it often helps a maximum likelihood optimization algorithm to converge if you first standardize the predictors but sometimes even that doesn't help and the Bayesian model might be your only option. Again, if your intended model is complicated, dial back your first attempts. Start with a simpler model, e.g. with fewer predictors, or fewer scales. **Push to GitHub**



#### 6. Study design

On Monday we will consider study design. I have posted reading to the [Google Drive](https://drive.google.com/drive/folders/1hwgN0sMifgYSMrf8aOi4cJbjRKyTEKoT) (Texts):

* Quinn & Keough Ch 7 Design and Power Analysis
  * There are better ways to assess the quality of a design than classical power analysis, so I have only included material on design (not power analysis)
  * Sections on replication, controls, and randomization are especially relevant

