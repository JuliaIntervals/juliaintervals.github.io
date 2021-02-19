# This file was generated, do not modify it. # hide
function range(f, X, N, tol=0.01)

    Xs = mince(X, N)
    Ynext = f.(Xs)
    Ynext = reduce(∪, Ynext)
    err = tol+1

    while err > tol
        Yprev = Ynext
        N *= 2
        Xs = mince(X, N)
        Ynext = f.(Xs)
        Ynext = reduce(∪, Ynext)
        err = (diam(Yprev) - diam(Ynext))/diam(Yprev)
    end

    return (Ynext, N, err)
end