# This file was generated, do not modify it.

using IntervalArithmetic, IntervalOptimisation

minimise(x->(x-3)^2, -∞..∞)

minVal, xmin = minimise(x->(x-3)^2, -∞..∞, tol=1e-9)
xmin, [diam(x) for x in xmin]

paraboloid(x) = (x[1]-3)^2 + (x[2]-3)^2

X = IntervalBox(-100..100, 2)

zmin, xmin = minimise(paraboloid, X, tol=1e-10)

[diam(x) for x in xmin]

G(X) = 1 + sum(abs2, X) / 4000 - prod( cos(X[i] / √i) for i in 1:length(X) )

for N in (1,2, 10, 20, 50)
    res, xmin = minimise(G, IntervalBox(-600..600, N))
    @show N, res, diam(xmin[1])
end

