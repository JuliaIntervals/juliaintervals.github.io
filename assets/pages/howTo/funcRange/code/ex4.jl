# This file was generated, do not modify it. # hide
Xs = mince(X, 10)
Y = f.(Xs)
plot(f, -5, 5, leg=false)
plot!(IntervalBox.(Xs, f.(Xs)))
savefig(joinpath(@OUTPUT, "range3.svg")) # hide
nothing # hide