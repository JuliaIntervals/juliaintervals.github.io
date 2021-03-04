\title{IntervalArithmetic.jl}

\github{https://github.com/juliaintervals/intervalarithmetic.jl}

\toc

## Introduction 
IntervalArithmetic.jl is a Julia package for performing Validated Numerics in Julia, i.e. rigorous computations with finite-precision floating-point arithmetic.

All calculations are carried out using interval arithmetic: all quantities are treated as intervals, which are propagated throughout a calculation. The final result is an interval that is guaranteed to contain the correct result, starting from the given initial data.

The aim of the package is correctness over speed, although performance considerations are also taken into account.

### Authors

- \elink{Luis Benet}{http://www.cicc.unam.mx/~benet/}, Instituto de Ciencias Físicas, Universidad Nacional Autónoma de México (UNAM)
- \elink{David P. Sanders}{http://sistemas.fciencias.unam.mx/~dsanders/}, Departamento de Física, Facultad de Ciencias, Universidad Nacional Autónoma de México (UNAM)

### Contributors

- \elink{krish8484}{https://github.com/krish8484}
- \elink{yashrajgupta}{https://github.com/yashrajgupta}
- \elink{eeshan9815}{https://github.com/eeshan9815}
- \elink{Kolaru}{https://github.com/Kolaru}
- \elink{wormell}{https://github.com/wormell}
- \elink{tkoolen}{https://github.com/tkoolen}
- \elink{mfherbst}{https://github.com/mfherbst}

## Related content

### Docs
- [IntervalArithmetic.jl tutorial](/pages/tutorials/tutorialArithmetic)
- [API docs](/pages/apiDocs/apiIntervalArithmetic/)

### Background

- [Interval functions grimoire](/pages/explanations/intervalFunctionsGrimoire)

### Applications

- [Rigorous approximation of $\pi$](/pages/howTo/rigorousPi)
- [Rigorous function range computation](/pages/howTo/funcRange)