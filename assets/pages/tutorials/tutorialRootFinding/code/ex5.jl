# This file was generated, do not modify it. # hide
using BenchmarkTools
@btime roots(log, x->1/x, -2..2)

@btime roots(log, -2..2)