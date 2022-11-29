### Week 14 Reading on model selection

#### 1. Cross validation (CV)
* Cross validation (CV) algorithms can be applied to just about any prediction problem. CV is a Swiss army knife. It is widely used in machine learning. It is also the basis for most modern model selection approaches, and provides the underlying theory for one derivation and justification of information criteria such as AIC.
* Reading: James et al. pp 198 - 208 (Google Drive in *Texts*).

#### 2. Model/variable selection algorithms

We have two basic approaches: 

* 1. Hypothesis testing: Algorithms include best subsets, forward or backward stepwise
* 2. Prediction performance: The most general tool is CV. Information criteria include AIC, BIC, DIC, WAIC, LOOIC. Other criteria include *Cp*, and $R^2$.
* Reading: James et al. pp 225 - 236, McElreath pp 188 - 195 includes DIC, WAIC. (Google Drive in *Texts*).

#### 3. Leave One Out Information Criterion (LOOIC)
* The state of the art is LOOIC, a more accurate algorithmic version of the Widely Applicable Information Criterion (WAIC). Use LOOIC for Bayesian hierarchical models. Facilities are built in to `rstanarm`, so this is fortunately very easy to implement.
* Reading (optional technical): [Vehtari et al. 2017](https://link.springer.com/article/10.1007%2Fs11222-016-9696-4) (also in Google Drive in *Other reading*).
* For how to use with `rstanarm`, any of the vignettes here include LOOIC (pick your model type): http://mc-stan.org/rstanarm/articles/index.html.

