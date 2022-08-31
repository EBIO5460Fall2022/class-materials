#--------R Base basics--------#
#
# "R base" is the base R language. It's what you have if you don't load any
# packages. These are some basics of the base language.

# Learning goals

# 1) Get help within R
# 2) Use R as a calculator
# 3) Basic conventions of the R language
# 4) Make vectors (c, seq and rep)
# 5) Extract or insert values in a vector
# 6) Use functions
# 7) Read in data from a file and plot it
#
# This overview is designed to be run line by line. Place the cursor on the
# line then send the line to the console by doing:
# 
# Win: CTRL-return
# Mac: CMD-return
# 
# You can also run blocks of code by selecting the block of code then
# CTRL-return or CMD-return.

#----Getting help----

# A primary reference for getting help in R is
# https://www.r-project.org/help.html.
# Read and bookmark this link.

# Getting help within R is actually quite frustrating until you know what you 
# are looking for. For very general things it is often best to try an internet
# search, e.g. try googling:
#       plot a graph in R
#
# The fastest way of getting help within R is to use: ?keyword, e.g.
?Arithmetic #For symbols that can be used
?Syntax     #For operator precedence
# A big problem is that you need to know the keyword that you are looking for or
# you will often either turn up nothing useful or a bewildering array of
# possibilities. Use R_help_keywords to narrow the possibilities. See below.

# At the end of most help topics there is typically example code, and this is 
# often the most useful information. e.g.
?plot         #Find out about the plot function. Look at the examples.
?aov          #Find out about the aov function - analysis of variance.
              #Examples are given at the end of most help topics.
example(aov)  #Run the examples provided with the aov function

#----R base help keywords----

# See rbase02_help_keywords.md for a short list of the most useful keywords.
# When you are looking for something you might want to do, perhaps something
# that we have not talked about in class, go here first rather than searching R
# generally. It's a resource to help you find help when you need it.

#----Other ways of getting help----

# Google (e.g. try "R linear regression"). Often leads to tutorials or
# stackoverflow.com or similar.

# Click the Help tab in R studio (find it in one of the four panes) then click
# on the Home icon. Or click Help from the Rstudio menu, then click R Help. From
# here, you can find the following:
#     Manuals. See especially "An introduction to R"
#     Reference. Search Engine & Keywords
#         Keywords are very useful here. They are like topics. e.g. arith gives
#         you all the functions for doing basic arithmetic. Searching searches
#         only keywords, so it can be a little frustrating. e.g. try searching
#         "linear regression", the result is not necessarily what you want.

# Packages
# The usual way to get an overview of a package, including functions, datasets
# and vignettes is:
library(help="MASS") #package must be installed
# ? with the package name is only sometimes helpful
?stats
# Many packages have vignettes, which are often tutorial-style descriptions of
# how to use the package.
browseVignettes()  #for all installed packages
browseVignettes(package="parallel") #for a particular package

#----R is a calculator----
6 * 5
10 - 8

#----Operator precedence----
# The order in which different operations are carried out
4 * 2 ^ 3
4 * 2 - 3      #Multiplication and division are done before addition and subtraction
4 * ( 2 - 3 )  #Use parentheses if you want a different order
( 4 * 2 ) ^ 3


#----Objects, equations and the assignment operator----
# Values are assigned to objects. The objects are the things with names. An
# object stores values in the computer's memory.
a <- 6  # <- is the assignment operator. Literally, "a is assigned the value 6"
a       # a is an object (it exists in the computer's memory)
b <- 2
b

# When you just type the name of an object, as above, this is equivalent to
# asking R to print the object. It is an implicit print.
b          #Implicit print
print(b)   #Explicit print
# Sometimes, an explicit print is needed, such as within a for loop.


# We can do operations on objects. This next result is not kept in the
# computer's memory because we did not assign it to an object. It just prints
# the result to the console.
a + b
# If we do the same operation and assign it to an object, the result is held in 
# memory. Notice that this R statement is equivalent to the mathematical
# equation c = a + b.
c <- a + b  
c           # c = 8 because a = 6 and b = 2.

#----R is case sensitive----
A <- 3
A
a      #a is not the same as A

#----Objects can have longer names (but no spaces)----
# Tip: use an underline where you would normally have a space
a2 <- 4
a2
this_thing <- 8
result <- a2 * c + b * a   #Use spacing to make your code easier to read
result
result - this_thing

#----Managing objects----
# In R studio, click on the Environment tab to see objects and their current
# values. Or from the command line:
ls()                         #To see objects
rm(a2,npk.aov,npk.aovE,result,this_thing)     #To remove objects

#----Functions----
# Functions take inputs (called arguments) and produce some output. We do many 
# things in R using functions. R has hundreds of built in functions. We can make
# our own functions too but we'll do that later. Arguments are separated by a
# comma.
sqrt(16)
log(4)            #Base e - natural log
?log
# The round function has 2 arguments. The second argument specifies the number
# of digits after the decimal point.
round(4.11111,2)  
?round
# c() is the combine function. It combines all of it's arguments together
# sequentially to make a vector.
mydat1 <- c(0.63, 0.48, 0.24, 0.91, 0.96, 0.43, 0.48, 0.84, 0.93, 0.28)
mydat1
# Functions often take objects as arguments. Here we'll create another vector 
# and plot it against mydat1 using the function plot to make a scatterplot.
# These vectors are input as the arguments x and y respectively.
mydat2 <- c(0.69, 0.43, 0.61, 0.57, 0.69, 0.76, 0.30, 0.99, 0.85, 0.85)
plot(x=mydat1, y=mydat2)
# We don't need to explicitly mention the argument name, we can list the inputs
# to the arguments, provided we do it in the order expected by the function. The
# plot function expects the x variable to be the first argument and the y
# variable to be the second argument.
plot(mydat1, mydat2)
# Functions often also have optional arguments. These need to have argument
# names followed by an = sign. Here we will use optional arguments to change the
# color of the points and change the x and y labels.
plot(mydat1, mydat2, col="red", xlab="x", ylab="y") 


