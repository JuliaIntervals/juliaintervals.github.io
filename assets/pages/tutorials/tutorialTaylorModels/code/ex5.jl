# This file was generated, do not modify it. # hide
using Plots
plot(range(inf(a), stop=sup(a), length=1000), f, lw=2, xaxis="x", yaxis="f(x)", label="f(x)")
plot!(ftm6, label="6th order")
plot!(ftm7, label="7th order")