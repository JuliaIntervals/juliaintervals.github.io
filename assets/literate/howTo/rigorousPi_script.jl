# This file was generated, do not modify it.

using IntervalArithmetic

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

function forward_S_N(N)
    S_N = @interval(0.0)

    for i in 1:N
        S_N += @interval( 1. /(i^2) )
    end
    S_N
end

N = 10^5
@time rigorous_approx_S_N = forward_S_N(N)

function forward_sum(N)
    S_N = @interval(0.0)
    interval_one = @interval(1.)

    for i in 1:N
        S_N += interval_one / (i^2)
    end

    T_N = interval_one / @interval(N, N+1)
    S = S_N + T_N

    sqrt(6*S)
end

N = 10^6
@time S = forward_sum(N)
@show S, diam(S)

midpoint_radius(S)

big(π) ∈ S

function reverse_sum(N)
    S_N = @interval(0.0)
    interval_one = @interval(1.)

    for i in N:-1:1
        S_N += interval_one / (i^2)
    end

    T_N = interval_one / @interval(N, N+1)
    S = S_N + T_N

    sqrt(6*S)
end

N = 10^6
@time S = reverse_sum(N)
@show S, diam(S)

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

