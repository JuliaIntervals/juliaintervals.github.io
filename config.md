<!--
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
-->
@def website_title = "JuliaIntervals"
@def website_descr = "Interval computations using Julia"
@def website_url   = "https://github.com/JuliaIntervals"
@def prepath = "JuliaIntervalsWebPage"
@def showall = true
@def author = "Luca Ferranti"

@def mintoclevel = 2
@def hasmath = true
@def hascode = true

<!--
Add here files or directories that should be ignored by Franklin, otherwise
these files might be copied and, if markdown, processed by Franklin which
you might not want. Indicate directories by ending the name with a `/`.
-->
@def ignore = ["node_modules/", "franklin", "franklin.pub"]

<!--
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
\newcommand{\mymath}[1]{~~~\( #1 \)~~~}

\newcommand{\tutorial}[2]{
@def title = !#2
# !#2

\toc

Download the [notebook](/notebooks/!#1.ipynb) for this tutorial.


\literate{/_literate/!#1.jl}}

<!--
https://raw.githubusercontent.com/tlienart/MLJTutorials/gh-pages/notebooks/!#1.ipynb
-->