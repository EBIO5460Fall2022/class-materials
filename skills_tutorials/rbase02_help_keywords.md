KEY HELP TOPICS IN BASE R

Brett Melbourne
University of Colorado
Updated 22 Aug 2022

It is often frustrating to find what you need in the labyrinthine R help system. This list is a quick reference to the key, basic functionality of base R. It is based on a list originally compiled by Richard O'Keefe
http://www.cs.otago.ac.nz/staffpriv/ok/R-help.txt

A more exhaustive search for help topics is from the html help under keywords by topic. Start html help: `help.start()`.


THE R LANGUAGE AND PROGRAMMING

    ?Syntax             Operators and their precedence
    ?Control            if, while, for etc
    ?"function"
    ?switch
    ?Extract or ?"["    [] Read carefully and often
    ?Paren              () {}

ARITHMETIC, LOGICAL, AND MATH FUNCTIONS

    ?Arithmetic         + - * %% etc
    ?Comparison         > < == != etc
    ?Logic              & && | ! etc
    ?abs                Absolute value
    ?sqrt               Square root
    ?exp                Exponents
    ?log                Logarithms
    ?pi                 and other constants
    ?round              and ceiling, floor, signif etc
    ?Trig               cos, sin etc
    ?Special            beta, gamma, binomial coef. (choose), factorial

BASIC DATA TYPES AND STRUCTURES

    ?numeric            Continuous values
    ?integer            Discrete values
    ?character          Text values
    ?logical            TRUE FALSE values
    ?matrix             Row by column of numbers
    ?array              Like a matrix but more than 2 dimensions
    ?list               To store mixed data types
    ?data.frame         Data in columns
    ?NA                 Missing values
    ?class              Find out what type of object
    ?factor             Categorical variables (typically for regression models)

CREATING VECTORS

    ?c                  Combine/concatonate
    ?":"                Integer sequences
    ?gl                 Create factors
    ?interaction        Interaction factor
    ?rep                Repeat
    ?seq                Sequence

BASIC OPERATIONS ON VECTORS

    ?length             Number of elements
    ?"["                Indexing to extract or insert
    ?sum                Add the elements
    ?max                and min
    ?order              What order are the elements in?
    ?sort               Sort the elements 
    ?cumsum
    ?lapply
    ?names
    ?rank

LOGICAL VECTORS

    ?"&"                Logical operators, AND NOT OR
    ?all                Is every element TRUE
    ?any                Is any element TRUE
    ?identical
    ?ifelse             If TRUE A, else B. A function, not a control structure.
    ?which              Which indices are TRUE?
    ?"%in%"             Same as ?match. Indices of matches

STRING (CHARACTER) OPERATORS

    ?paste              Probably the most useful
    ?grep               Character matching, see also help topics within
    ?nchar              Number of characters
    ?sprintf
    ?strsplit
    ?strwidth
    ?strwrap
    ?substr

MATRICES

    ?colMeans           and rowMeans
    ?colSums            and rowSums
    ?ncol               and nrow
    ?t                  Transpose
    ?"["                Indexing to extract or insert, with special attention to 'drop'
    ?"%*%"              Matrix multiplication
    ?"%o%"              Outer product
    ?"%x%"              Kronecker product
    ?col
    ?colnames
    ?det
    ?diag
    ?dim
    ?dimnames
    ?drop
    ?eigen
    ?lower.tri
    ?qr
    ?rowsum
    ?solve
    ?svd

ELEMENTARY STATISTICS

    ?mean
    ?median
    ?var                Variance
    ?sd                 Standard deviation
    ?range
    ?quantile
    ?IQR
    ?fivenum
    ?summary

LINEAR MODEL FITTING

    ?lm                 Fit a linear model to data
    ?summary.lm         Output of the model fit
    ?formula            Essential reading for linear model fitting
    ?coef               Parameter estimates
    ?residuals
    ?fitted.values
    ?plot.lm            Diagnostic plots
    ?predict    
    ?AIC
    ?anova
    ?aov
    ?glm                Fits generalized linear models
    ?glmer              Generalized linear mixed models: library(lme4)
    ?lmer               Linear mixed models: library(lme4)
    ?vcov

ECOLOGICAL AND EVOLUTIONARY MODELS (INCLUDING FITTING)

    ?mle                Maximum likelihood: library(stats4)
    ?optim              Workhorse for optimization
    ?optimize           For one dimensional optimization
    ?logLik
    ?AIC
    ?coef
    ?confint
    ?ode                Differential equations: library(deSolve)

INPUT/OUTPUT

    ?read.csv           Read a csv data file
    ?write.csv          Write a csv data file
    ?head               Show the first few rows of data
    ?tail               Show the last few rows of data
    ?library            Load an R package
    ?source             Read in code
    ?data               Built in data sets in R
    ?save               Save a dataset to an R file
    ?load               Load a saved R data file
    ?scan
    ?read.table
    ?write.table

DATA/OBJECT HANDLING AND MANIPULATION

    ?subset             Subset a data frame
    ?cbind              and rbind. Join vectors, matrices, data frames.
    ?names              Names of an object.
    ?ncol               and nrow. Number of columns.
    ?length
    ?table
    ?aggregate
    ?apply
    ?reshape
    ?stack

PLOTTING

    help.search("hplot")          Lots of plot types and related functions
    ?plot               Scatterplot (or default plot for object class)
    ?dotplot            Dotplots (often a better choice than barcharts)
    ?barplot            Barcharts
    ?boxplot            Boxplot
    ?hist               Histogram
    ?matplot            Plot columns of a matrix
    ?pairs              Scatterplot matrices
    ?points             Add points
    ?lines              Add lines
    ?curve              Add a curve
    ?axis               Add an axis
    ?abline             Add a line (y=a+b*x)
    ?box                Add a box outline/frame
    ?grid               Add a grid
    ?segments           Add line segments and arrows
    ?arrows             Add arrows
    ?text               Add text within a plot
    ?mtext              Add text to plot margins
    ?legend             Add a legend
    ?plotmath           Add mathematical equations
    ?par                Set line types, fonts, colors, margins, plot layouts etc
    ?colors             See also help topics within
    ?jitter             To jitter data points in a plot
    ?quartz             Open a graphics window in Mac OS X    
    ?windows            Open a graphics window in Microsoft Windows
    ?Devices
    ?dev.off

DISTRIBUTIONS, RANDOM NUMBERS, AND RANDOM SAMPLES
Distributions have d<foo> density, p<foo> pdf, q<foo> inverse pdf,
and r<foo> random generator functions.

    ?dbeta
    ?dbinom
    ?dchisq
    ?dexp
    ?df
    ?dgamma
    ?dlnorm
    ?dmultinom
    ?dnbinom
    ?dnorm
    ?dpois
    ?dt
    ?dunif
    ?dweibull
    ?sample             Random samples
