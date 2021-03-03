# This file was generated, do not modify it. # hide
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