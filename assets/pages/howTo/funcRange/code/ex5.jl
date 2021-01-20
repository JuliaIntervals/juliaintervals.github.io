# This file was generated, do not modify it. # hide
range_10_intervals = reduce(∪, Y)
overestimate_1_interval = (diam(range_1_interval)-diam(range_f))/diam(range_f)
overestimate_10_intervals = (diam(range_10_intervals)-diam(range_f))/diam(range_f)
@show overestimate_1_interval, overestimate_10_intervals

anim = @animate for i=1:50
    Xs = mince(X, i)
    plot(f, -5, 5, leg=false)
    plot!(IntervalBox.(Xs, f.(Xs)))
end
gif(anim, joinpath(@OUTPUT, "anim_range1.gif"), fps = 10)
nothing