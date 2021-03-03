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

savefig(joinpath(@OUTPUT, "paving.svg")) #hide

tolerances =  append!(collect(1:-0.1:0.1), collect(0.09:-0.01:0.01))
anim = @animate for tol in tolerances
    paving = pave(S, X, tol)
    plot(paving.inner, c="green", legend=false, title="tol=$tol", aspect_ratio=:equal)
    plot!(paving.boundary, c="gray")
end
gif(anim, joinpath(@OUTPUT, "paving_gif.gif"), fps = 2) #hide
nothing #hide

using ModelingToolkit
vars = @variables x y

f(x, y) = x + y < 3

S = Separator(vars, f)

circle1(x, y) = (x + √3)^2 + (y + 1)^2 - 9/4 < 0
circle2(x, y) = (x - √3)^2 + (y + 1)^2 - 9/4 < 0
circle3(x, y) = x^2 + (y - 2)^2 - 9/4 < 0

S1 = Separator(vars, circle1)
S2 = Separator(vars, circle2)
S3 = Separator(vars, circle3)

X = IntervalBox(-4..4, 2)
anim = @animate for tol in 2.0 .^ (0:-1:-6)
    paving1 = pave(S1, X, tol)
    paving2 = pave(S2, X, tol)
    paving3 = pave(S3, X, tol)
    plot(legend=false, aspect_ratio=:equal)

    plot!(paving1.boundary, color=:gray, alpha=0.5)
    plot!(paving2.boundary, color=:gray, alpha=0.5)
    plot!(paving3.boundary, color=:gray, alpha=0.5)

    plot!(paving1.inner, color=RGB(0.796, 0.235, 0.2))
    plot!(paving2.inner, color=RGB(0.584, 0.345, 0.698))
    plot!(paving3.inner, color=RGB(0.22, 0.596, 0.149))
end

gif(anim, joinpath(@OUTPUT, "julia_logo.gif"), fps = 1) #hide
nothing #hide

