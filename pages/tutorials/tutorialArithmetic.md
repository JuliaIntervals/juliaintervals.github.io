@def title = "Tutorial Interval Arithmetic"

# IntervalArithmetic.jl tutorial

\toc

## Setup

To install the `IntervalArithmetic.jl` package run 

```julia-repl
julia> using Pkg; Pkg.add("IntervalArithmetic")
```

The package is now ready to use and it can be imported typing

```julia-repl 
julia> using IntervalArithmetic
```

## Defining intervals

### Dot notation
An interval $[a,b]$, with $a\leq b$  can be easily defined with the syntax `a..b`.

```julia-repl
julia> 1..2
[1,2]

julia> 2..1
ERROR: ArgumentError: `[2.0, 1.0]` is not a valid interval. Need `a ≤ b` to construct `interval(a, b)`.

```

Note that the if the upper bound is negative, then it should be within parentheses `-5..(-2)` or adding a space before it `-5.. -2`. However, the expression `-5..-2` will throw a syntax error.


### `@interval` macro and `interval` method

Another way to define an interval is to use the `@interval(a, b)` macro or the `interval(a, b)` method.
If called with a single input such as `@interval(a)` or `interval(a)`, they will create the degenerated interval $[a,a]$.
Notice that if you use the macro with only one parameter, you can replace the parentheses with an empty space

```julia-repl
julia> @interval(1,2)
[1, 2]

julia> interval(2, 3)
[2, 3]

julia> interval(1)
[1, 1]

julia> @interval 1
[1, 1]

```

The macro can also be used to parse interval from strings as follows (Note that `@interval "1..2"` does not work yet).
```julia-repl
julia> @interval "1"
[1, 1]

julia> @interval "[1,2]"
[1, 2]

```

The macro is particularly useful when you want to create an interval from a more complicated expression, as demonstrated in the example below

```julia-repl
julia> @interval sin(0.2)+cos(1.3)-exp(0.4)
[-1.02566, -1.02565]

```

This is equivalent to `sin(interval(0.2))+cos(interval(1.3))-exp(interval(0.4))`.

### Midpoint notation

An interval can be created also using the *midpoint notation*, i.e. $m± r$, where $m=\frac{a+b}{2}$ is the midpoint of the interval and $r=\frac{b-a}{2}$ is the radius. In julia, the symbol $\pm$ can be typed writing `\pm+TAB`.
This method is equivalent to `(m-r)..(m+r)`

```julia-repl
julia> 2 ± 1
[1, 3]

```

### Interval() constructor

You can create an interval also using the `Interval(a, b)` constructor, or `Interval(a)` for degenerated interal. However, **this method should be avoided**, mainly for two reasons.

First, the constructor does not perform any sanity check on the interval, meaning that absurd intervals such as $[2, 1]$ could be created. Second, this constructor does not perform correct rounding on the boundaries. Suppose we want to create the interval $[0.1, 0.1]$. The number $0.1$ cannot be represented exactly with floating-point arithmetic, i.e. when the user types $0.1$ the computer automatically approximates to the closest representable numbers. If we create the interval with any of the methods exposed above, the package will make sure to round down the lower bound and round up the upper bound, ensuring that $0.1$ will actually be included in the interval. However, if the `Interval()` constructor is used, no rounding is performed, resulting in the number not being contained in the interval.

```julia-repl
julia> Interval(2, 1)
[2, 1]

julia> a = 0.1
0.1

julia> big(a)
0.1000000000000000055511151231257827021181583404541015625

julia> I = Interval(a)
[0.1, 0.100001]

julia> II = @interval 0.1
[0.0999999, 0.100001]

julia> correct = big"0.1"
0.1000000000000000000000000000000000000000000000000000000000000000000000000000002

julia> correct ∈ I
false

julia> correct ∈ II
true
```

The function `big(a)` reveals that $0.1$ is actually slightly bigger than $0.1$. Since `Interval(0.1)` does not perform any proper rounding, the interval will be above $0.1$. The best possible approximation of the number can be obtained using arbitrary-precision arithmetic insead of floating-point, this is achieved with `big"0.1"` (Note that we give `"0.1"` as a string). It can now be observed that this number is not included in `Interval(0.1)`. However, creating the interval with `@interval 0.1` performs direct rounding (lower bound rounded down and upper bound rounded up), obtaining an interval that does indeed contain the wanted number.

The `Interval()` constructor is used in the internals of the package and it is called only after rounding and sanity checks have been done. For efficiency reasons, the constructor does not perform any more checks. The user should **not** use this constructor directly, but prefer any of the above exposed methods.

