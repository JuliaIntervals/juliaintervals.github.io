# This file was generated, do not modify it. # hide
Xoct = overapproximate(paving, OctDirections(2))

plot(Xoct, lab="Octagon", alpha=.5, c=:orange)
plot!(paving.inner, c="green", aspect_ratio=:equal, label="inner")
plot!(paving.boundary, c="gray", label="boundary")