# This file was generated, do not modify it. # hide
function reverse_sum2(N)
    S_N = @interval(0.0)

    for i in N:-1:1
        S_N += 1 / (i^2)
    end

    T_N = 1 / @interval(N, N+1)
    S = S_N + T_N

    sqrt(6*S)
end

N = 10^6
@time S = reverse_sum2(N)
@show S, diam(S)