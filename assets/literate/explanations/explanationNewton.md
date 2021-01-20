<!--This file was generated, do not modify it.-->
## Introduction

This page will explain you how to generalize the traditional Newton method for root-finding
to deal with intervals. Basically, here you will get a taste of what happens under the hood
in the `IntervalRootFinding` when the newton method is used.

## Review: traditional Newton method

It is well know from high-school or undergraduate studies that given an initial guess $x_0$ for the
root of a function $f$, the root can be found iteratively with the upgrade rule

$$
x_{k+1} = x_k - \frac{f(x_k)}{f'(x_k)},
$$

which is known as Newton method. Geometrically, the Newton method is equivalent to the following
geometrical construction, visualized in the animation below

1. Draw the tangent to $f$ passing through the point $(x_k, f(x_k))$
2. The new point $x_{k+1}$ will be the root of the tangent line.

```julia:ex1
using Plots
f(x) = x^3 + 4x^2 + x - 6

plot(f, -2, 2, leg=false)
```

