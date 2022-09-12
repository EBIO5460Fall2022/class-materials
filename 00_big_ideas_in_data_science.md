### Big Ideas in Data Science

These are ideas that cut across algorithms and paradigms. I'll add more as we come across them.

* A focus on algorithms and workflows unites data science across modeling cultures.
* For any analysis you'll need to choose at least three algorithms: model algorithm, training algorithm, inference algorithm.
* Top down refinement of data science algorithms. Allows progress to be made in specific areas of a broad algorithm. Examples include deep learning as a refinement of neural networks, MCMC as a refinement of Bayesian updating, HMC as an improvement on Metropolis-Hastings, QR decomposition as an improvement for optimizing SSQ. Such refinements often have huge impacts, such as deep learning and MCMC.
* Legendre's big idea (1805). Using one algorithm (training algorithm) to train another (model algorithm) on data. Legendre devised an algorithm to predict the orbits of comets (the model algorithm). He came up with an algorithm to train his comet algorithm on data. This was the least squares algorithm. Least squares was used by Legendre to investigate the shape of the Earth and ultimately to determine the length of 1m. We now have a wide variety of training algorithms. Gauss claimed to have discovered the idea 5 years earlier (the dispute is famous) and went on to extend the idea and link it to the normal distribution (and is why normal is often called "Gaussian").
* Counting all the ways data could have happened. Gives rise to probability models for frequentist (sampling distribution), likelihood (likelihood function), and Bayesian (posterior distribution).
* Laplace's big idea (1810). Central Limit Theorem. The sum of many individual stochastic processes, each of which could come from any of a variety of distributions, tends to a normal distribution. Extending De Moivre who showed the same for binomial processes in 1733.
* A general inference algorithm is to simulate the trained model.

* The linear model, including two generalizations, the generalized linear model and multilevel (mixed effects) models. Traditional statistical procedures such as ANOVA, ANCOVA, two-sample tests, contingency tables, etc, are special cases.
* Using models that are linear in parameters for models that are nonlinear for y=f(x).
* Fisher's big idea (Fisher had many!) was to imagine future repetitions of an experiment, ultimately giving rise to his p-values (perhaps we now wish he hadn't, or perhaps the blame for abuse of NHST is to be placed on Neyman and Pearson, but it was the most widely feasible solution at the time). Laplace came up with the p-value idea earlier. Fisher made it into a more general concept (or perhaps he just popularized it).
* Laplace's big idea (Laplace also had many!) was to form the posterior from draws from the prior and likelihood, rejecting the draws that didn't match, ultimately giving rise to the basic Bayesian computational algorithm. Need to track this down. I think it was Laplace but maybe I'm getting confused with CLT.
* Hierarchical stochastic models. Multi-level models are special cases.
* Galton. Regression. circa 1900.
* Law of large numbers. (ps does this relate to big data? probably not)
