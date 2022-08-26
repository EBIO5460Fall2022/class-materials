# EBIO5460 R style guide
When you work together on a project, it's a good idea to use the same coding style. Similarly, since I have to grade all of your coding assignments, it helps me if we all use the same style. We will adopt the following style for this class.



## Object names
Variable and function names should generally be lowercase, except where mathematical convention suggests otherwise. Use an underscore (`_`) to separate words within a name, except where numbers are appended. Strive for names that are short (try and keep them under 10 characters) yet meaningful so that the code is self documenting (a convention widely used in the software industry). Nevertheless, use compound names sparingly and don't overdo the meaningful name idea. In contrast to the software industry, much of what we do is math and related to equations or models with widely used conventions. Then, single letter variable names that match equations are desirable.

### In style
```r
day1       #Nice
d          #Best if d is from an equation
d_1        #Best if d subscript 1 is from an equation
day_one    #Excessive for this particular example
fdom       #Last resort for when you must be explicit but very short
N          #Widely used in ecology for population abundance
```

### Not in style
```r
dayOne                #This is camel case, which we won't use
first_day_of_month    #Who wants to type this. Limit to rare cases.
Day_one               #Don't capitalize
dayone
day.one
population_abundance  #As ecologists, we know what N means
abundance             #Ditto
```
Some software industry folks might be appalled that, say, `first_day_of_month` or `population_abundance` are not in style but `d_1` or `N` are. However, R style tends to be more terse. For example, consider that the name of the function to calculate the standard deviation is `sd`, not `calcStandardDeviation`. Frankly, I'm glad we don't have to type the latter.



## Assignment
Use `<-`, not `=`, for assignment.

### In style
```r
x <- 5
```

### Not in style
```r
x = 5
```



## Spacing
Place spaces around all mathematical operators (arithmetic, logical, comparison) and the assignment operator (`+`, `-`, `<-`, etc.) but not around other operators. However, you can use a judicious lack of space to clarify groupings in complicated equations. Keep your script clean (for example, don't leave a string of spaces on an empty line).

### In style
```r
x <- a + b * c
x <- 1:10
x <- y[3,2]
x <- 2 * 3 ^ 2
x <- 2 * 3^2
x <- 2 * 3 + a - b / 2
```

### Not in style
```r
x<-a+b*c
x <- 1 : 10
x <- y [ 3, 2 ]
x <- 2*3^2
x <- 2*3+a-b/2
```



## Control structures (if, for, while etc)
Always use curly braces. An opening curly brace should never go on its own line and should always be followed by a new line. A closing curly brace should always go on its own line, unless it is followed by `else`. Indent the code inside curly braces by **four spaces**. If you're feeling like a pro, feel free to go with two spaces if that's what you're used to. But if you're new to structured programming, four spaces really helps to make the algorithmic structure stand out. There should be a space before and after the opening parenthesis of the control structure and a space before and after the closing parenthesis. Never use tabs.

### In style
```r
if ( y < 0 ) {
    message("Y is negative")
}

if ( y == 0 ) {
    log(x)
} else {
    y ^ x
}

for ( i in 1:10 ) {
    x[i] <- 2 * i
}
```


### Not in style
```r
if( y < 0 )
    message("Y is negative")

if( y < 0 ) message("Y is negative")
    
if(y ==0){
    log(x)
}else {
    y ^ x
}

for (i in 1:10) {
    x[i] <- 2 * i
}
```



## Function calls
Don't use spaces around function parentheses. Spaces are optional after commas or around mathematical operators within parentheses of a function call. Don't use spaces around the `=` symbol. Don't use spaces in nested function calls. Balance the need for readability and fitting on a line. Use your judgment.

### In style
```r
plot(x,y)
plot(x, y)
plot(x, y=2*z, xlim=c(0,100), ylim=c(-10,10), type="l")
plot(x,y,xlim=c(0,100),ylim=c(-10,10),main="My plot of some data",type="l")
y <- c(1,2,6,2,8,6,12)
```

### Not in style
```r
mean (y)
plot(x, y, xlim = c(0,100), ylim = c(-10,10), main = "My plot of some data", type = "l")
plot(x, y, xlim=c(0, 100), ylim=c(-10, 10))
plot( x, y )
```



## Function definitions
Do not rely on R’s implicit return feature. It is better to be clear about your intent to `return()` an object.

### In style
```r
add_values <- function(x,y) {
    return(x + y)
}
```

### Not in style
```r
add_values <- function(x,y) {
    x + y
}
```



## Line length
Strive to limit your code to 80 characters per line.



## Documentation and commenting
Each line of a comment should begin with the comment symbol (`#`) and a single space. Inline comments should be short, positioned for readability, and do not require a space after the `#`. In function definitions, arguments and returns should be described.

### In style
```r
# Linear regression of weight data
fit <- lm(weight~height)
plot(height,weight)
abline(fit)     #Note outlier
residuals(fit)  #Outlier is case 52
```



## Layout

Order your program as follows:
1) Description (include purpose of program, author, version, date)
2) `source()` and `library()` statements
3) Function definitions
4) Executed statements



## Footnote

There is no agreed upon R style. For example, here is [one R style](https://style.tidyverse.org/syntax.html) by Hadley Wickham used with tidyverse. Wickham says his style is based on Google's original R style guide (but they were both rather different in detail in many areas). Google has a new R style guide [here](https://google.github.io/styleguide/Rguide.html). Our class style adopts components of these styles. This class is about algorithms, so the spacing rules emphasize the control structures in algorithms to a greater degree than tidyverse style, which instead emphasizes functions.
