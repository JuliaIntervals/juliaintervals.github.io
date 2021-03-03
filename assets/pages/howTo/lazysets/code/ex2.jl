# This file was generated, do not modify it. # hide
S = @constraint x^2+y^2 + 3*sin(x) + 5*sin(y) <= 1.0

X = IntervalBox(-10..10, 2) # our starting box
paving = pave(S, X, 0.02)