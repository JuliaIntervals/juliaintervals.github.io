# This file was generated, do not modify it. # hide
X1 = IntervalBox(1..2, 2..3)
X2 = IntervalBox(-1..1, 0..2)

@show X1 + X2
@show sin.(X1)