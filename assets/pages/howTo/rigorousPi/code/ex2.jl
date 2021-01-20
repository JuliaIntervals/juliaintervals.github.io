# This file was generated, do not modify it. # hide
function forward_sum_naive(N)
    S_N = 0.0

    for i in 1:N
        S_N += 1. / (i^2)
    end

    S_N
end

S = forward_sum_naive(10000)
err = abs(S - pi^2/6.)  # error
@show S, err