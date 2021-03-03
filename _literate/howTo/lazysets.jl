#nb # Polyhedral approximations with LazySets

# In the [IntervalConstraintProgramming](/pages/tutorials/tutorialConstraintProgramming)
# tutorial we saw how to solve the *set inversion* problem, i.e. how to find the region in
# $\mathbb{R}^n$ that satisfies a set of constraints.

# Interval constraint programming uses interval boxes. However, if the region we want to approximate
# is not box-shaped, it will require a large number of boxes to be represented accurately.
# To operate with those regions, it is practical to simplify such union of boxes with another set representation,
# hopefully without information loss, i.e. minimizing the *overapproximation error*.

# The package \elink{LazySets.jl}{https://github.com/JuliaReach/LazySets.jl/} can be used to approximate regions
# returned by `IntervalConstraintProgramming.jl` using general set types such as
# \elink{polyhedra}{https://en.wikipedia.org/wiki/Polyhedron}, that is, finite intersections of half-spaces.
# More generally, unions of polyhedra can be used if the region is not convex.

# First let us import the packages we need

using IntervalArithmetic, IntervalConstraintProgramming, LazySets, Plots

# The overapproximation of a paving using a polyhedron in constraint representation
# (\elink{HPolyhedron}{https://juliareach.github.io/LazySets.jl/dev/lib/sets/HPolyhedron/}) with constraints in
# the given directions `dirs` can be computed with the `overapproximate(::Paving, dirs::AbstractDirections)`
# function as illustrated below.

S = @constraint x^2+y^2 + 3*sin(x) + 5*sin(y) <= 1.0

X = IntervalBox(-10..10, 2) # our starting box
paving = pave(S, X, 0.02)

# We will choose octagon directions, meaning that the directions normal to the
# overapproximating a polyhedron are parallel to those of an octagon (not restricted to two dimensions):
Xoct = overapproximate(paving, OctDirections(2))

plot(Xoct, lab="Octagon", alpha=.5, c=:orange)
plot!(paving.inner, c="green", aspect_ratio=:equal, label="inner")
plot!(paving.boundary, c="gray", label="boundary")

#!nb savefig(joinpath(@OUTPUT, "pavingPolyhedral.svg")) # hide
#!nb # \fig{pavingPolyhedral}

# The function `overapproximate` considers the union of the elements in the boundary of the paving
# and then computes the support function of the such union along each chosen direction,
# obtaining the corresponding polyhedron in constraint form.
# In this example we have picked octagonal directions, but specifying other sets of directions is also possible
# (see [the documentation](https://juliareach.github.io/LazySets.jl/dev/lib/approximations/#Template-directions) for details).

# When no directions are known a priori, we can also let the algorithm choose the directions by an iterative refinement
# process of the given tolerance $\varepsilon$ (this method only works in two dimensions). 
# First we construct $Y$, the (lazy) convex hull of the paving's boundary, then we overapproximate it using polygons:

Y = ConvexHullArray(convert.(Hyperrectangle, paving.boundary))

Xpoly = overapproximate(Y, 0.1)
Xpoly′ = overapproximate(Y, 0.01)

plot(Xoct, lab="Octagon", alpha=.5, c=:orange, legend=:bottomright)

plot!(Xpoly, lab="Polygon, ε=0.1")
plot!(Xpoly′, lab="Polygon, ε=0.01")

plot!(paving.boundary, lab="Paving (boundary)", c=:lightblue)
plot!(paving.inner, lab="Paving (inner)", c=:yellow)

lens!([0.0, 0.3], [0.0, 0.3], inset = (1, bbox(0.25, 0.35, 0.4, 0.4)))

#!nb savefig(joinpath(@OUTPUT, "pavingPolyhedralRefined.svg")) # hide
#!nb # \fig{pavingPolyhedralRefined}

# To conclude, we note that in all cases considered the number of initial boxes is much larger than the
# complexity of the approximation if we measure it in terms of the number of constraints:

length(paving.inner) + length(paving.boundary)

#-
length(Xoct.constraints)
#-
length(Xpoly.constraints)
#-
length(Xpoly′.constraints)

