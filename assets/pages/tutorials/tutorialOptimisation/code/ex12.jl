# This file was generated, do not modify it. # hide
minval, minimisers = minimise(f, 0..2, tol=1e-3);
@show length(minimisers)