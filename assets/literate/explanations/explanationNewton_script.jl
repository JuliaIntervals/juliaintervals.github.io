# This file was generated, do not modify it.

using IntervalArithmetic, ForwardDiff, Plots

f(x) = atan(x/2)
x0 = 2.5
y0 = f(x0)
d(f, x) = ForwardDiff.derivative(f, x)

xk = 2.5
yk = f(xk)

anim = @animate for i in 1:5
    xnew = xk - yk/d(f, xk)
    ynew = f(xnew)
    scatter([xk], [0]; markersize=5, markershape=:circle, c=:black, label="\$ x_k\$")
    plot!([xk, xk], [0, yk], linestyle=:dash, color=:black, label=nothing)
    plot!([xnew, xk], [0, yk], color=:black, label=nothing)
    scatter!([xnew], [0], color=:blue, markersize=5, label="\$x_{k+1}\$")
    plot!(f, -10, 10, label="\$f(x)\$", c=:red, legend=:right, legendfont=12, xlims=(-5, 5))
    global xk, yk = xnew, ynew
end

gif(anim, joinpath(@OUTPUT, "newton.gif"), fps = 0.8) #hide
@show xk, yk

X = -1..5
N(f, X) = mid(X) - f(mid(X))/d(f, X)
X = -1..5

Nx = N(f, X)
Xnext = Nx ∩ X

x0 = mid(X)
y0 = f(x0)
offset = 5e-2
plot([X.lo, X.hi], [-offset, -offset], label="\$X\$", c=:green, lw=2)
scatter!([x0], [-offset]; markersize=5, markershape=:circle, c=:black, label=nothing)
plot!([x0, x0], [-offset, y0], linestyle=:dash, color=:black, label=nothing)

deriv = d(f, X)
for m in range(deriv.lo, deriv.hi, length=100) # plot cone
    plot!([x0-y0/m, x0], [offset, y0], color=:gray, label=nothing, alpha=0.5)
end
plot!([Nx.lo, Nx.hi], [offset, offset], label="\$N(X)\$", c=:blue, lw=2)
plot!([Xnext.lo, Xnext.hi], [0, 0], label="\$N(x) \\cap X\$", c=:black, lw=3)
plot!(f, -10, 10, label="\$f(x)\$", c=:red, legend=:right)
plot!(legend=:bottomright, legendfont=12)

savefig(joinpath(@OUTPUT, "intervalNewton.svg")) #hide

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

gif(anim, joinpath(@OUTPUT, "interval_newton.gif"), fps = 0.8) #hide
nothing #hide

