# This file was generated, do not modify it.

using IntervalArithmetic, IntervalConstraintProgramming

S = @constraint x^2 + y^2 <= 1

X = IntervalBox(-100..100, 2)

inner, outer = S(X)

@show inner

@show outer

S = @constraint -1<=x<=0
X = IntervalBox(-1..1, 1)

@show inner, outer = S(X)

X = IntervalBox(-0.5..0.5, 1)
@show inner, outer = S(X)

S = @constraint 1 <= x^2+y^2 <= 3

X = IntervalBox(-100..100, 2) # our starting box
paving = pave(S, X, 0.125)

using Plots
plot(paving.inner, c="green", aspect_ratio=:equal, label="inner")
plot!(paving.boundary, c="gray", label="boundary")

savefig(joinpath(@OUTPUT, "paving.svg")) # hide

tolerances =  append!(collect(1:-0.1:0.1), collect(0.09:-0.01:0.01))
anim = @animate for tol in tolerances
    paving = pave(S, X, tol)
    plot(paving.inner, c="green", legend=false, title="tol=$tol", aspect_ratio=:equal)
    plot!(paving.boundary, c="gray")
end
gif(anim, joinpath(@OUTPUT, "paving_gif.gif"), fps = 2) # hide
nothing # hide

