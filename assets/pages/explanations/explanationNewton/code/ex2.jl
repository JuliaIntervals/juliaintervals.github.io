# This file was generated, do not modify it. # hide
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

@show xk, yk