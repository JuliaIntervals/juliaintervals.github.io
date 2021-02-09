# This file was generated, do not modify it. # hide
f(x) = (1/80) * log(abs(3*(1 - x) + 1)) + x^2 + 1 # hide
using Plots # hide
p1 = plot(0.5:0.01:2.0, f, leg=false) # hide
p2 = plot(1.2:0.0001:1.5, f, leg=false) # hide
plot(p1, p2, layout=(1,2), leg=false) # hide

savefig(joinpath(@OUTPUT, "intMotivation.svg")) # hide