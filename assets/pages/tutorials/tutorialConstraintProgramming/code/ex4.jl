# This file was generated, do not modify it. # hide
S = @constraint -1<=x<=0
X = IntervalBox(-1..1, 1)

@show inner, outer = S(X)