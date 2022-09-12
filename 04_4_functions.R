# Structured programming: functions
# Also illustrated here is the concept of scope.
# Brett Melbourne
# 25 Oct 17

# Here is an example showing the syntax of a function

#----diff_two_nums------------------------
# Computes the difference of x and z as x - z
#
# Arguments
# x: any real number
# z: any real number
#
# Return
# y: a real number
#
diff_two_nums <- function(x, z) {
    y <- x - z
    return(y)
}

# A function is an object and you can print it
diff_two_nums

# Use the function with explicit arguments (order doesn't matter)
diff_two_nums(x=3, z=2)
diff_two_nums(z=2, x=3) #same result as previous line

# Use the function with implicit arguments (order matters)
diff_two_nums(3, 2)
diff_two_nums(2, 3) #not the same result


# Assign the result of the function to an object
a <- diff_two_nums(2, 4)
a


# These alternatives also work but I recommend using the above because it is
# easier to debug

diff_two_nums <- function(x, z) {
    return(x - z)
}

diff_two_nums <- function(x, z) {
    x - z
}

diff_two_nums <- function(x, z) x - z



# Scope concept 1: objects defined inside the function are "local" to the
# function. They can only be seen inside the function. Here, x, z and y are
# local because x and z are listed in the arguments, and y is defined in the 
# body of the function.

diff_two_nums <- function(x, z) {
    y <- x - z
    return(y)
}

# To demonstrate local variables, first define x, z and y outside the function.
# These variables have the same names as those inside the function but they are
# different objects. Their scope is outside of the function.

x <- 3
z <- 2

# Now use the function
diff_two_nums(x, z)

# Of course, this has the expected behavior but something subtle is going on. We
# have actually said: "use the x object from outside the function as the first
# argument and the z object from outside the function as the second argument".

# More explicitly we could write:
diff_two_nums(x=x, z=z)

# This shows more clearly what is going on. It says "assign the object x within
# the function the value x outside the function and the value z within the
# function the value z outside the function". The objects within the function
# are local to the function.

# We can also appreciate how this scoping rule works if we reverse the order of
# the numbers so that the x inside the function is assigned the value of the z
# outside the function (and vice versa).
diff_two_nums(x=z, z=x)
diff_two_nums(z, x) #same is previous line except implicit arguments


# Scope concept 2: global variables.
# Objects outside the function that are not listed in the arguments or defined
# in the function can be seen inside the function. These are called global
# variables, the opposite of local variables.

# Here, z is a global variable, whereas x and v are local. z is global because
# it is not defined (assigned to the object z) within the function. The value
# for z is taken from the next environment outside the function, which here is
# the global environment of the script.

global_test <- function(x) {
    y <- x + z   #z is global
    return(y)
}

z <- 2   
global_test(1)  #x + z = 1 + z
global_test(2)  #x + z = 2 + z



# Scope concept 3: objects outside the function can't be modified by the 
# function.

# Here, z outside the function can't be modified by the z inside the function.
# In this example we have set up a function that calculates a new value for z
# inside the function that is calculated from the value of the global variable z
# outside the function. The z outside the function isn't changed.

no_modify_test <- function(x) {
    z <- z + 1    #The z left of <- is local but z right of <- is global.
    y <- x + z    #This z is local. This y is local.
    return(y)
}

z <- 11           #Initialize z outside the function to 11.
y <- 100
no_modify_test(3)
z                 #z outside the function is still 11 - it was not
                  #changed by the function.
y                 #y outside the function is not modified either
