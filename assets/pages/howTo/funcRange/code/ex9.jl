# This file was generated, do not modify it. # hide
X = -10..10

g(x) = -sum([k*x*sin(k*(x-3)/3) for k in 1:5])

Y, N, err = range(g, X, 3)
@show (Y, N, err)
plot(g, -10, 10, legend=false)
plot!(IntervalBox(X, Y))
savefig(joinpath(@OUTPUT, "range5.svg")) # hide