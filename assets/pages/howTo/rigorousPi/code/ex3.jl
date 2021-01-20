# This file was generated, do not modify it. # hide
function forward_S_N(N)
    S_N = @interval(0.0)

    for i in 1:N
        S_N += @interval( 1. /(i^2) )
    end
    S_N
end

N = 10^5
@time rigorous_approx_S_N = forward_S_N(N)