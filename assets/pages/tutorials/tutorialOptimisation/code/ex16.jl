# This file was generated, do not modify it. # hide
minval, minimisers = minimise(X -> mean_value_form(f, X), 0..2, tol=1e-6);
@show length(minimisers)
@show minimisers