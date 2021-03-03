# This file was generated, do not modify it. # hide
function dg( (x, y) )
    return SMatrix{2, 2}(cos(x), 0, 0, -sin(y))
end

@btime roots(g, dg, X)
@btime roots(g, X)
nothing # hide