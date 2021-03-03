# This file was generated, do not modify it. # hide
f(x) = x^2+2x
X = -5..5

@show range_1_interval = f(X)

plot(f, -5, 5, leg=false)
plot!(IntervalBox(X, f(X)))