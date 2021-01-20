# This file was generated, do not modify it. # hide
using ForwardDiff

df(x) = ForwardDiff.derivative(f, x)
@show df(1..2)