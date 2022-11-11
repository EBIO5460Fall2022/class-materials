### Week 13: Preclass preparation for Mon-Wed

Skill of the week: adding images/figures to markdown documents. Independent project: identifying scales of variables, exploratory data analysis (EDA).



#### 1. Skill of the week: adding images to markdown documents

[repsci05_markdown_images.md](skills_tutorials/repsci05_markdown_images.md)




#### 2. Independent project: scales of variables and study design

We saw in the radon example that a multilevel model is used when it is necessary to model multiple scales of variation. The variables in a multilevel model comprise:

1. **Grouping variables** that collect together units belonging to a group. In the radon example, county is a grouping variable; it collects together houses that belong to a county. Such variables are sometimes called random effects. In the mathematical model, these variables will have a distribution indicated by the `~` symbol.
2. **Predictor variables** that predict the outcome in a unit or group. Such variables are sometimes called fixed effects. In the mathematical model, these variables will be part of a deterministic equation following the `=` symbol.

Grouping variables identify spatial and temporal scales of variation to be modeled (i.e. estimated or accounted for). For each grouping variable, there will be an estimated variance at that scale. Thus, in the radon example, both the variance between counties (*county*) and the variance between houses within counties (*residual*) is modeled. This is an example of **spatial scale** but the idea applies to **temporal scales** too. For example, you could have sample weeks within sample seasons; *season* would be a grouping variable that collects together weeks. Spatial and temporal scales could also be mixed to give **spatio-temporal** scales. For example, consider collecting data from multiple sites over multiple years. Then, *site* would be a grouping variable that collected together sample years within the same site and we would then have two scales of variation to be estimated: between sites (pure spatial variance) and between years within sites (spatio-temporal variance). There would also be pure temporal variance, which would be measured by grouping the data by *year* across sites. We could include both *site* and *year* as grouping variables in the same model, depending on our goals.

Predictor variables can apply to different scales. In the radon example, we included both a between-house predictor (*floor*) and a between-county predictor (*uranium*). The between-house predictor was measured for each house, while the between-county predictor was measured for each county (but not each house). Thus, the predictors had a characteristic **scale of measurement**.

For your independent project

1. Identify the scales of variation in the sampling design. What grouping variables are needed? Explain why this is a grouping variable and should be treated as a stochastic component of the model.
2. Identify the scale of the response variable: this will be the smallest scale of sampling unit that you can estimate. Explain how you determined that this is the scale of the variable (i.e. why?).
3. Identify the scales of measurement for the predictor variables. Explain how you determined these scales (i.e. why?).

Make a sketch of your sample design, like the one we made in class for the radon data, showing the different grouping scales and predictor scales. You could either hand draw your sketch and take a photo or scan it, or make it in presentation software. Insert the sketch into your markdown document. **Push to GitHub**.



#### 3. EDA for individual project

Use Rmarkdown (`.Rmd` file format), `dplyr` for data manipulation and `ggplot` for plotting. Think about how best to display the multilevel structure of your data. Aim to show the data clearly. Show all the data. Use comments/text to explain how the data are structured. Work hard to spot any potential problems using plots, and code queries such as `unique()`, `range()`, `class()`. Consider appropriate distributions.

**Push your EDA to GitHub** in both `.Rmd` and GitHub markdown (`.md`) format.  The exception to this is if you have been using `.Rmd` exclusively up to now. Switch to try `.R` with Rmarkdown formatting instead.
