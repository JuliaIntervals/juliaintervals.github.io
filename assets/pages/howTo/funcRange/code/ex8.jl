# This file was generated, do not modify it. # hide
Y, N, err = range(f, X, 3)
@show (Y, N, err)
plot(f, -5, 5, legend=false)
plot!(IntervalBox(X, Y))