#nb # Interval arithmetic tutorial

# ## Introduction

# Interval arithmetic offers a methematical framework to performs *rigorous* computations. Computations with traditional floating point arithmetic introduce rounding error and hence
# the final result of the computation will be an approximate solution which is (hopefully!) close to the correct value. Interval arithmetic on the other side will output an interval which is * guaranteed*
# to contain the correct theoretical result of the computation. This tutorial will show you how to perform interval computations in Julia using the `IntervalArithmetic.jl` package.
# After this tutorial, you will be ready to harness the power of interval arithmetic and learn how to apply it to root finding, optimisation or differential equations. TODO: links

# ## Setup

# The `IntervalArithmetic.jl` package can be installed with

# ```julia
# using Pkg; Pkg.add("IntervalArithmetic")
# ```

using IntervalArithmetic

# ## Defining intervals

# An interval $I$ is a subset of $\R$ in the form $I=\{x\in\R|a\leq x\leq b\}$ and is denoted as
# $I=[a, b]$ and we say that $a$ and $b$ are the lower and upper bound. Note that the bounds must satisfy $a\leq b$. The IntervalArithmetic.jl package offers several ways to define an interval

# ### Dot notation

# An interval $[a,b]$, with $a\leq b$  can be easily defined with the syntax `a..b`.

a = 1..2
@show a

b = 2..1


# Note that the if the upper bound is negative, then it should be within parentheses `-5..(-2)` or adding a space before it `-5.. -2`.
# However, the expression `-5..-2` will throw a syntax error.

# ### `@interval` macro and `interval` method

# Another way to define an interval is to use the `@interval(a, b)` macro or the `interval(a, b)` method.
# If called with a single input such as `@interval(a)` or `interval(a)`, they will create the degenerated interval $[a,a]$.
# Notice that if you use the macro with only one parameter, you can replace the parentheses with an empty space

a = @interval(1,2)

b = interval(1, 2)

c = interval(1)

d = @interval 1

@show a, b, c, d


# The macro is particularly useful when you want to create an interval from a more complicated expression, as demonstrated in the example below

@interval sin(0.2)+cos(1.3)-exp(0.4)

# This is equivalent to `sin(interval(0.2))+cos(interval(1.3))-exp(interval(0.4))`.

# ### Midpoint notation

# An interval can be created also using the *midpoint notation*, i.e. $m± r$, where $m=\frac{a+b}{2}$ is the midpoint of the interval and $r=\frac{b-a}{2}$ is the radius. In julia, the symbol $\pm$ can be typed writing `\pm<TAB>`.
# This method is equivalent to `(m-r)..(m+r)`

2 ± 1

# ### Interval() constructor

# You can create an interval also using the `Interval(a, b)` constructor, or `Interval(a)` for degenerated interal. However, **this method should be avoided**, mainly for two reasons.

# First, the constructor does not perform any sanity check on the interval, meaning that absurd intervals such as $[2, 1]$ could be created. Second, this constructor does not perform correct rounding on the boundaries. Suppose we want to create the interval $[0.1, 0.1]$. The number $0.1$ cannot be represented exactly with floating-point arithmetic, i.e. when the user types $0.1$ the computer automatically approximates to the closest representable numbers. If we create the interval with any of the methods exposed above, the package will make sure to round down the lower bound and round up the upper bound, ensuring that $0.1$ will actually be included in the interval. However, if the `Interval()` constructor is used, no rounding is performed, resulting in the number not being contained in the interval.

a = 0.1

@show big(a)


I = Interval(a)

II = @interval 0.1

correct = big"0.1"
@show correct

@show correct ∈ I
@show correct ∈ II


# The function `big(a)` reveals that the float $a$ is actually slightly bigger than $0.1$. Since `Interval(0.1)` does not perform any proper rounding, the interval will be above $0.1$. The best possible approximation of the number can be obtained using arbitrary-precision arithmetic insead of floating-point, this is achieved with `big"0.1"` (Note that we give `"0.1"` as a string). It can now be observed that this number is not included in `Interval(0.1)`. However, creating the interval with `@interval 0.1` performs direct rounding (lower bound rounded down and upper bound rounded up), obtaining an interval that does indeed contain the wanted number.

# The `Interval()` constructor is used in the internals of the package and it is called only after rounding and sanity checks have been done. For efficiency reasons, the constructor does not perform any more checks. The user should **not** use this constructor directly, but prefer any of the above exposed methods.

# ## Operations on intervals

# In general, a binary operation $\circ$ between two intervals $X$ and $Y$ is defined as

# $$X\circ Y = [\{x\circ y: x\in X, y\in Y\}]$$

# where the brackets $[A]$ denote the interval closure, i.e. the smallest interval containing the set $A$, for example if $A=[1,2]\cup[3,4]$ then $[A]=[1,4]$.
# Bearing this definition in mind, traditional arithmetic and set operations can be defined for intervals. These operations are already implemented in IntervalArihtmetic.jl and can be used with the traditional operators `+, -, *, /, ∩, ∪`.
# If you want to know how these are computed under the hood, check our interval functions grimoire! (TODO: add link)
# A few examples:

X = 1..2
Y = 3..4

@show X ∩ Y # typed \cap<TAB
@show X ∪ Y # TYPED \cup<TAB>
@show X + Y
@show X*Y
@show X^3
@show X/Y


# Note that the operation $X/Y$ is finite only if $0∉ Y$, otherwise the resulting interval will be unbounded

X = 1..2

Y = -1..1

Z = 0..2

@show X/Y

@show X/Z

# It is good to notice that some standard properties of arithmetic operations do not hold in interval arithmetic, observe the following examples

X-X

X/X

Z*(X+Y)

Z*X+Z*Y

# Hence in interval arithmetic $ X-X\neq0 $ and $ X/X\neq1 $. The last two operations tell us that $X(Y+Z)\subseteq XY+XZ$, which is called *subdistributive properties*.

# ## Functions over intervals

# Similarly to binary operations, the functions $f$ over an interval $X$ is defined as

# $$f(X) = [\{f(x): x\in X\}]$$

# Elementary functions have already been implemented in JuliaIntervals are are ready-to-go. If you are curious to see how they are computed under the hood, check our interval functions grimoire.


@show sin(0..2/3*π)


@show  log(-3.. -2)

@show log(-3..2)

@show  √(-3..4)

# ### A note on functions: overestimation

# Suppose we want to evaluate the function $f(x) = x^2+3x-1$ over the interval $X=[-2,2]$.

f(x) = x^2+3x-1

X = -2..2

@show f(X)

# According to this, $f(X) = [-7,9]$. However, it can be verified that the real range of the function over $X$ is $[-3.25, 9] \subset [-7, 9]$. In this case we *overestimate* the range of the function.

# The reason for this overestimation is known as *dependence problem*. If in a function $f$ the same variable appears multiple times, then the interval evaluation of the function may lead to overestimation. A simple solution to overcome this problem would be to divide the interval in smaller disjoint intervals, evaluate the function on each interval and compute the union of the resulting intervals. For example, since $[-2,2]=[-2,-1.5]\cup [-1.5, 2]$ we obtain

@show f(-2.. -1.5) ∪ f(-1.5.. 2)

# As can be noticed, the overestimate is now reduced. [Here](/pages/howTo/funcRange/) you will find a more detailed discussion on how to estimate the range of a function and deal with function overestimates.
