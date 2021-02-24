\title{Interval functions grimoire}

\toc

This article is a quick reference about how different operations on intervals are defined. Unless differently stated we use the following notation

$$
X = [\underline{x}, \overline{x}]\quad
Y = [\underline{y}, \overline{y}]
$$

## Arithmetic operations

$$
\begin{array}{|c|c|}
\hline\text{Operation}&\text{Definition}\\\hline
X + Y&  [\underline{x}+\underline{y}, \overline{x}+\overline{y}] \\\hline
X - Y &[\underline{x}-\overline{y}, \overline{x}-\underline{y}]\\\hline
XY&[\min{S}, \max{S}]\text{ where } \\&S=\{\underline{x}\underline{y}, \underline{x}\overline{y}, \overline{x}\underline{y}, \overline{x}\overline{y}\}\\\hline
\frac{1}{X}&\left[\frac{1}{\overline{x}}, \frac{1}{\underline{x}}\right]\text{ if } 0 \notin X\\
& [-\infty, \infty]\text{ if }\underline{x}<0<\overline{x}\\
& \left[\frac{1}{\overline{x}}, \infty \right]\text{ if }\underline{x}=0\neq\overline{x}\\
& \left[-\infty, \frac{1}{\underline{x}}\right]\text{ if }\underline{x}\neq 0=\overline{x}\\
&\emptyset\text{ if } X = [0, 0]\\\hline
\frac{X}{Y}&X\cdot\frac{1}{Y}\\\hline
\end{array}
$$

## Set operations

$$
\begin{array}{|c|c|}
\hline \text{Operation}&\text{Definition}\\\hline
X \cap Y&[\max(\underline{x}, \underline{y}), \min(\overline{x}, \overline{y})]\text{ if }\max(\underline{x}, \underline{y})\leq \min(\overline{x}, \overline{y})\\
&\emptyset\text{ otherwise}\\\hline
X \cup Y&[\min(\underline{x}, \underline{y}), \max(\overline{x}, \overline{y})]\\\hline
\end{array}
$$

## Comparisons

$$
\begin{array}{|c|c|}
\hline \text{Operation}&\text{Definition}\\\hline
X \lesseqgtr Y&\underline{x}\lesseqgtr\underline{y}\land\overline{x}\lesseqgtr\overline{y}\\\hline
X\subseteq Y& \underline{y}\leq \underline{x} \land \overline{x}\leq\overline{y}\\\hline
\end{array}
$$

## Scalar functions
All the following functions return `NaN` if the interval is empty.
$$
\begin{array}{|c|c|}
\hline \text{Operation}&\text{Definition}\\\hline
\text{inf}(X)&\underline{x}\\\hline
\text{sup}(X)&\overline{x}\\\hline
\text{mid}(X)&\frac{\underline{x}+\overline{x}}{2}\\\hline
\text{diam}(X)&\overline{x}-\underline{x}\\\hline
\text{rad}(X)&\frac{\text{diam}(X)}{2}\\\hline
\text{mag}(X)&\max\{|x|:x\in X\}\\\hline
\text{mig}(X)&\min\{|x|:x\in X\}\\\hline
\end{array}
$$