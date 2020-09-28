#nb # Interval constraint programming optimisation

# ## Setup

# The `IntervalOptimisation.jl` package can be installed with

# ```julia
# using Pkg; Pkg.add("IntervalConstraintProgramming")
# ```

# Once the package is installed, it can be imported. Note that you will need also the `IntervalArithmetic.jl` package.

using IntervalArithmetic, IntervalConstraintProgramming

# ## Introduction

# This Julia package allows you to specify a set of constraints on real-valued variables, given by (in)equalities, and rigorously calculate inner and outer approximations to the feasible set, i.e. the set that satisfies the constraints.

# This uses interval arithmetic provided by the `IntervalArithmetic.jl` package, in particular multi-dimensional IntervalBoxes, i.e. Cartesian products of one-dimensional intervals.

# ## Basic usage

# The simple way to define a constraint is to use the `@constraint` macro, as the following example demonstrates

S = @constraint x^2 + y^2 <= 1

# As it can be noticed, the macro itself can figure out that $x$ and $y$ are variables and you do not need to define those separately. The output of the macro is an object of type `Separator`.
# This is a function which, when applied to the box $X = x \times y$ in the $xy$-plane, applies two contractors, an inner one and an outer one.
# The inner contractor tries to shrink down, or contract, the box, to the smallest subbox of X that contains the part of X that satisfies the constraint; the outer contractor tries to contract X to the smallest subbox that contains the region where the constraint is not satisfied.
# When S is applied to the box X, it returns the result of the inner and outer contractors:

X = IntervalBox(-100..100, 2)

inner, outer = S(X)

@show inner

@show outer

# ## First application: set inversion

# Given a function $f:\R^m\rightarrow\R^n$ and a set $Y\subset\R^n$, set inversion means to find the set $X=f^{1}(Y)=\{x\in\R^m|f(x)\in Y\}$, which is refered as *feasible set*. Generally, the
# image set Y can be represented as a set of constraints on the expression $f(X)$ and solving the set inversion problem means to find the points in $X$ for
# which these constraints are satisfied. As we show in this example, set inversion can be solved using interval constraint programming.
# Let's consider the function $f(x, y) = x^2+y^2$ and let's find the set $X$ for which $f(X)\in[1, 3]$, i.e. we must find the points $(x, y)$ for which $1\leq x^2+y^2\leq 3$.
# Let's define this constraint
S = @constraint 1 <= x^2+y^2 <= 3


# The strategy to solve this problem is the following, we start with a large interval box, which we know will contain the feasible sets and we iteratively divide the box in smaller boxes,
# keeping track of which boxes are guaranteed to be inside the feasible sets, the boxes that are outside and the boxes that are on the boundary.
# `IntervalConstraintProgramming` offers the function `pave`, to do so, the signature of this function is
# ```
# pave(S, X, tol)
# ```
# where $S$ is our Separator, $X$ is our starting box and $tol$ is a tollerance parameter. This function returns an object of type `SubPaving`, which stores  a list of boxes guaranteed
# to be into the feasible set in the attribute `inner`, as well as a list of boxes on the boundary in the attribute `boundary`.

X = IntervalBox(-100..100, 2) # our starting box
paving = pave(S, X, 0.125)

# As we can see, the function found in total 164 boxes inside the feasible set and 164 boxes at the boundary. We can now visualize how well
# paving approximates the feasible set

using Plots
plot(paving.inner, c="green", aspect_ratio=:equal, label="inner")
plot!(paving.boundary, c="gray", label="boundary")

#!nb savefig(joinpath(@OUTPUT, "paving.svg")) # hide

#!nb # \fig{paving}

# The smallest the tolerance parameter, the better the approximation of the feasible set will be, as the following animation shows


tollerances =  append!(collect(1:-0.1:0.1), collect(0.09:-0.01:0.01))
anim = @animate for tol in tollerances
    paving = pave(S, X, tol)
    plot(paving.inner, c="green", legend=false, title="tol=$tol", aspect_ratio=:equal)
    plot!(paving.boundary, c="gray")
end
#!nb gif(anim, joinpath(@OUTPUT, "paving_gif.gif"), fps = 2) # hide
#!nb nothing # hide

#!nb # \fig{paving_gif}
