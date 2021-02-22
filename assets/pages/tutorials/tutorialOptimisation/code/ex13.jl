# This file was generated, do not modify it. # hide
using Plots
plot(f, 1-0.1, 1+0.1, lw=2)
plot!(IntervalBox.(minimisers, f.(minimisers)), legend=false)

savefig(joinpath(@OUTPUT, "clustering.svg")) # hide