# @def title = "Rigorous computation of function range"

# # Rigorous Computation of function range

#!nb # \toc

#!nb # Download the interactive notebook from [here](/notebooks/funcRange.ipynb)

# ## Introduction

# The range of a function $f$ is defined as the set $f(X) = \{f(x) | x\in X\}$, where $X$ is the domain of the function.
# This tutorial will show how to to exploit interval arithmetic to give a rigorous estimate of the function range.

# First, let's import all the packages we need
using IntervalArithmetic, Plots

# ## A first example
f(x) = x^2+2x
X = -5..5

plot(f, -5, 5, leg=false)
plot!(IntervalBox(X, f(X)))
#!nb savefig(joinpath(@OUTPUT, "range1.svg")) # hide

# \fig{range1}

# As can be noticed, in this case we overestimate the range of the function. This is a common issue in interval
# arithmetic and it is known as *dependency problem*. If a variable is present more than once in the expression,
# then evaluating the function on an interval will overestimate the final interval.
# For this simple function, the problem can be solved with simple algebraic manipulation observing that
# $$
# x^2+2x=x^2+2x+1-1=(x+1)^2-1
# $$

# The variable $x$ is now present only once and no overestimation occurs, as the program confirms
using Plots
f1(x) = (x+1)^2-1
plot(f1, -5, 5, leg=false)
plot!
(IntervalBox(X, f1(X)))
#!nb savefig(joinpath(@OUTPUT, "range2.svg")) # hide
range_f = f1(X)
# \fig{range2}

# Despite for this simple example we could analytically solve the dependency problem, this is not possible in general.
# The strategy to reduce overestimation in *divide and conquer*. The domain is divided into smaller intervals and the function is evaluated
# at each interval. The process of partitioning the interval into smaller piecing is called "mincing" and `IntervalArithmetic` offers the function
# `mince(X, N)` to divide the interval $X$ into $N$ pieces. This function returns an array of intervals. For example using 10 intervals

Xs = mince(X, 10)
Y = f.(Xs)
plot(f, -5, 5, leg=false)
plot!(IntervalBox.(Xs, f.(Xs)))
#!nb savefig(joinpath(@OUTPUT, "range3.svg")) # hide

range_f1 = reduce(∪, Y)
overestimate1 = round((diam(f(X))-diam(range_f))/diam(range_f)*100)
overestimate2 = round((diam(range_f1)-diam(range_f))/diam(range_f)*100)
overestimate1, overestimate2

# \fig{range3}

anim = @animate for i=1:50
    Xs = mince(X, i)
    plot(f, -5, 5, leg=false)
    plot!(IntervalBox.(Xs, f.(Xs)))
end
#!nb gif(anim, joinpath(@OUTPUT, "anim_fps15.gif"), fps = 10); # hide
nothing # hide

# \fig{anim_fps15.gif}
