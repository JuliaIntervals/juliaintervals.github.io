# This file was generated, do not modify it. # hide
using StaticArrays
g( (x, y) ) = SVector(sin(x), cos(y))
X = IntervalBox(-3..3, 2)

rts = roots(g, X)