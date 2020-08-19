# # Interval Root Finding Tutorial

#!nb # \toc

#!nb # Download the interactive notebook of this tutorial [here](/notebooks/intervalRootFindingTutorial.ipynb)

# ## Setup

# The `IntervalOptimisation.jl` package can be installed with

# ```julia
# using Pkg; Pkg.add("IntervalOptimisation");
# ```

# Once the package is installed, it can be imported. Note that you will need also the `IntervalArithmetic.jl` package.

using IntervalArithmetic, IntervalRootFinding
