# Programming problems on repetition structures

This is a problem-set assignment. You should submit only one file of R code. The filename should be `coding_assignment2.R` (or `.Rmd` if you prefer) but you can add any prefixes to the filename that work with your file naming scheme. **Push to GitHub**. 

I suggest you follow the [class coding style](skills_tutorials/ebio5460_r_style_guide.md) but if you have a strong style preference from long experience I won't mind.

For these problems, only use the basic selection and repetition structures covered in class and the basic arithmetic operators ( `+` `-` `/` `*`, including modulus `%%` and integer division `%/%`). Do not use any R functions other than `print()`.

Get help or ask questions on [our Piazza forum]( https://piazza.com/colorado/fall2022/ebio5460002/home)!

## Repetition structures

```R
# Sentinel control
while ( condition ) {
    expression
}

# Counter control
for ( i in 1:n ) {
    expression
}

# Vector control
for ( element in vector ) {
    expression
}
```

### Question 1

What is wrong with the following code? (Provide your answer as a comment). Fix the code.

```R
number <- 100
while ( number <= 100 ) {
    print(number)
    number <- number - 1
}
```

### Question 2

In class we came up with the following code for an algorithm to find a number (y) that is the zth power of x for any integer z greater than zero. It uses a **for** structure to do counter controlled repetition.

```R
# Finds the number (y) that is the zth power of x

# Initialize parameters
x <- 3.2    #Any real number
z <- 2      #Any integer > 0

# Initialize working variables
y <- 1

# Processing phase
for ( counter in 1:z ) {
    y <- y * x
}

# Termination phase
y
```

Does it work correctly for integer z = 0 (try it out)? If not, fix it so integer z = 0 will work correctly with a **for** structure. 

Hints: 

* One possible solution would be to use a selection structure.
* What do each of the following lines of code return?

```R
1:10
```

```R
1:3
```

```R
1:1
```

```R
1:0
```

### Question 3

Print all the numbers less than 1000 in the Fibonacci sequence. The first two numbers in the Fibonacci sequence are 0 and 1, and each subsequent number is the sum of the previous two.

### Question 4

Calculate the factorial of a number (non-negative integer). For example 5 factorial, denoted 5!, is equal to 5 x 4 x 3 x 2 x 1, while 0! is defined to be equal to 1. Hint: start with a specific case (e.g. 5!) then generalize your algorithm.

### Question 5

Now modify your code in the previous example to calculate and print the factorial for all the integers from 0 to n.

### Question 6

The following code loads a list object named `dna_sequences` from the RData file `dna_sequences.RData` (you can find the data file in the [`data` folder](/data) in the class-materials repository). Find and print the position of the 10th occurrence of a cytosine base in each sequence (e.g. in ATGTTACTTGCGA the position of the 1st occurrence of a cytosine base is 7) . You may use the function `length()` to find the length of a sequence.

```R
load(file="dna_sequences.RData")
class(dna_sequences)  #the class is list
str(dna_sequences)    #examine the structure of the list
dna_sequences         #print the full list
```
