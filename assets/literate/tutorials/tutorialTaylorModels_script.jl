# This file was generated, do not modify it.

using IntervalArithmetic, TaylorModels

f(x) = x*(x-1.1)*(x+2)*(x+2.2)*(x+2.5)*(x+3)*sin(1.7*x+0.5)
a = -0.5..1
x0 = mid(a) # expansion around the middle point of the domain

tm6 = TaylorModel1(6, interval(x0), a)
tm7 = TaylorModel1(7, interval(x0), a)
@show tm6
@show tm7

ftm6 = f(tm6)
ftm7 = f(tm7)
@show ftm6
@show ftm7

using Plots
plot(range(inf(a), stop=sup(a), length=1000), f, lw=2, xaxis="x", yaxis="f(x)", label="f(x)")
plot!(ftm6, label="6th order")
plot!(ftm7, label="7th order")
savefig(joinpath(@OUTPUT, "taylor1.svg")) # hide

orders = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
anim = @animate for n in orders
    tm = TaylorModel1(n, interval(x0), a)
    ftm = f(tm)
    plot(range(inf(a), stop=sup(a), length=1000), f, lw=2, xaxis="x", yaxis="f(x)", label="f(x)")
    plot!(ftm, title="$(n)th order")
end
gif(anim, joinpath(@OUTPUT, "taylor1_gif.gif"), fps = 2) # hide
nothing # hide

