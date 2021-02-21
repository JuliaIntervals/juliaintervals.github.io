# This file was generated, do not modify it. # hide
function newton_iteration(f, df, X)
    m = @interval mid(X)
    return (m - f(m)/df(X)) ∩ X
end

xk = X
df(x) = d(f, x)
anim = @animate for i in 1:4
    zerobox = IntervalBox(xk, f(X))
    plot(zerobox)
    plot!(f, -1, 1, c=:red, xlims=(-1,1), legend=nothing)
    global xk = newton_iteration(f, df, xk)
    @show xk
end

gif(anim, joinpath(@OUTPUT, "interval_newton.gif"), fps = 0.8) # hide
nothing # hide