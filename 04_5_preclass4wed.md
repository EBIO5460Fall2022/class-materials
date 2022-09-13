### Week 3: Preclass preparation for Wednesday

Descent training algorithm. Inference algorithms. Frequentist inference.



#### 1. Descent algorithm for a natural-process model

Use the Nelder-Mead algorithm in `optim()` to train the logistic-growth model.

* Modify the example code in [`04_4_train_ssq_optim.R`](04_4_train_ssq_optim.R), which we derived in class for a linear model, to fit the logistic growth model to the *Paramecium* data. 
* **Push your R script to GitHub.**



#### 2. Video lecture: inference algorithms

   * [04_6_slides_inference_algos.pdf](04_6_slides_inference_algos.pdf)
   * [04_6_video_inference_algos.md](04_6_video_inference_algos.md) - 40 mins

There are three parts to the video:
   1. Intro to inference algorithms. **0-9 mins**. Watch this **before the reading** on the the sampling distribution. It includes the big idea of "Considering all the ways that data could have happened".
   2. Frequentist inference: the sampling distribution. **9-29 mins**. Watch this **with the first reading**.
   3. Frequentist inference for `lm()`. **29-40 mins**. Watch this **with the second reading**.



#### 3. Reading: sampling distribution

Read two pieces about the sampling distribution, the foundation of frequentist inference, and how that is applied by `lm()`. These are best read in the markdown `.md` format on GitHub (in your browser) because the equations and so on will render nicely there. The markdown version was generated from the code in the `.Rmd` file. You can explore the code from the `.Rmd` version from within R studio.

   * [04_7_sampling_distribution.md](04_7_sampling_distribution.md)
   * [04_8_lm_ssq_inference.md](04_8_lm_ssq_inference.md)



