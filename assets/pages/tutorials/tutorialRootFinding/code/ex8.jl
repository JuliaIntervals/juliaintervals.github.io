# This file was generated, do not modify it. # hide
h(x) = cos(x) * sin(1 / x)

@btime roots(h, 0.05..1)