### Week 7: Preclass preparation for Mon-Wed

Bayesian algorithms. I'm going to give you all the homework for the week up front and you can work at your own pace. Aim for all of (1)-(3) and some of (4) by Monday.

#### 1. Skill of the week: practice Git branch and merge

* As you work through this week's coding and problems, challenge yourself to create a branch, add work to the new branch, then merge it with master and delete the branch.
* Reminders: [git07_branching.md](skills_tutorials/git07_branching.md)

#### 2. From prior to posterior distribution

* Read McElreath Chapter 2 (1st edition), sections 2.1.2 - 2.4.1 (pp 25-40).
* Watch McElreath video lecture 2 (you can stop at 60 mins):
* https://www.youtube.com/watch?v=IFRAKBArIyM&list=PLDcUM9US4XdM9_N6XUUFrhghGJ4K25bFc
* There are two short sections of lecture 2 that are not in the book:
  * 18:50 has a few minutes on how to use probability to do typical statistical modeling.
  * 34:20 has a few minutes on evaluating the model.

#### 3. Problem set on using prior information

* Do the following problems from McElreath Chapter 2 (1st edition):
  * 2M1, 2M2, 2M3
  * 2H2, 2H3, 2H4
* **Push your answers to GitHub.** Can be a scan or photo of hand-written solutions. As usual, I won't be scoring for correct answers.

#### 4. Bayesian Normal linear model

* Install the `rethinking` R package (for McElreath book). Running the next three lines of code should install all that is necessary for now. You might be prompted to update some packages to more recent versions if you already have some installed. I chose to update all. Let me know if you have any problems.
  
  ```r
  install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))
  install.packages(c("coda","mvtnorm","devtools","loo","dagitty"))
  devtools::install_github("rmcelreath/rethinking")
  ```

* Note that the above is not sufficient to install all the needed components for McElreath's book. We still need to install Stan components but we'll do that next week. If you want to rush ahead, you can follow McElreath's install instructions here:
  
  * https://github.com/rmcelreath/rethinking

* Read McElreath Chapter 4 (1st edition), except`4.5 Polynomial regression`, which is optional. I have put a heavily modified version of Chapter 4 in the [Google Drive](https://drive.google.com/drive/folders/1hwgN0sMifgYSMrf8aOi4cJbjRKyTEKoT?usp=sharing) (Texts). Please use that version (the modified pdf explains why). I have **removed** and **modified** quite a lot of the text.

* Clean and modified code for Chapter 4 that you can follow along line by line is provided in:
  
  * [07_2_mcelreath_ch4_code.R](07_2_mcelreath_ch4_code.R). 

* Do problems H1-H3. **Commit and push to GitHub.**

* Part of Chapter 4 is another *big idea in data science*. This is another of Laplace's big ideas: the **Central Limit Theorem**, discovered in 1810. The sum of many individual stochastic processes, each of which could come from any of a variety of distributions, tends to a normal distribution. De Moivre had discovered a specific instance of this in 1733 (that a sum of binomial processes tends toward normal).

* Optional: If you want to supplement with some video from McElreath's lecture series, lecture 3 up to 18 mins is about how the Normal distribution arises, and up to 33 mins is about linear models. Stop there since the rest is about the quadratic approximation, which we will not consider.

* https://www.youtube.com/watch?v=0biewTNUBP4&index=3&list=PLDcUM9US4XdM9_N6XUUFrhghGJ4K25bFc
