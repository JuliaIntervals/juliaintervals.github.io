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

f(x) = x^2 - 2x + 1

f(0..2)

minval, minimisers = minimise(f, 0..2, tol=1e-3);
@show length(minimisers)

using Plots
plot(f, 1-0.1, 1+0.1, lw=2)
plot!(IntervalBox.(minimisers, f.(minimisers)), legend=false)

savefig(joinpath(@OUTPUT, "clustering.svg")) # hide

minval, minimisers = minimise(f, 0..2, tol=1e-6);
@show length(minimisers)

using ForwardDiff

mean_value_form(f, X) = f(mid(X)) + ForwardDiff.derivative(f, X)*(X - mid(X))

minval, minimisers = minimise(X -> mean_value_form(f, X), 0..2, tol=1e-6);
@show length(minimisers)
@show minimisers

