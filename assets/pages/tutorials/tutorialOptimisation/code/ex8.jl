# This file was generated, do not modify it. # hide
G(X) = 1 + sum(abs2, X) / 4000 - prod( cos(X[i] / √i) for i in 1:length(X) )