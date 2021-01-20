<!--This file was generated, do not modify it.-->
## Introduction

Following the book Validated Numerics (Princeton, 2011) by Warwick Tucker, we find *rigorous* (i.e., guaranteed, or validated) bounds on $\pi$ using interval arithmetic, via the `IntervalArithmetic.jl` package.
First, let's import the package

```julia:ex1
using IntervalArithmetic
```

## Calculating $\pi$ via a simple sum

There are many ways to calculate $\pi$. For illustrative purposes, we will use the following sum

$$ S = \sum_{n=1}^\infty \frac{1}{n^2}.$$
It is [known](https://en.wikipedia.org/wiki/Basel_problem) that the exact value is $S = \frac{\pi^2}{6}$. Thus, if we can calculate rigorous bounds on $S$, then we can find rigorous bounds on $\pi$.

The idea is to split $S$ up into two parts, $S = S_N + T_N$, with $ S_N = \sum_{n=1}^N \frac{1}{n^2}$ and $T_N = S - S_N = \sum_{n=N+1}^\infty n^{-2}$.

By bounding $T_N$ using integrals from below and above, we can see that $\frac{1}{N+1} \le T_N \le \frac{1}{N}$. Rigorous bounds on $S_N$ are found by calculating it using interval arithmetic.

$S_N$ may be calculated by summing either forwards or backwards. A naive (non-interval) version could be the following:

```julia:ex2
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
```

## Interval method

To find rigorous bounds for $S_N$, we use interval arithmetic: each term is enclosed in an interval that is guaranteed to contain the true real value. A first idea is simply to wrap each term in the @interval macro, which converts its arguments into containing intervals:

```julia:ex3
function forward_S_N(N)
    S_N = @interval(0.0)

    for i in 1:N
        S_N += @interval( 1. /(i^2) )
    end
    S_N
end

N = 10^5
@time rigorous_approx_S_N = forward_S_N(N)
```

We incorporate the respective bound on $T_N$ to obtain the bounds on $S$, and hence on $\pi$. We can also optimize the code by creating the interval `@interval(1)` only once:

```julia:ex4
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
```

We can ask for the midpoint--radius representation, which shows that the calculated bounds are correct to around 10 decimal places:

```julia:ex5
midpoint_radius(S)
```

We may check that the true value of $\pi$ is indeed contained in the interval:

```julia:ex6
big(π) ∈ S
```

We may repeat the calculation, but now summing in the opposite direction. Due to the way that floating-point arithmetic works, this gives a more accurate answer.

```julia:ex7
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
```

Note that the sqrt function is guaranteed (by the [IEEE 754](https://en.wikipedia.org/wiki/IEEE_754) standard) to give correctly-rounded results, so the resulting bounds on $\pi$ are guaranteed to be correct.

Note also that due to the way that the IntervalArithmetic package works, we can make the code simpler, at the expense of some performance. Only two explicit calls to the `@interval` macro are now required:

```julia:ex8
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
```

