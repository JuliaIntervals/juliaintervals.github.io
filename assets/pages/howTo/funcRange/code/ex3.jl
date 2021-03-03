# This file was generated, do not modify it. # hide
f1(x) = (x+1)^2-1
@show range_f = f1(X)

plot(f1, -5, 5, leg=false)
plot!(IntervalBox(X, f1(X)))