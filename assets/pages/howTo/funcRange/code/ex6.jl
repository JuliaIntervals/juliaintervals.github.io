# This file was generated, do not modify it. # hide
anim = @animate for i in 0:10
    Xs = mince(X, 2^i)
    plot(f, -5, 5, leg=false, ylims=(-5, 40), xlims=(X.lo, X.hi), lw=2)
    plot!(IntervalBox.(Xs, f.(Xs)))
end