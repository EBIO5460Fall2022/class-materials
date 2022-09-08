### Week 4: Preclass preparation for Monday

Training algorithms and more git skills. Also make sure you're caught up on any previous work and you've pushed all your work to GitHub so I can provide feedback!

As you work at improving your programming and git skills it's good to struggle a little ... but not too much! If you get to the point of frustration, just post a question on [piazza](https://piazza.com/colorado/fall2022/ebio5460002/home). Definitely feel free to seek help from me and your fellow students on piazza. It's not cheating, it's collaborative learning! For the more experienced programmers I encourage you to provide help there.



#### 1. Skill of the week, git amend, .gitignore, Git GUI

* [git04_amend.md](skills_tutorials/git04_amend.md) - make minor updates without messing up your history
* [git05_gitignore.md](skills_tutorials/git05_gitignore.md) - how to not track all files
* [git06_gitgui.md](skills_tutorials/git06_gitgui.md) - how to invoke the GUI for basic tasks and explore your history



#### 2. Grid search training algorithm

* Finish off coding the algorithm. Look at my code in [03_7_train_ssq_grid.md](03_7_train_ssq_grid.md) for comparison and feel free to tweak yours based on mine.
* Use the algorithm to train the model with your data (the data you used previously for `lm()`). You should find you get the same answer as `lm()`. If not, something is wrong and you'll need to debug your code.
* Notice and comment on the shape of the sum-of-squares profile (the plot of SSQ vs parameter value). Mentally step through the algorithm, particularly the nested for loops, and confirm that the pattern of points makes sense as an output of the algorithm. Is the algorithm working? Do you understand what it's doing? Make a habit of visualizing the dynamic algorithm in your head (like a movie). This imaginative visualization is a central skill of modeling and science.
* Hint: To see where the optimum is, you'll likely need to adjust the limits of the SSQ axis in the SSQ-profile plots.
* **Push your R script to GitHub.**



#### 3. Grid search with an ecological model

We just looked at a SSQ training algorithm applied to a linear model (aka linear regression). Among the [three data science cultures](01_5_slides_wed_3_cultures_of_data_sci.pdf), this was an example of the **generative modeling culture**, which emphasizes generic models and phenomenological algorithms such as linear regression. Let's now apply this training algorithm to an ecological model, an example from the **natural processes culture** of data science, which emphasizes mechanistic models.



**Experimental data**

The data file `paramecium.csv` in the [data folder](/data) contains data from a laboratory experiment with the model aquatic species *Paramecium aurelia* (actually, so as not to make it too hard, these are made up data generated from a detailed stochastic model of births and deaths but let's imagine this scenario). To begin this experiment on population dynamics, 100 individuals were added to a 1 L flask and then sampled every hour for 24 hours. To take a sample, the flask was shaken to mix it well, a 10 ml sample was withdrawn, and the number of individuals in the sample was counted under the microscope, before returning the sample to the flask. Don't forget to first plot the data!



**Mechanistic model**

If we assume that individuals are well mixed in the flask, divide randomly over time to produce offspring, and experience mortality randomly, then we naturally arrive at the following model for the population dynamics over time:

$$\frac{dN(t)}{dt} = rN(t)\left ( 1-\frac{N(t)}{K} \right )$$

where $N(t)$ is the population density at time $t$, $r = b - d$ is the intrinsic rate of growth, a balance of the birth, $b$, and death, $d$, rates of the *Paramecium*, and $K$ is the carrying capacity. This is the classic model of **logistic growth** in continuous time. To translate this model to an algorithm in R code, we could use a general solver for differential equations, such as that found in the R package `deSolve`. But in this special case, there is a closed-form solution to the equation in terms of time and the initial density:

$$N(t) = N(0) \frac{ K e^{rt} }{ K + N(0) (e^{rt} - 1) }$$



**Now train the model!**

To train (or "fit") the logistic model to the data using a SSQ grid search, you can simply use the above equation in place of the linear regression equation in the previous problem to form predictions for the population density, $N(t)$, at any time. Our goal now is to find values of the two parameters $r$ and $K$ that provide the best fit of the model to the data (i.e. minimize the SSQ). First try it assuming that $N(0)$ is known. Then try it assuming that we don't know $N(0)$, which means you will also need to estimate a third parameter, $N(0)$, by modifying your algorithm to also search a grid of values for $N(0)$.



**Push your code to GitHub**



#### 4. Video lecture: optimization algorithms (especially descent algorithms)
   * [04_2_slides_optim_algos.pdf](04_2_slides_optim_algos.pdf)
   * [04_2_video_optim_algos.md](04_2_video_optim_algos.md) - 12 mins

