### A Pluto.jl notebook ###
# v0.11.8

using Markdown
using InteractiveUtils

# ╔═╡ c24f27ce-e560-11ea-0aa9-e9d8c1f06085
using IntervalArithmetic, Plots

# ╔═╡ 9df3c080-e560-11ea-0a27-a91cd629e079
md"## Introduction

The range of a function $f$ is defined as the set $f(X) = \{f(x) | x\in X\}$, where $X$ is the domain of the function.
This tutorial will show how to to exploit interval arithmetic to give a rigorous estimate of the function range.

 First, let's import all the packages we need"

# ╔═╡ d0a3d37e-e560-11ea-062d-634d3bd3e73e
md"## A first example"

# ╔═╡ ff38b8f0-e560-11ea-1bdf-a3c3fc7ab1bd
md"Let's compute the range of the function $f(x)=x^2+2x$ over the interval $[-5, 5]$."

# ╔═╡ 14564d10-e561-11ea-2276-77b7dc4497a7
f(x) = x^2+2x;

# ╔═╡ 0fe0f190-e561-11ea-118f-ddb24412f33c
X = -5..5;

# ╔═╡ f7ed3300-e560-11ea-14e7-e1d29ff22950
begin
	plot(f, -5, 5, leg=false)
	plot!(IntervalBox(X, f(X)))
end

# ╔═╡ 344f92c0-e561-11ea-333c-e7b47cc70c01

md"As can be noticed, in this case we overestimate the range of the function. This is a common issue in interval
arithmetic and it is known as *dependency problem*. If a variable is present more than once in the expression,
then evaluating the function on an interval will overestimate the final interval.
For this simple function, the problem can be solved with simple algebraic manipulation observing that
\begin{equation}
x^2+2x=x^2+2x+1-1=(x+1)^2-1
\end{equation}

The variable $x$ is now present only once and no overestimation occurs, as the program confirms"

# ╔═╡ 7e195800-e561-11ea-2beb-bf5a933fa566
begin
	f1(x) = (x+1)^2-1
	plot(f1, -5, 5, leg=false)
	plot!(IntervalBox(X, f1(X)))
end

# ╔═╡ a0f8f4c0-e561-11ea-2b2d-d198d3e0c74e
range_f = f1(X)

# ╔═╡ a709fee0-e561-11ea-1c45-692a59567fda
md"Despite for this simple example we could analytically solve the dependency problem, this is not possible in general.
The strategy to reduce overestimation in *divide and conquer*. The domain is divided into smaller intervals and the function is evaluated
at each interval. The process of partitioning the interval into smaller piecing is called \"mincing\" and `IntervalArithmetic` offers the function
`mince(X, N)` to divide the interval $X$ into $N$ pieces. This function returns an array of intervals. For example using 10 intervals
"

# ╔═╡ d7a5d7e0-e561-11ea-2559-25e27cd8527f
begin
	Xs = mince(X, 10)
	Y = f.(Xs)
	plot(f, -5, 5, leg=false)
	plot!(IntervalBox.(Xs, f.(Xs)))
end

# ╔═╡ 07d5a8a0-e562-11ea-2430-731b9f37eccb
md"The following animation shows how increasing the number of boxes reduces the overestiamte"

# ╔═╡ ef94b470-e561-11ea-0e53-b535e57a2538
begin
	anim = @animate for i=1:50
	    Xs = mince(X, i)
	    plot(f, -5, 5, leg=false)
	    plot!(IntervalBox.(Xs, f.(Xs)))
	end
	gif(anim, "anim_fps15.gif", fps = 10);
end

# ╔═╡ Cell order:
# ╟─9df3c080-e560-11ea-0a27-a91cd629e079
# ╠═c24f27ce-e560-11ea-0aa9-e9d8c1f06085
# ╟─d0a3d37e-e560-11ea-062d-634d3bd3e73e
# ╟─ff38b8f0-e560-11ea-1bdf-a3c3fc7ab1bd
# ╠═14564d10-e561-11ea-2276-77b7dc4497a7
# ╠═0fe0f190-e561-11ea-118f-ddb24412f33c
# ╠═f7ed3300-e560-11ea-14e7-e1d29ff22950
# ╟─344f92c0-e561-11ea-333c-e7b47cc70c01
# ╠═7e195800-e561-11ea-2beb-bf5a933fa566
# ╠═a0f8f4c0-e561-11ea-2b2d-d198d3e0c74e
# ╟─a709fee0-e561-11ea-1c45-692a59567fda
# ╟─d7a5d7e0-e561-11ea-2559-25e27cd8527f
# ╟─07d5a8a0-e562-11ea-2430-731b9f37eccb
# ╠═ef94b470-e561-11ea-0e53-b535e57a2538
