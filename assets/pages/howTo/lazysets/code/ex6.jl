# This file was generated, do not modify it. # hide
Y = ConvexHullArray(convert.(Hyperrectangle,paving.boundary))
Xpoly = overapproximate(Y, 0.1)
@show length(Xpoly.constraints)

Xpoly′ = overapproximate(Y, 0.01)
@show length(Xpoly′.constraints)

plot(Xoct, lab="Octagon", alpha=.5, c=:orange, legend=:bottomright)

plot!(Xpoly, lab="Polygon, ε=0.1")
plot!(Xpoly′, lab="Polygon, ε=0.01")

plot!(paving.boundary, lab="Paving (boundary)", c=:lightblue)
plot!(paving.inner, lab="Paving (inner)", c=:yellow)

lens!([0.0, 0.3], [0.0, 0.3], inset = (1, bbox(0.25, 0.35, 0.4, 0.4)))

savefig(joinpath(@OUTPUT, "pavingPolyhedralRefined.svg")) # hide