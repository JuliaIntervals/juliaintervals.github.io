# This file was generated, do not modify it.

using IntervalArithmetic, IntervalConstraintProgramming, LazySets, Plots

S = @constraint x^2+y^2 + 3*sin(x) + 5*sin(y) <= 1.0

X = IntervalBox(-10..10, 2) # our starting box
paving = pave(S, X, 0.02)

Xoct = overapproximate(paving, OctDirections(2))

plot(Xoct, lab="Octagon", alpha=.5, c=:orange)
plot!(paving.inner, c="green", aspect_ratio=:equal, label="inner")
plot!(paving.boundary, c="gray", label="boundary")

savefig(joinpath(@OUTPUT, "pavingPolyhedral.svg")) # hide

Y = ConvexHullArray(convert.(Hyperrectangle, paving.boundary))

Xpoly = overapproximate(Y, 0.1)
Xpoly′ = overapproximate(Y, 0.01)

plot(Xoct, lab="Octagon", alpha=.5, c=:orange, legend=:bottomright)

plot!(Xpoly, lab="Polygon, ε=0.1")
plot!(Xpoly′, lab="Polygon, ε=0.01", alpha=1.)

plot!(paving.boundary, lab="Paving (boundary)", c=:lightblue)
plot!(paving.inner, lab="Paving (inner)", c=:yellow)

lens!([0.0, 0.3], [0.0, 0.3], inset = (1, bbox(0.25, 0.35, 0.4, 0.4)))

savefig(joinpath(@OUTPUT, "pavingPolyhedralRefined.svg")) # hide

length(paving.inner) + length(paving.boundary)

length(Xoct.constraints)

length(Xpoly.constraints)

length(Xpoly′.constraints)

