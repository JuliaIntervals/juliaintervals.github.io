# This file was generated, do not modify it. # hide
using ForwardDiff

mean_value_form(f, X) = f(mid(X)) + ForwardDiff.derivative(f, X)*(X - mid(X))