# R markdown

Many of you have been using pure R markdown extensively already with `.Rmd` files. If you haven't, try it out now.

* Work through Chapter 27 of R for Data Science: https://r4ds.had.co.nz/r-markdown.html
* The key features of R markdown are code chunks (delineated by code fences), and chunk options.

On the other hand, if you've been sticking to pure R markdown up to now, try using your R markdown skills within a `.R` file instead (see [repsci03_r2markdown.md](repsci03_r2markdown.md)).



## Github markdown from Rmarkdown

To output GitHub markdown, include the following at the beginning of the `.Rmd` file:
```r
---
output: github_document
---
```
This will produce a `.md` file and a folder of figures (as well as a `.html` file).

Then, in RStudio do:
* *File > Knit Document*

or just click the *Compile notebook* icon, or do *Ctrl-Shift-K*.
