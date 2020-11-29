# INTRODUCTION TO INTERVAL ARITHMETIC

@def title = "Introduction to Interval Analysis"
@def hasmath = true

The purpose of this section is to give an overview of the theoretical background behind interval arithmetic. The material of this section is based on *Introduction to Inverval Analysis* from Moore, Kearfott and Cloud.

\toc

## Basic Concepts

The fundamental concept in interval arithmetic is the concept of *interval*. Given a lower bound $\underline{X}$ and an upper bound $\overline{X}$, we define the interval $X$ as the subset $X\subseteq\R$

This is shortly denoted as $X = [\underline{X},~\overline{X}]$.

Particularly, we require that $\underline{X}\leq\overline{X}$, i.e. for example $[3,~5]$, $[-1,~3]$ are valid intervals, but $[3,-1]$ or $[5,3]$ are not.
If $\underline{X}=\overline{X}=x$, then the interval $X=[\underline{X},\overline{X}]=x$ corresponds to the real number $x$, in this case we say that the interval is *degenerate*.

## Basic Operations

Given two intervals $X$ and $Y$ and a binary operation $\circ$, the results is generally defined as

$$
X\circ Y=\{x\circ y~|~x\in X \text{ and }y\in Y\}.$$

Using this definition, the 4 basic arithmetic operations can be defined as follows

> $X+Y=[\underline{X}+\underline{Y},~\overline{X}+\overline{Y}]$ \\
> $X-Y=[\underline{X}-\overline{Y},~\overline{X}-\underline{Y}]$ \\
> $X\cdot Y=[\min S,~\max S]$, where $S=\{\underline{X}\underline{Y},~\underline{X}\overline{Y},~\overline{X}\underline{Y},~\overline{X}\overline{Y}\}$ \\
> $\frac{1}{X}=\left[\frac{1}{\overline{X}},~\frac{1}{\underline{X}}\right]$ with $0\notin X$ \\
> $\frac{X}{Y}=X\cdot\frac{1}{Y}$ with $0\notin Y$ \\

The definitions of our arithmetic operations can be easily derived from (1). Let us now investigate what properties these operations have.

Similar to "normal" arithmetic operations, addition and multiplication are associative and commutative, and have $0$ and $1$ as identity element, respectively.

Opposed to "normal" arithmetic, $X-X\neq 0$, indeed

$X-X=[\underline{X}-\overline{X},~\overline{X}-\underline{X}]$,

now since $\underline{X}\leq\overline{X}$, $X-X=0\Leftrightarrow\underline{X}=\overline{X}$, i.e. if and only if $X$ is a degenerate interval. However, it always hold that $0\in X-X$.

Similarly, we can verify that $1\in\frac{X}{X}$ always, but $1=\frac{X}{X}$ only if $X$ is degenerate.

Another important difference to traditional arithmetic, the distributive property does not hold. Instead, interval arithmetic is *subdistributive*, i.e.

$$A\cdot(B+C)\subseteq A\cdot B+A\cdot C$$

Let's visualize this with an example

$$[1,3]\cdot([1,2]+[-3,-2])=[1,3]\cdot[-2,0]=[-6,0]$$
and

$$[1,3]\cdot[1,2]+[1,3]\cdot[-3,-2]=[1,6]+[-9,-2]=[-8,4]$$

and we notice indeed that $[-6,0]\subseteq[-8,4]$. Let's take another example

$$[1,2]\cdot([1,3]+[2,4])=[1,2]\cdot[3,7]=[3,14]$$
and

$$[1,2]\cdot[1,3]+[1,2]\cdot[2,4]=[1,6]+[2,8]=[3,14]$$
in this no over estimate happens. Moreover, the distributive property $A(B+C)=AB+AC$ holds if $B$ and $C$ have the same sign.
