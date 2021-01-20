# This file was generated, do not modify it. # hide
for N in (1,2, 10, 20, 50)
    res, xmin = minimise(G, IntervalBox(-600..600, N))
    @show N, res, diam(xmin[1])
end