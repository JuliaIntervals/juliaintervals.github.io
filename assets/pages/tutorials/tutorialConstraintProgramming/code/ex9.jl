# This file was generated, do not modify it. # hide
tolerances =  append!(collect(1:-0.1:0.1), collect(0.09:-0.01:0.01))
anim = @animate for tol in tolerances
    paving = pave(S, X, tol)
    plot(paving.inner, c="green", legend=false, title="tol=$tol", aspect_ratio=:equal)
    plot!(paving.boundary, c="gray")
end
gif(anim, joinpath(@OUTPUT, "paving_gif.gif"), fps = 2) # hide
nothing # hide