#!nb # @def title = "Rigorous computation of function range"

# # Rigorous Computation of function range

#!nb # \toc

#!nb # Download the interactive notebook from [here](/notebooks/funcRange.ipynb)

# ## Introduction

# The range of a function $f$ is defined as the set $f(X) = {f(x) | x\in X}$, where $X$ is the domain of the function.
# This tutorial will show how to to exploit interval arithmetic to give a rigorous estimate of the function range.

# First, let's import all the packages we need
using IntervalArithmetic, Plots

# ## A first example

# To begin with, let us compute the range of the function $f(x)=x^2+2x$ over the interval $X=[-5, 5]$.

f(x) = x^2+2x
X = -5..5

@show range_1_interval = f(X)

plot(f, -5, 5, leg=false)
plot!(IntervalBox(X, f(X)))
#!nb savefig(joinpath(@OUTPUT, "range1.svg")) # hide

#!nb # \fig{range1}

# As can be noticed, in this case we overestimate the range of the function. This is a common issue in interval
# arithmetic and it is known as *dependency problem*. If a variable is present more than once in the expression,
# then evaluating the function over an interval will produce  larger interval.
# For this simple function, the problem can be solved with simple algebraic manipulation observing that
# $$
# x^2+2x=x^2+2x+1-1=(x+1)^2-1
# $$

# The variable $x$ is now present only once and no overestimation occurs, as the following code confirms
f1(x) = (x+1)^2-1
@show range_f = f1(X)

plot(f1, -5, 5, leg=false)
plot!(IntervalBox(X, f1(X)))
#!nb savefig(joinpath(@OUTPUT, "range2.svg")) # hide
#!nb #  \fig{range2}

# Despite for this simple example we could analytically solve the dependency problem, this is not possible in general.
# The strategy to reduce overestimation is *divide and conquer*. The domain is divided into smaller intervals and the function is evaluated
# at each interval. The process of partitioning the interval into smaller piecing is called "mincing" and `IntervalArithmetic` offers the function
# `mince(X, N)` to partition the interval $X$ into $N$ intervals. This function returns an array of intervals. For example using 10 intervals

Xs = mince(X, 10)
Y = f.(Xs)
plot(f, -5, 5, leg=false)
plot!(IntervalBox.(Xs, f.(Xs)))
#!nb savefig(joinpath(@OUTPUT, "range3.svg")) # hide

#!nb # \fig{range3}

# Assuming the function $f$ is continuous, we can now compute the function range by taking the union of the computed intervals. This can be done using the function `reduce`
range_10_intervals = reduce(∪, Y)
overestimate_1_interval = (diam(range_1_interval)-diam(range_f))/diam(range_f)
overestimate_10_intervals = (diam(range_10_intervals)-diam(range_f))/diam(range_f)
@show overestimate_1_interval, overestimate_10_intervals

anim = @animate for i=1:50
    Xs = mince(X, i)
    plot(f, -5, 5, leg=false)
    plot!(IntervalBox.(Xs, f.(Xs)))
end
#!nb gif(anim, joinpath(@OUTPUT, "anim_range1.gif"), fps = 10)
#!nb nothing
#nb gif(anim, "range1.gif", fps=10)

#!nb # \fig{anim_range1.gif}

# As can be seen, the more intervals we use, the closer the range estimate will get to the actual range.
# We are now ready to write our function `range(f, X, tol)` which estimates the range of a function $f$ over an interval $X$.
# The function will take a third parameter an error tollerance `tol` and keep increasing the number of intervals until the relative change will become smaller than `tol`.
# Denoting by $Y_i$ the range estimate using $i$ intervals, the relative change can be computed as $\frac{Y_{i-1}-Y_{i}}{Y_{i-1}}$.

function range(f, X, N, tol=0.01)

    Xs = mince(X, N)
    Ynext = f.(Xs)
    Ynext = reduce(∪, Ynext)
    err = tol+1

    while err > tol
        Yprev = Ynext
        N *= 2
        Xs = mince(X, N)
        Ynext = f.(Xs)
        Ynext = reduce(∪, Ynext)
        err = (diam(Yprev) - diam(Ynext))/diam(Yprev)
    end

    return (Ynext, N, err)
end

# Now we are ready to compute the range of our function

Y, N, err = range(f, X, 3)
@show (Y, N, err)
plot(f, -5, 5, legend=false)
plot!(IntervalBox(X, Y))
#!nb savefig(joinpath(@OUTPUT, "range4.svg")) # hide

#!nb # \fig{range4}

# ## A more challenging example (1D)

# Now that we have developed our tool to estimate a function range, we are ready to test it with more challenging functions.
# Let's estimate the range of the function $g(x) = -\sum_{k=1}^5kx\sin\left(\frac{k(x-3)}{3}\right)$ over the interval $X=[-10,10]$.

X = -10..10

g(x) = -sum([k*x*sin(k*(x-3)/3) for k in 1:5])

Y, N, err = range(g, X, 3)
@show (Y, N, err)
plot(g, -10, 10, legend=false)
plot!(IntervalBox(X, Y))
#!nb savefig(joinpath(@OUTPUT, "range5.svg")) # hide

#!nb # \fig{range5}

anim = @animate for i in 2 .^(0:10)
    Xs = mince(X, i)
    plot(g, -10, 10, leg=false)
    plot!(IntervalBox.(Xs, g.(Xs)))
end
#!nb gif(anim, joinpath(@OUTPUT, "anim_range2.gif"), fps = 2) # hide
#!nb nothing # hide
#nb gif(anim, joinpath(@OUTPUT, "anim_range2.gif"), fps = 2)

#!nb # \fig{anim_range.gif}
