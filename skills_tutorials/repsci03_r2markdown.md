# Markdown from R scripts

Did you know that you can produce markdown (or html, or pdf) from ordinary R code (i.e. from a `.R` script)? GitHub markdown is a superset of markdown that includes markup options for best displaying markdown on the GitHub website. To output GitHub markdown, include the following at the beginning of the `.R` file:

```r
#' ---
#' output: github_document
#' ---
```

In RStudio, all you need to do then is:

* *File > Knit Document*

or click the *Compile notebook* icon, or do *Ctrl-Shift-K*. This will produce a `.md` file and a folder of figures.

You can control the look of this markdown report by using the commenting symbol `#'` in place of the usual `#` symbol. Any text after the `#'` symbol will produce report text while any text after the `#` symbol will produce code comments. For example, this:

```r
#' Generate some fake data to work with. We'll first set a seed to make the example reproducible.
set.seed(4.6)
b0 <- 20 #y intercept
b1 <- 10 #slope
s <- 20  #standard deviation of the errors
x <- 0:25
# Draw random sample
y <- b0 + b1 * x + rnorm(length(x),sd=s)

#' Calculate standard deviation of y
sd(y)
```

will produce the following in the rendered markdown:

------

Generate some fake data to work with. We'll first set a seed to make the example reproducible.

```r
set.seed(4.6)
b0 <- 20 #y intercept
b1 <- 10 #slope
s <- 20  #standard deviation of the errors
x <- 0:25
# Draw random sample
y <- b0 + b1 * x + rnorm(length(x),sd=s)
```

Calculate standard deviation of y:

```r
sd(y)
```

```
## [1] 78.77792
```

------

You can also control code chunks using `#+` to provide [chunking options](https://yihui.name/knitr/options/) as in Rmarkdown. For example,  the following will control the width and height of the plot in the rendered markdown document:

```r
#+ fig.width=14, fig.height=7
x <- 1:10
y <- rnorm(10)
plot(x,y)
```

One thing to watch out for is that plotting commands need to be collected together in a continuous code block without intervening text. For example, this will be able to render to a report:

```r
#' Generate data
x < 1:100
y <- rnorm(100)
#' Make a plot and add a line
plot(x,y)
lines(x,y)
```

but this will not:

```r
#' Generate data
x < 1:100
y <- rnorm(100)
#' Make a plot 
plot(x,y)
#' Now add a line
lines(x,y)
```

Code comments are fine since they are interpreted not as text but as part of the code chunk, so the following will work:

```r
#' Generate data
x < 1:100
y <- rnorm(100)
#' Make a plot 
plot(x,y)
# Now add a line
lines(x,y)
```

Overall, using an ordinary R script with this markup is an excellent and flexible way to work that preserves the workflow as an ordinary R script. For data analysis, I prefer this format to Rmarkdown because in my analyses there is usually much more code than comment and the script can be run without any Rmarkdown dependencies. I also much prefer the flexibility of developing code in ordinary R scripts compared to Rmarkdown chunks.

See the [Render an R script](http://happygitwithr.com/r-test-drive.html) topic in Happy Git with R for more.

You can also render a report in `html`, `pdf`, or `docx` (MS Word). To do so, omit the three lines that include the `output: github_document` statement. After you choose *File* > *Knit Document*, RStudio will present a dialogue box asking which format to use.