#----Making mistakes----

# This is often a source of frustration. When you type something wrong R might 
# give you a red error message or do something that you weren't expecting. No 
# worries. Take a breath. Zen. Om. 99% of the time you've made a typo. Just read
# your code carefully to find it. Here are some typical examples.
round(7.81493 2)  #left out the comma
# In the next mistake I've left off the closing parenthesis and we are now faced
# with a + sign in the console window. Depending on the GUI your are using, you
# may need to click in the console window and hit Esc to recover from this
# error. In R Studio on windows, the error in the next line will carry into the
# line after it.
round(7.81493,2  
# In the next mistake I have two closing parentheses instead of one.
round(7.81493,2))


#----Vectors and scalars----
# A vector is a type of "data structure". A data structure is a structure that
# holds data in the computer's memory. Different data structures hold different
# types of data or organize them in different ways. A vector is like one column
# of data. It can hold numbers or text (but not both).
v1 <- c(4,5,6,7,34,28)  #c is the concatonation function
v1
v1 * 2    #Multiplies each value in the vector by 2
s1 <- 5   # A vector with only one value is called a scalar. s1 is a scalar.
s1

# There are many functions that work with vectors - some examples
sum(v1)
min(v1)
max(v1)
mean(v1)
var(v1) #variance

# Vectors can also be created using the : operator and the seq and rep functions
v2 <- 1:10
v2
10:1 
-5:5
v3 <- seq(2, 50, by=2)
v3
?seq
rep(3, 10)

#----Relational and logical operators----
?Comparison
?"&"
4 < 2
4 = 2   #This is an error
4 == 2  #The relational "equals" operator is the correct way

b = 2 #This is not an error but what happened here? "=" is also an
      #assignment operator like "<-"
b
# It is a common R convention to NOT use the = sign as an assignment operator 
# (although some people do use =, and that's OK; we won't in this class)

a <- 4
b < a   #TRUE because b = 2 and a = 4
b < 2
b < a & b < 2  #logical AND
b < a | b < 2  #logical OR

#Relational and logical operators work on vectors too
v1
v2 <- v1 < 25
v2  #v2 is a "logical" vector


#----Element-by-element----
# Operations on vectors usually work "element-by-element". This means that if we
# multiply a vector by a scalar, each element of the vector will be multiplied 
# by the scalar. Similarly, if we add two vectors together, they should have the
# same number of elements and the corresponding element of each vector will be
# added together to give a new vector.
v4 <- v1 * 2
v4
v1
v1 + v4       #Adds the elements of v1 and v4
v1 * v4

#----The extract/insert operator []----
# Indexes the elements of a data structure
v1[2]  #Extracts element 2 from the vector v1
?"["

#Extract elements 1, 3, 5, and 6 from the vector v1
v1[c(1,3,5,6)]

#Extract all of the elements of the vector v1 that are less than 25
v5 <- v1[v1 < 25]
v5

#Insert the value 42 into element 2 of the vector v1
v1[2] <- 42
v1

#----Character vs numeric vectors----
a <- c("A","B")
a
class(a)  #Asks: "what class (or type) of object is a?"
b <- c(6,3)
b
class(b)

# If you make a vector by combining numerics and characters, the numerics
# are converted to character
test <- c(6,"b")
test
class(test)

#----Matrices: 2 dimensional arrays----
vals <- c(1.1, 8.7, 7.7, 7.1, 4.4, 5.2, 6.7, 5.2, 2.0, 6.0, 3.1, 1.2)
m1 <- matrix(vals, nrow=4, ncol=3)
m1
class(m1)
m1[2,1]  #The extract function works on matrices too; you need row and col index
m1[2,]
m1[3,2] <- 10.5
m1
?matrix


#----Reading in and plotting data----

# First read in the data. We will almost always use read.csv(). The file
# "rbase01_cats.csv" must be in your current working directory.

# csv: comma separated values file. Make it in Excel >> save as .csv
#
catsdat <- read.csv("rbase01_cats.csv")   #?read.csv
class(catsdat)   #catsdat is a data structure called a data.frame
catsdat          #Print the data to the console
head(catsdat)    #First 6 rows by default
head(catsdat, 2) #First 2 rows instead
catsdat[5:7,]    #Using the extract operator to obtain rows 5 to 7
tail(catsdat)    #Last 6 rows by default

#----Plotting and manipulating data---
# Use the $ operator to access columns within a data.frame
catsdat$Number_of_stories_fallen
# Notice that this is a character vector because of "7 to 8". We will fix that
# by making a new numerical vector with the average of the last two categories.
catsdat$Num_stories <- c(2:6, 7.5, mean(9:32))
# This has made a new column within the catsdat data.frame
head(catsdat)
# Here is a standard, quick, no-frills plot
plot(catsdat$Num_stories, catsdat$Average_number_of_injuries_per_cat)


#----Using packages----

# We will use quite a few packages in this course. Before you can use a package
# you first need to install it.
# In RStudio: Tools -> Install packages.
# Type the name of the package you want to install (e.g. vegan), then press
# Install.

# Vegan is a package for community ecology, particularly multivariate analyses.
# Load vegan
library(vegan) #Now go and look at the html help for vignette
data(dune) #loads a dataset
ord <- metaMDS(dune)
plot(ord)
