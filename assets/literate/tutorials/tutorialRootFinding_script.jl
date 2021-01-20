# This file was generated, do not modify it.

using IntervalArithmetic, IntervalRootFinding

f(x) = x^2-2x
X = -4..4

rts = roots(f, X) # using newton method

roots(f, X, Bisection)

roots(log, x->1/x, -2..2)

using BenchmarkTools
@btime roots(log, x->1/x, -2..2)

@btime roots(log, -2..2)

using StaticArrays
g( (x, y) ) = SVector(sin(x), cos(y))
X = IntervalBox(-3..3, 2)

rts = roots(g, X)

function dg( (x, y) )
    return SMatrix{2, 2}(cos(x), 0, 0, -sin(y))
end

@btime roots(g, dg, X)
@btime roots(g, X)
nothing # hide

h(x) = cos(x) * sin(1 / x)

@btime roots(h, 0.05..1)

@btime roots(h, 0.05..1, Newton, 1e-2)

@btime roots(h, 0.05..1, Newton, 1e-1)

