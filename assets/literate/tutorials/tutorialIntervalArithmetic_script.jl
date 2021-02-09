# This file was generated, do not modify it.

using IntervalArithmetic

f(x) = (1/80) * log(abs(3*(1 - x) + 1)) + x^2 + 1 # hide
using Plots # hide
p1 = plot(0.5:0.01:2.0, f, leg=false) # hide
p2 = plot(1.2:0.0001:1.5, f, leg=false) # hide
plot(p1, p2, layout=(1,2), leg=false) # hide

savefig(joinpath(@OUTPUT, "intMotivation.svg")) # hide

x = 4/3
f(x) = 1/80 * log(abs(3*(1 - x) + 1)) + x^2 + 1
@show f(x)

f(prevfloat(x))
f(nextfloat(x))

a = 1..2
@show a

b = 2..1

2 ± 1

a = @interval(1,2)

b = interval(1, 2)

c = interval(1)

d = @interval 1

@show a, b, c, d

@interval sin(0.2)+cos(1.3)-exp(0.4)

a = 0.1

@show big(a)

correct = big"0.1"
@show correct

I = interval(a)

II = @interval 0.1
III = a..a

@show correct ∈ I
@show correct ∈ II
@show correct ∈ III

X = 1..2
Y = 3..4

@show X ∩ Y # typed \cap<TAB
@show X ∪ Y # TYPED \cup<TAB>
@show X + Y
@show X*Y
@show X^3
@show X/Y

X = 1..2

Y = -1..1

Z = 0..2

@show X/Y

@show X/Z

X-X

X/X

Z*(X+Y)

Z*X+Z*Y

@show sin(0..2/3*π)

@show  log(-3.. -2)

@show log(-3..2)

@show  √(-3..4)

f(x) = (1/80) * log(abs(3*(1 - x) + 1)) + x^2 + 1
x = @interval 4/3
@show f(x)

f(x) = x^2+3x-1

X = -2..2

@show f(X)

@show f(-2.. -1.5) ∪ f(-1.5.. 2)

f(x) = x^2 - 2
@show f(3..∞)
@show 0 ∈ f(3..∞)

f(1..2)

using ForwardDiff

df(x) = ForwardDiff.derivative(f, x)
@show df(1..2)

X1 = IntervalBox(1..2, 2..3, 3..4)
X2 = IntervalBox(1..2, 3..4)
X3 = IntervalBox(1..2, 5)

@show X1
@show X2
@show X3

X1 = IntervalBox(1..2, 2..3)
X2 = IntervalBox(-1..1, 0..2)

@show X1 + X2
@show sin.(X1)

f(x) = x^2 + 3x - 1
X = -2..2
f1 = f(X)

X2 = [-2.. -1.5, -1.5..2]
f2 = f.(X2)

box1 = IntervalBox(X, f1)
box2 = IntervalBox.(X2, f2)

nothing # hide

using Plots
plot(box1)
plot!(box2)
plot!(f, -2, 2, leg=false, color=:black, linewidth=2)

savefig(joinpath(@OUTPUT, "plotBoxes.svg")) # hide

