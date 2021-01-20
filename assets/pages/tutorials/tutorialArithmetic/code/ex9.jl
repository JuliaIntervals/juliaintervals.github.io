# This file was generated, do not modify it. # hide
a = 0.1

@show big(a)


I = Interval(a)

II = @interval 0.1

correct = big"0.1"
@show correct

@show correct ∈ I
@show correct ∈ II