## Operations on intervals

In general, a binary operation $\circ$ between two intervals $X$ and $Y$ is defined as

$$X\circ Y = \{x\circ y: x\in X, y\in Y\}$$

Bearing this definition in mind, traditional arithmetic operations can be defined for intervals. These operations are already implemented in IntervalArihtmetic and can be used with the traditional operators `+, -, *, /`. A deeper discussion about how these operations are defined can be found [here](/pages/explanations/intervalAnalysisIntro/index.html).

### Arithmetic operations

Basic arithmetic operations can be performed using the arithmetic operators `+ - * /`.

```julia-repl
julia> X = 1..2
[1, 2]

julia> Y = 3..4
[3, 4]

julia> X + Y
[4, 6]

julia> X - Y
[-3, -1]

julia> X * Y
[3, 8]

julia> X / Y
[0.25, 0.666667]

```





**Notice**, theoretical the operation $X/Y$ requires $0∉ Y$. If this condition is not met, one of the extremes of the intervals (or both) will to to infinity.

```julia-repl
julia> X = 1..2
[1, 2]

julia> Y = -1..1
[-1, 1]

julia> Z = 0..2
[0, 2]

julia> X/Y
[-∞, ∞]

julia> X/Z
[0.5, ∞]

```


**Notice 2**, In interval arithmetic some of the basic properties that you were taught in elementary school do not hold, observe the following examples.

```julia-repl
julia> X-X
[-1, 1]

julia> X/X
[0.5, 2]

julia> Z*(X+Y)
[-0, 6]

julia> Z*X+Z*Y
[-2, 6]

```

Particularly, the last two rows show that the distributivity property does not hold. In general, interval arithmetic is *subdistributive*, meaning $X(Y+Z)\subseteq XY+XZ$.

### Set operations

As an interval is a set of real numbers, the classical set operations union ($∪$) and intersection ($∩$) can be applied.
In Julia, these operators can be typed by `\cup+TAB` and `\cap+TAB`, respectively. The inclusion of an interval
in another can be verified with `⊆` (typed `\subseteq+TAB`). Strict inclusion can be veried with `⊂` (typed `\subset+TAB`).
The (non-)membership of an element to an interval can be verified with ∈ (∉), typed `\in+TAB` `\notin+TAB`).

```julia-repl
julia> X = 1..2
[1, 2]

julia> Y = -1..1.5
[-1, 1.5]

julia> X ∪ Y
[-1, 2]

julia> X ∩ Y
[1, 1.5]

julia> X ⊆ Y
false

julia> X ⊆ 0..3
true

julia> X ⊂ X
false

julia> 1.5 ∈ X
true

julia> 2.5 ∈ X
false

```

## Functions over intervals

Similarly to binary operations, the functions $f$ over an interval $X$ is defined as

$$f(X) = \{f(x): x\in X\}$$

Most elementary functions are already implemented in JuliaIntervals. A comprehensive list of the implemented functions with a detailed description of their behavior can be found in our API DOCS. TODO: link

```julia-repl
julia> sin(0..2/3*π)
[0, 1]

julia> log(-3.. -2)
∅

julia> √(-3..4)
[0, 2]
```
## A note on functions: overestimation

TODO: move this to function range in applications

Suppose we want to evaluate the function $f(x) = x^2+3x-1$ over the interval $X=[-2,2]$.

```julia-repl
julia> f(x) = x^2+3x-1
f (generic function with 1 method)

julia> X = -2..2
[-2, 2]

julia> f(X)
[-7, 9]
``` 
According to this, $f(X) = [-7,9]$. However, it can be verified that the real range of the function over $X$ is $[-3.25, 9] \subset [-7, 9]$. In this case we *overestimate* the range of the function.

The reason for this overestimation is known as *dependence problem*. If in a function $f$ the same variable appears multiple times, then the interval evaluation of the function may lead to overestimation. A simple solution to overcome this problem would be to divide the interval in smaller disjoint intervals, evaluate the function on each interval and compute the union of the resulting intervals. For example, since $[-2,2]=[-2,-1.5]\cup [-1.5, 2]$ we obtain

```julia-repl
julia> f(-2.. -1.5) ∪ f(-1.5.. 2)
[-5.5, 9]
```

As can be noticed, the overestimate is now reduced. [Here](/pages/howTo/funcRange/) you will find a more detailed discussion on how to estimate the range of a function.

## Multidimensional intervals

Similarly to 