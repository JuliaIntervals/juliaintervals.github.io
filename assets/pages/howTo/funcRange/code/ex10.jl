# This file was generated, do not modify it. # hide
anim = @animate for i in 2 .^(0:10)
    Xs = mince(X, i)
    plot(g, -10, 10, leg=false, xlims=(X.lo, X.hi), ylims=(-60, 50), lw=2)
    plot!(IntervalBox.(Xs, g.(Xs)))
end