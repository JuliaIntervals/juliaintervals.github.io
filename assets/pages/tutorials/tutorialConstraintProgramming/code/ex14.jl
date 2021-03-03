# This file was generated, do not modify it. # hide
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