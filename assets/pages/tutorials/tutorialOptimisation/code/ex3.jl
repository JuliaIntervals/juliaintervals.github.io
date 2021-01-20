# This file was generated, do not modify it. # hide
minVal, xmin = minimise(x->(x-3)^2, -∞..∞, tol=1e-9)
xmin, [diam(x) for x in xmin]