<!--
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
-->
@def website_title = "JuliaIntervals"
@def website_descr = "Interval computations with Julia"
@def website_url   = "https://juliaintervals.github.io/"
@def showall = true
@def author = "JuliaIntervals"

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
\newcommand{\elink}[2]{~~~ <a href="#2" target="_blank">#1</a>~~~}
\newcommand{\github}[1]{~~~ <a href="#1" style="margin-left: auto;" target="_blank"><i class="fab fa-fw fa-github" aria-hidden="true"></i> GitHub repository</a> ~~~}

\newcommand{\title}[1]{
@def title = !#1
# !#1
}

\newcommand{\tutorial}[2]{
\title{!#2}

\toc

Download the [notebook](/notebooks/!#1.ipynb) for this tutorial.


\literate{/_literate/!#1.jl}}

<!--
https://raw.githubusercontent.com/tlienart/MLJTutorials/gh-pages/notebooks/!#1.ipynb
-->