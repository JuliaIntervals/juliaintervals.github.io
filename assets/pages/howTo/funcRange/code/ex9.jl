# This file was generated, do not modify it. # hide
anim = @animate for i in 2 .^(0:10)
    Xs = mince(X, i)
    plot(g, -10, 10, leg=false)
    plot!(IntervalBox.(Xs, g.(Xs)))
end
gif(anim, joinpath(@OUTPUT, "anim_range2.gif"), fps = 2) # hide
nothing # hide