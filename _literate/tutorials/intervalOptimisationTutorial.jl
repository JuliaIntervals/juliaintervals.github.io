# # Interval Optimisation Tutorial

#!nb # \toc

#!nb # Download the interactive notebook of this tutorial [here](/notebooks/IntervalOptimisationTutorial.ipynb)

# ## Setup

# The `IntervalOptimisation.jl` package can be installed with

# ```julia
# using Pkg; Pkg.add("IntervalOptimisation")
# ```

# Once the package is installed, it can be imported. Note that you will need also the `IntervalArithmetic.jl` package.

using IntervalArithmetic, IntervalOptimisation

# ## Function minimisation

# The package two main functions are `minimise` and `maximise`. Here we will use `minimise` as example, however `maximise` behaves in an analog way.
# The main syntax is
# ```julia
# minimise(f, X, tol=1e-3),
# ```

# where $f:\R^n↦\R$ is the function to minimize, $X$ is the interval, or interval box, over which we minimize the function.
# For example, let's consider the function $f(x)=(x-3)^2$ and let us find its global minimum over its whole domain

minimise(x->(x-3)^2, -∞..∞)

# The first value of the results tells us that the minimum value of the function is in the interval $[0, 7.39292e-09]$. The second value tells us that
# this minimum is achieved in the interval $[2.99964, 3.00019]$. If we want to narrow down this interval, we can use a smaller tollerance

minVal, xmin = minimise(x->(x-3)^2, -∞..∞, tol=1e-9)
xmin, [diam(x) for x in xmin]

# Now the diameter of the minimiser is only $10^{-10}$ and the minimum is guaranteed to be in that interval.

# ## Multivariate function minimisation

# The package can also be used to minimise multivariate functions. Now, the function $f$ will take an array, and $X$ will be an interval box of dimension $n$.
# As an example, let us find the minimum of the paraboloid $z=(x-3)^2+(y-3)^2$ over the box $[-100, 100]×[-100, 100]$. First let's define the function

paraboloid(x) = (x[1]-3)^2 + (x[2]-3)^2

# and our interval box
X = IntervalBox(-100..100, 2)

# now we can obtain the minimum

zmin, xmin = minimise(paraboloid, X, tol=1e-10)

# the position of the minimum has been found with an accuracy of

[diam(x) for x in xmin]

# ### Griewank function minimisation

# The $n$-dimensional Griewank function is defined as
# $$ G_n(\mathbf{x})=1+\frac{1}{4000}\sum_{i=1}^n x_i^2 -∏_{i=1}^n \cos\left(\frac{x_i}{\sqrt{i}}\right),$$

# for example the 1-dimensional Griewank function is

# $$ G_1(x) = 1+\frac{x^2}{4000}-\cos(x) $$.

# and it is commonly used to test optimisation algorithms. This function has the property to have several regularly distributed local minima, but only one global minimum at the origin. Let's define our function

G(X) = 1 + sum(abs2, X) / 4000 - prod( cos(X[i] / √i) for i in 1:length(X) )

# Now let's verify our package finds the minima in several dimensions

for N in (1,2, 10, 20, 50)
    res, xmin = minimise(G, IntervalBox(-600..600, N))
    @show N, res, diam(xmin[1])
end
