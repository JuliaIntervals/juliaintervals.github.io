# This file was generated, do not modify it.

using IntervalArithmetic, Plots

f(x) = x^2+2x
X = -5..5

@show range_1_interval = f(X)

plot(f, -5, 5, leg=false)
plot!(IntervalBox(X, f(X)))
savefig(joinpath(@OUTPUT, "range1.svg")) #hide

f1(x) = (x+1)^2-1
@show range_f = f1(X)

plot(f1, -5, 5, leg=false)
plot!(IntervalBox(X, f1(X)))
savefig(joinpath(@OUTPUT, "range2.svg")) #hide

Xs = mince(X, 10)
Y = f.(Xs)
plot(f, -5, 5, leg=false)
plot!(IntervalBox.(Xs, f.(Xs)))
savefig(joinpath(@OUTPUT, "range3.svg")) #hide
nothing #hide

range_10_intervals = reduce(∪, Y)
overestimate_1_interval = (diam(range_1_interval)-diam(range_f))/diam(range_f)
overestimate_10_intervals = (diam(range_10_intervals)-diam(range_f))/diam(range_f)
@show overestimate_1_interval, overestimate_10_intervals

anim = @animate for i in 0:10
    Xs = mince(X, 2^i)
    plot(f, -5, 5, leg=false, ylims=(-5, 40), xlims=(X.lo, X.hi), lw=2)
    plot!(IntervalBox.(Xs, f.(Xs)))
end
gif(anim, joinpath(@OUTPUT, "anim_range1.gif"), fps = 2) #hide
nothing #hide

function range(f, X, N, tol=0.01)

    Xs = mince(X, N)
    Ynext = f.(Xs)
    Ynext = reduce(∪, Ynext)
    err = tol+1

    while err > tol
        Yprev = Ynext
        N *= 2
        Xs = mince(X, N)
        Ynext = f.(Xs)
        Ynext = reduce(∪, Ynext)
        err = (diam(Yprev) - diam(Ynext))/diam(Yprev)
    end

    return (Ynext, N, err)
end

Y, N, err = range(f, X, 3)
@show (Y, N, err)
plot(f, -5, 5, legend=false)
plot!(IntervalBox(X, Y))
savefig(joinpath(@OUTPUT, "range4.svg")) #hide

X = -10..10

g(x) = -sum([k*x*sin(k*(x-3)/3) for k in 1:5])

Y, N, err = range(g, X, 3)
@show (Y, N, err)
plot(g, -10, 10, legend=false)
plot!(IntervalBox(X, Y))
savefig(joinpath(@OUTPUT, "range5.svg")) #hide

anim = @animate for i in 2 .^(0:10)
    Xs = mince(X, i)
    plot(g, -10, 10, leg=false, xlims=(X.lo, X.hi), ylims=(-60, 50), lw=2)
    plot!(IntervalBox.(Xs, g.(Xs)))
end
gif(anim, joinpath(@OUTPUT, "anim_range2.gif"), fps = 2) #hide
nothing #hide

