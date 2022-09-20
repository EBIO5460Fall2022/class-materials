### Week 4: Preclass preparation for Wed

Make sure you're caught up on any previous work and you've pushed all your work to GitHub! Don't hesitate to reach out to me for tips with any areas of the homework so far. Or for even faster help, ask questions on Piazza!

In class on Monday we began to think about an algorithm for a bootstrapped p-value for the slope parameter of the linear model.  Continue to think about this. 

From [04_8_lm_ssq_inference.md](04_8_lm_ssq_inference.md) the definition of a p-value is:

> The probability of a sample statistic as large **or larger** than the
> one observed **given that some hypothesis is true**.

From [05_2_bootstrap_algo.md](05_2_bootstrap_algo.md) the basic parametric bootstrap algorithm is:

```
repeat very many times
    sample from the error distribution
    create new y-values from the estimated parameters and errors
    fit the linear model
    estimate the parameters
plot sampling distribution (histogram) of the parameter estimates
```

We want to modify this algorithm to reflect the definition of a p-value. We got as far as realizing that we need to consider the null hypothesis to be true. The null hypothesis is also a model, the model in which the slope is zero, and it will be this model that we'll need to use to generate simulated data. 

Write pseudocode or a general idea for an algorithm to bring to class on Wednesday.

